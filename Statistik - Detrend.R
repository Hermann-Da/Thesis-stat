
#########################
# PCA 
#########################
# Scale = TRUE, damit wird die Korrelationsmatrix verwendet
# Scale = FALSE, damit wird die Kovarianzmatrix verwendet


PCA_n <- prcomp(Data$Spectra_n[!is.na(Data$Groups),Sample],
                  center = TRUE,rank.=5, scale. = TRUE )

# Damit "NAs" entfernen, um die Farben richtig darzustellen
PCA_n$Groups <- Data$Groups[!is.na(Data$Groups)]

summary(PCA_n)

######################
# Erklärte Varianz pro Principal Component
#####################

# Varianz ausgeben
Data$Variance_n <- PCA_n$sdev^2/sum(PCA_n$sdev^2)


#My.export_start("Variance_n")

plot(x= 1:length(Data$Variance_n), y = cumsum(Data$Variance_n[1:length(Data$Variance_n)]*100),
     type = "b", xlab = "Number of Principal Components",
     ylab = "Explained Variance [%]",
     col = "dimgrey", pch = 21, bg = "darkgrey",
     font = 2, font.lab = 2,lab = c(5,10,10))

#My.export_end()


########################
# Loadings ausgeben
#######################

#My.export_start("Loadings_n")

plot.load(Variab = Data$Wavenumber[Sample], Load = PCA_n)

#My.export_end()

#####################
# Scorewerte plotten, überblicksmäßig
#####################


#My.export_start("Scores_ges_n_Spectra")

pairs(PCA_n$x[,1:3],col=Data$Groups, pch = 19)
legend("bottomright", legend=levels(Data$Groups), pch=19, col=unique(Data$Groups), inset = 0.05,
       horiz = FALSE, bty = "n")

#My.export_end()

#####################
# Plotten der ScoreWerte einzelner PCA's
####################

X_Ax = 1 #PC auswählen (X-Achse)
Y_Ax = 2 #PC auswählen (Y-Achse)

# My.export_start("_Scores_PC1_2")

plot(x = PCA_n$x[,X_Ax], y = PCA_n$x[,Y_Ax],
     xlab = paste("Scores of","PC" ,X_Ax, "[",round(Data$Variance_n[X_Ax]*100,1),"%]", sep = " "),
     ylab = paste("Scores of","PC" ,Y_Ax, "[",round(Data$Variance_n[Y_Ax]*100,1),"%]", sep = " "),
     col = Data$Groups[!is.na(Data$Groups)], 
     pch = 19, font.lab = 2)
grid(lwd = 0.8)
abline(h = 0, v = 0)
legend("bottomleft", legend=levels(Data$Groups[!is.na(Data$Groups)]), 
       pch=16, col=unique(Data$Groups[!is.na(Data$Groups)]), inset = 0.01, bty = "n")
# My.export_end()

###################################
# Ausreißer identifizieren mit identify
###################################
# Entkommentieren und ausführen, gibt Indexzes der gewählten Punkte aus

#Ausreißer = identify( x = PCA_n$x[,X_Ax], y = PCA_n$x[,Y_Ax])



###################################
# Hierarchical clustering Analysis
###################################

#My.export_start("HCA_n_Spectra")


HCA(Data$Spectra_n[!is.na(Data$Groups),],Data$Groups[!is.na(Data$Groups)])
legend("topright", legend=levels(Data$Groups[!is.na(Data$Groups)]), 
       pch=16, col=unique(Data$Groups[!is.na(Data$Groups)]), inset = 0.01, bty = "n")

#My.export_end()

###################################
# PCA und Hierarchical clustering Analysis
###################################

#My.export_start("PCA_HCA_n_Spectra")

HCA(Data = PCA_n$x[,1:3],Groups = Data$Groups[!is.na(Data$Groups)])
legend("topright", legend=levels(Data$Groups[!is.na(Data$Groups)]), 
       pch=16, col=unique(Data$Groups[!is.na(Data$Groups)]), inset = 0.01, bty = "n")
#My.export_end()
