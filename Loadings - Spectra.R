###################################
### Loadings und Mittelwert Spectra plotten
###################################
# In dem Fall für Spectra_n
# Sonst suchen und ersetzen von "_n" durch "_SNV" oder "_d" 
# Bzw. bei "_d":
# Sample <- Sample_d

# Mittelwerte Berechnen, für mehrere Gruppen kopieren und A, B austauschen
A <- apply(Data$Spectra_n[which(Data$Groups== "A"),], 
                   2, FUN = mean)

B <- apply(Data$Spectra_n[which(Data$Groups== "B"),], 
                   2, FUN = mean)
# Erklärte Varianz berechnen 
Variance <- PCA_n$sdev^2/sum(PCA_n$sdev^2)



# My.export_start("Loadings_Spectra")
plot(NULL,
     type = "l", xlab = "Wavenumber [1/cm]", # Keine Achsenbeschriftung, weil nur relativ zueinander wichtig ist. 
     font = 2,font.lab = 2,                  # Außerdem sind es verschiedene Einheiten
     lab = c(20,15,10), 
     ylim = c(min(Data$Spectra_n[,Sample]),max(Data$Spectra_n[,Sample])),
     xlim = Range, xaxs = "i", bty = "l")
abline(h = 0, lwd = 0.8, lty = "dashed")
grid(lwd = 0.8)
lines(x= Data$Wavenumber[Sample], y = A[Sample], col = "black")
lines(x= Data$Wavenumber[Sample], y = B[Sample], col = "red")
lines(x= Data$Wavenumber[Sample], y = PCA_n$rotation[,1]*25, col = "darkgrey") # Multiplikationsfaktor anpassen
lines(x= Data$Wavenumber[Sample],                                              # Je nachdem, was gut sichtbar ist
      y = PCA_n$rotation[,2]*50, col = "darkgrey", lty = "dashed") 
legend("topleft", legend=levels(Data$Groups), pch=16, 
       col=unique(Data$Groups[!is.na(Data$Groups)]), inset = 0.001, bty = "n",
       horiz = FALSE)
# My.export_end()

###################################
### Scores mit verschiedenen Symbolen
###################################
# Bei Points "pch" ändern für andere Symbole, siehe "points" EIntrag. 

# My.export_start("Scores_Refined")
plot(NULL,xlab = paste("Scores of", "PC",X_Ax, "[",round(Data$Variance_n[X_Ax]*100,1),"%]", sep = " "),
     ylab = paste("Scores of","PC" ,Y_Ax, "[",round(Data$Variance_n[Y_Ax]*100,1),"%]", sep = " "),
     col = Data$Groups[!is.na(Data$Groups)], lab = c(10,10,10),
     font.lab = 2, font = 2, xlim = c(min(PCA_n$x[,X_Ax]),max(PCA_n$x[,X_Ax])),
     ylim = c(min(PCA_n$x[,Y_Ax]),max(PCA_n$x[,Y_Ax]))
)
grid(lwd = 0.8)
abline(h = 0, v = 0)
points(x = PCA_n$x[which(PCA_n$Groups == "A"),X_Ax],
       y = PCA_n$x[which(PCA_n$Groups == "A"),Y_Ax], pch = 15, col = "black")
points(x = PCA_n$x[which(PCA_n$Groups == "B"),X_Ax],
       y = PCA_n$x[which(PCA_n$Groups == "B"),Y_Ax], pch = 19, col = "red")
legend("bottomleft", legend=levels(Data$Groups[!is.na(Data$Groups)]),
       pch=c(15,19,17), col=unique(Data$Groups[!is.na(Data$Groups)]), 
       inset = 0.01, bty = "n", cex = 1.1)
# My.export_end()

