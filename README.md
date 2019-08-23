# Thesis-stat
Collection of R-scripts for preprocessing and statistical analysis of Raman/IR spectra
Die  Spektren  müssen als TXT File vorliegen, mit den Wellenzahlen in der ersten Spalte (V1),
und den Intensitätswerten in der zweiten Spalte (V2). 
Ein R-Project sollte erstellt werden, dieses enthält folgende Ordner:

	- "Files"... enthält alle Skripten:
	   + "Funktionen" Skript.. enthält alle zu verwendenden Funktionen und Packages, kann unverändert bleiben
	   + "Datenvorbehandlung" Skript.. Hiermit können die Daten eingelesen werden und die 
	     diversen Vorbehandlungen (Ableitung, SNV, Detrend) der Spektren durchgeführt werden. 
	   + "Dokumentation" Skript.. Hier können der Spektrale Bereich eingeschränkt werden und die Ausreißer
	     entfernt werden. 
	   + "Statistik - ____" Skript.. Diese Skripten enthalten die statistischen Methoden (PCA,HCA)
	     für die jeweiligen Vorbehandlungen (SNV, Detrend, Ableitung)
	   + "Spectra-Loading" Skript.. enthält die Möglichkeiten die Mittelwertsspektren der Gruppen und die 
	     Loadings gemeinsam zu plotten, sowie die Möglichkeit Score-plots mit unterschiedlichen Symbolen
	     zu erstellen. 
	- "Graphs"... hier werden die generierten Graphen abgespeichert
	- "Raw_data"... hier liegen die Originaldaten, die Txt Files der Spektren. 
	   Dieser Ordner kann aber auch anders benannt werden, dann mus der Pfad in der
	   "My.Import" Funktion geändert werden. 
Nachdem man die Rohdaten im "Raw_data" Ordner platziert hat, oder in dem selbst gewählten Pfad, kann man das 
R-Project öffnen und das Datenvorbehandlungsskript starten. Wenn man den "Raw_data" Ordner verwendet, kann man
den Location Parameter der "My.Import" Funktion beibehalten, sonst muss man den gewünschten Dateipfad eingeben. 
Den Gruppen Parameter übergibt man nun einen Vektor der die Namen der Gruppen enthält, dabei darauf achten, dass
diese in den TXT File-Namen vorkommen und eindeutig sind. Hat man dies verändert, kann man das Skript bis vor 
den Punkt "Basislinien Korrektur" ausführen. Nun hat man die Möglichkeit, die Spektren Basislinien zu 
korrigieren, SNV anzuwenden, eine Ableitung durchzuführen oder die detrend Funktion (Basislinien Korrektur und
SNV) anzuwenden. 
Will man die dabei generierten Grafiken speichern, muss man die "My.export_Start" und die "My.export_end" 
Funktion entkommentieren und mitausführen (Dies gilt für alle Skripten)
Hat man die ausreichenden Vorbehandlungen durchgeführt, kann man das passende "Statistik" Skript öffnen und
Punkt für Punkt ausführen. 
Will man aufgrund dieser Ergbenisse die Auswertung anpassen, ist das "Dokumentations" Skript zu öffnen, hier 
können der spektrale Bereich eingeschränkt werden und die Ausreißer entfernt werden. Wenn man dieses Skript 
ausführt, muss man anschließend das passende "Statistik" Skript wieder ausführen. 
Um das "Loadings-Spectra" Skript verwenden zu können, müssen die statistischen Analysen bereits durchgeführt 
worden sein. 


