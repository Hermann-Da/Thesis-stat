###################
#Dokumentationsverlauf
###################
# Versionsnummer ist in der Export Funktion hinterlegt
# Wenn Änderungen durchgeführt werden -> Kopieren und ändern
# Dann Versionsnummer ändern


##############################################################################################
# Kopieren Anfang

Version <- "_001"

##################
# Spektralen Bereich einschränken 
##################

# Mit SNV oder detrend: 
## Wenn mehr Bereiche gewünscht sind, mehr Limits setzen und Sample anpassen

Limit1 <- which(Data$Wavenumber > 1700) # oberes Limit
Limit2 <- which(Data$Wavenumber < 400)  # Unteres Limit

Sample <- c(min(Limit1):max(Limit2))

# Hier sind nur die maximal und minimal Werte gefragt
Range <- c(Data$Wavenumber[min(Limit1)],Data$Wavenumber[max(Limit2)])

# Mit Ableitung

# Limit1 <- which(Data$Wavenumber_d > 1700)
# Limit2 <- which(Data$Wavenumber_d < 400)
# 
# Range <- c(Data$Wavenumber_d[min(Limit1)],Data$Wavenumber_d[max(Limit2)])
# 
# Sample_d <- c(min(Limit1):max(Limit2))

##################
# Entfernen von Ausreißern
##################

# Ausreißer mit Identify akzeptieren
# Hier notieren, damit die Modifikation nachvollziehbar ist 

Ausreißer <- c()
Data$Groups[Ausreißer] <- NA # Data$Groups ist verlinkt, NA Werte werden ausgelassen

# Kopieren Ende
##############################################################################################

##############################################################################################
# Kopieren Anfang

Version <- "_002"

##################
# Spektralen Bereich einschränken 
##################

# Mit SNV oder detrend: 

Limit1 <- which(Data$Wavenumber > 1280)
Limit2 <- which(Data$Wavenumber < 900)

Range <- c(Data$Wavenumber[min(Limit1)],Data$Wavenumber[max(Limit2)])

Sample <- c(min(Limit1):max(Limit2))

# Mit Ableitung

# Limit1 <- which(Data$Wavenumber_d > 1700)
# Limit2 <- which(Data$Wavenumber_d < 400)
# 
# Range <- c(Data$Wavenumber_d[min(Limit1)],Data$Wavenumber_d[max(Limit2)])
# 
# Sample_d <- c(min(Limit1):max(Limit2))

##################
# Entfernen von Ausreißern
##################

# Ausreißer mit Identify akzeptieren
# Hier notieren, damit die Modifikation nachvollziehbar ist 

Ausreißer <- c()
Data$Groups[Ausreißer] <- NA # Data$Groups ist verlinkt, NA Werte werden ausgelassen

# Kopieren Ende
##############################################################################################
