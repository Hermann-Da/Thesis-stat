###############
##Load Packages
##############
# Require function um zu überprüfwen, ob das Package da ist
# Liste der benötigten Packages
# Bei Bedarf erweitern
Packages <- c("prospectr","dendextend","baseline","pls","plotrix")

for (p in 1:length(Packages)) {
  test <- require(Packages[p], character.only = TRUE) #Lädt Package oder gibt FALSE aus
  if(test == FALSE){
    install.packages(Packages[p]) #installiert Packages wenn nicht vorhanden
    library(Packages_p)
  }
}

# Entfernen von Variablen um das Environment zu reduzieren
rm(test) 
rm(Packages)
rm(p)


#########################
##Import Funktion
#########################
# Location: Der Pfad zu den Txt. files
# Gruppen: String Vektor der Gruppennamen (Müssen in den File namen vorkommen)
# Maximal 8 Gruppen sind farbtechnisch moeglich 

My.Import <- function(Location = "./Raw_data", Gruppen = Files) {
  
  #Liste von Txt. Files in Location
  Files <- list.files(path = Location, pattern = ".TXT")
  
    import <- function(data) {
      start <- getwd() ##store Start wd
      setwd(Location) ### setwd to Data file
      
      df <- try(read.csv(data, header = FALSE, ##data als Funktionsparameter und hier
                         sep = ",",           ## df ist ein Zwischenspeicher    
                         dec = "." ))          ## Try um Fehler zu überspielen
      setwd(start) ## back to normal
      return(df)  ###Speicher in Variable übertragen
    }
    
    #Auslesen der Dateien
    Raw.list <- lapply(Files,import)
    
    #Liste an Dataframes in einen überführen
    Raw.data <- do.call("cbind", Raw.list)
    
    # Wellenzahlen entfernen
    Spectra <- as.data.frame(t(Raw.data[,-c(which(colnames(Raw.data) == "V1"))]))
    
    # Wellenzahlen extrahieren und als Colnames setzen
    Wavenumber <- as.numeric(Raw.data[,1])
    colnames(Spectra) <- Wavenumber
    
    ###Ueberpruefen ob ein Gruppenvektor vorhanden ist, sonst Filenamen nehmen
    if(Gruppen[1] != Files[1]){
    ##### Gruppenvektor erstellen
    Groups <- c(1:length(Files))
        for (i in 1:length(Gruppen)){
        Pos <- c(grep(pattern = as.character(Gruppen[i]), x = Files)) ##grep erkennt Bestandteile von Filenamen
        Groups[Pos] <- Gruppen[i] ###Füllt Vektor auf
        }
    }else{
      Groups <- sub(pattern = ".TXT",x= Gruppen, replacement = "")
    }
    #####Erstelle eine Liste mit Gruppen, Wavenumber, Spektren
    ###Zur Besseren Organisation
    OriginalData <- list(Wavenumber,Spectra,as.factor(Groups))
    
    names(OriginalData) <- c("Wavenumber","Spectra","Groups")
  
    return(OriginalData)
}


#########################
##Export Funktion für png Export
#########################
# Resolutiondefault =  600 DPI
# title = Genauere Bezeichnung der Grafik (String), z.B.: "Loadings"
# Der File name wird erweitert um die Projektbezeichnung und die version (Siehe Dokumentation script)

# Vor der zu exportierenden Grafik positionieren
My.export_start <- function(title) {
  setwd("./Graphs")
  png(filename = paste(title,Project,Version,".png", sep = ""), 
         height = 11, width = 15, units = "cm",
         res = 600, pointsize = 8) ##Fuer Power Point -> Pointsize auf ca. 11 stellen
}

# Nach der zu exportierenden Grafik positionieren
My.export_end <- function() {
  dev.off()  # Beendet Export
  setwd("../") # working directionary zurück auf default
}

#########################
#Hierarchical clustering analysis
#########################
# Data = Matrix der Daten (Variablen in columns, Proben in rows)
# Groups = Vektor der Gruppierung der Daten 

HCA <- function(Data,Groups) {
  d <- dist(Data,method = "euclidean") #Distanzmatrix erzeugen
  hca <- hclust(d, method = "ward.D2") #Histogramm erstellen
  ##Gruppen und Farben bestimmen
  dend <- as.dendrogram(hca) #Fürs dendextend-package verwendbar machen
  colors_to_use <- as.numeric(Groups)[order.dendrogram(dend)] #Farben mit der Ordnung des Histograms speichern
  Label <- Groups #Labels erstellen
  labels_colors(dend) <- colors_to_use # Labels einfärben
  labels(dend) <- Label[order.dendrogram(dend)] #Labels ordnen 
  plot(dend, font.lab = 2, ylab = "Heterogenity") #plot
  
}

#########################
#Loadings plotten 
#########################
# Plottet nacheinander alle angegebenen PCS
# Default sind die ersten 3 PCs
# Variab = Vektor der verwendeten Wellenzahlen
# Load = PCA object, dessen Loadings geplottet werden sollen
# PCs = String vektor der zu plottenden Principal Components, default sind PC1 bis 3
# 

plot.load <- function(Variab,Load,PCs = c("PC1","PC2","PC3")){
  
  Variance <- Load$sdev^2/sum(Load$sdev^2) # Berechnung der erklärten varianz pro PC
  
# Schleifenfunktion arbeitet die PCs ab  
  for (i in 1:length(PCs)) {
    plot(x= Variab, y = Load$rotation[,PCs[i]],
         type = "l", xlab = "Wavenumber [1/cm]",
         ylab = paste("Loadings of",PCs[i], "[",round(Variance[i]*100,1),"%]", sep = " "), # Erklärte Varianz wird in der y- Achse vermerkt 
         font = 2,font.lab = 2,
         lab = c(20,15,10),
         col = "dimgrey",xlim = c(max(Variab),min(Variab)), xaxs = "i", bty = "l")
    abline(h = 0, lwd = 0.8, lty = "dashed") # Null Linie einfügen zur besseren Interpretation
    grid(lwd = 0.8)
  }
  
}

#########################
#Spektren plotten 
#########################
# Liste = Datenliste mit Wavenumber, Spectra, Groups
# Spektren = Welche Spektren sollen geplottet werden
# Wellenzahl = Vektor der Wellenzahlen
# area = Welcher Bereich soll geplottet werden
# Code = Faktor vektor, ordnet die Farben zu 
# Bereich = Welche Wellenzahlen werden ausgewählt

plot.spectra <- function(Liste,Spektren,Wellenzahl = Liste$Wavenumber,
                         area = c(max(Wellenzahl),min(Wellenzahl)), Code = Liste$Groups, 
                         Bereich = Sample){
  
  matplot(x = Wellenzahl[Bereich],
          y = t(as.matrix(Liste[[Spektren]][,Bereich])),lty = 1, type = "l", col = Code,
          xlab = "Wavenumber [1/cm]",
          ylab = "Intensity [-]",
          font = 2, font.lab = 2,  ###font = 2 ist Fett gedruckt
          lab = c(20,15,10), xlim = area,
          ylim = c(min(Liste[[Spektren]][,Bereich]),max(Liste[[Spektren]][,Bereich])), bty = "l", family = "sans", xaxs = "i")
  grid(lwd = 0.8)
}




