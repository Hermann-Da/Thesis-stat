
#########################
# PCA 
#########################
# Scale = TRUE, damit wird die Korrelationsmatrix verwendet
# Scale = FALSE, damit wird die Kovarianzmatrix verwendet


PCA_SNV <- prcomp(Data$Spectra_SNV[!is.na(Data$Groups),Sample],
                  center = TRUE,rank.=5, scale. = TRUE )

# Damit "NAs" entfernen, um die Farben richtig darzustellen
PCA_SNV$Groups <- Data$Groups[!is.na(Data$Groups)]

summary(PCA_SNV)

######################
# Erklärte Varianz pro Principal Component
#####################

# Varianz ausgeben
Data$Variance_SNV <- PCA_SNV$sdev^2/sum(PCA_SNV$sdev^2)


#My.export_start("Variance_SNV")

plot(x= 1:length(Data$Variance_SNV), y = cumsum(Data$Variance_SNV[1:length(Data$Variance_SNV)]*100),
     type = "b", xlab = "Number of Principal Components",
     ylab = "Explained Variance [%]",
     col = "dimgrey", pch = 21, bg = "darkgrey",
     font = 2, font.lab = 2,lab = c(5,10,10))

#My.export_end()


########################
# Loadings ausgeben
#######################

#My.export_start("Loadings_SNV")

plot.load(Variab = Data$Wavenumber[Sample], Load = PCA_SNV)

#My.export_end()

#####################
# Scorewerte plotten, überblicksmäßig
#####################


#My.export_start("Scores_ges_SNV_Spectra")

pairs(PCA_SNV$x[,1:3],col=Data$Groups, pch = 19)
legend("bottomright", legend=levels(Data$Groups), pch=19, col=unique(Data$Groups), inset = 0.05,
       horiz = FALSE, bty = "n")

#My.export_end()

#####################
# Plotten der ScoreWerte einzelner PCA's
####################

X_Ax = 1 #PC auswählen (X-Achse)
Y_Ax = 2 #PC auswählen (Y-Achse)

# My.export_start("_Scores_PC1_2")

plot(x = PCA_SNV$x[,X_Ax], y = PCA_SNV$x[,Y_Ax],
     xlab = paste("Scores of","PC" ,X_Ax, "[",round(Data$Variance_SNV[X_Ax]*100,1),"%]", sep = " "),
     ylab = paste("Scores of","PC" ,Y_Ax, "[",round(Data$Variance_SNV[Y_Ax]*100,1),"%]", sep = " "),
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

#Ausreißer = identify( x = PCA_SNV$x[,X_Ax], y = PCA_SNV$x[,Y_Ax])



###################################
# Hierarchical clustering Analysis
###################################

#My.export_start("HCA_SNV_Spectra")


HCA(Data$Spectra_SNV[!is.na(Data$Groups),],Data$Groups[!is.na(Data$Groups)])
legend("topright", legend=levels(Data$Groups[!is.na(Data$Groups)]), 
       pch=16, col=unique(Data$Groups[!is.na(Data$Groups)]), inset = 0.01, bty = "n")

#My.export_end()

###################################
# PCA und Hierarchical clustering Analysis
###################################

#My.export_start("PCA_HCA_SNV_Spectra")

HCA(Data = PCA_SNV$x[,1:3],Groups = Data$Groups[!is.na(Data$Groups)])
legend("topright", legend=levels(Data$Groups[!is.na(Data$Groups)]), 
       pch=16, col=unique(Data$Groups[!is.na(Data$Groups)]), inset = 0.01, bty = "n")
#My.export_end()
