# Skript Dokumentation
[[_TOC_]]
## Wiki Seiten Erstellung
### 0-fillMaster
Normdata anreicherung

Anhand der gnd/getty Id werden 
``` https://query.wikidata.org/bigdata/namespace/wdq/sparql ```

 sparql befehl ausgeführt, um Normadaten zu erhalten
 
### 01-Werkseiten.xsl
Erstellung der Werkseiten
* svg Erstellung
* Timeline aufruf
* Template einbindung
* Referenzierung
* * Attribut vergabe
* * 
* editionshinweis

### 02-QuellenEinzelseiten.xsl
Extraktion der Quellenstellen innerhalb der Werke 
* set einstellung
* Template einbindung


### 03-Kategorienseiten.xsl
Erstellung dynamischer Kategorien innerhalb der masterfassung
* Aufruf geographischer Kategorien

### 04-Registerseiten.xsl
Erstellung von entity/register Seiten.
Verknüpfung der Alternativnamen innerhalb der Masterfassung mit den Registerelementen.
Erkennung der nennung von Elementen in mehreren Kategorien.
* Erkennung der Verlinkungen
* Generierung der Redirect Seiten zu den Hauptseiten
* Erstellung der Register
* * Personen
* * VerfasserIn
* * Geographie
* * * Abfassungort
* * * Gewässer
* * * Kloster
* * * Ort
* * * Berg
* * * Region
* * Schlagworte
* * Auffälligkeiten

### 06-static-files.xsl
Transformation der in files/static-files/* angelegten Dokumente von HTML/XML Syntax in valide Mediawikisyntax

## Splitting
Zusammenführung aller in output angelegten Dateien in eine große XMl, von dort aufteillung in 1000 Seiten große XML inklusive ID vergabe.
Auf 1000 maximiert, da der automatische Import nur 1000 Wikiseiten pro Upload unterstützt

### 101-merge.xsl
Zusammenführung aller in output vorhanden XML Dateien zu einer allgemein gültigen Datei

### 102-split.xsl
Generierung mehrerer XML Dateien, jede XML enthält 1000 Wikiseiten. Verggibt IDs