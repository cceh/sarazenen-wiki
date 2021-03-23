# Skript Dokumentation

## 0-fillMaster
Normdata anreicherung

Anhand der gnd/getty Id werden 
``` https://query.wikidata.org/bigdata/namespace/wdq/sparql ```

 sparql befehl ausgeführt, um Normadaten zu erhalten
 
## 1-Werkseiten.xsl
Erstellung der Werkseiten
* svg Erstellung
* Timeline aufruf
* Template einbindung
* Referenzierung
* set einstellung
* editionshinweis

## 2-QuellenEinzelseiten.xsl
Extraktion der Quellenstellen innerhalb der Werke 
* set einstellung
* Template einbindung


## 3-Kategorienseiten.xsl
Erstellung dynamischer Kategorien innerhalb der masterfassung
* Aufruf geographischer Kategorien

## 4-Registerseiten
Erstellung von entity/register Seiten.
Verknüpfung der Alternativnamen innerhalb der Masterfassung mit den Registerelementen.
Erkennung der nennung von Elementen in mehreren Kategorien
* Personen
* VerfasserIn
* Geographie
* Suchworte
* Auffälligkeiten

## 06-static-files.xsl
Transformation der in files/static-files/* angelegten Dokumente von HTML/XML Syntax in valide Mediawikisyntax

## Splitting
Zusammenführung aller in output angelegten Dateien in eine große XMl, von dort aufteillung in XXX Seitengroße XML inklusive ID vergabe