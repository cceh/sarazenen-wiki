# Sarazenen Wiki #
## Inhalt ##
[[_TOC_]]
## Einleitung ##
Das Repertorium Saracenorum bietet eine Sammlung von mittelalterlichen Berichten über Saraceni, Agareni, Mauri…. Jeder thematisch relevante Bericht ist als Quellenstelle auf einer eigenen Seite aufgenommen, diese wiederum einem Werk und sofern möglich einer Verfasserin bzw. einem Verfasser zugeordnet worden. Mit Hilfe von Kategorien und Attributen wurden sowohl die Werkseiten als auch die Quellenstellenseiten verschlagwortet. 


## Strukutur ##
### Ordner
1. AFS [readme](afs/README.md)
   -   beinhaltet alle nötigen files die auf den AFS hochgeladen werden müssen
1. datenmodell
1. files [readme](files/static-files/README.md)
    - beinhaltet die sarazenenmasterfassung.xml, die entsprechende dtd und alle static-sites
1. import
    - xml transfomrations dokumentation
1. output
    - generierter Output der scripts
1. scripts [readme](scripts/README.md)
    - beinhaltet alle xsl scripts zur transformierung
1. transformation [readme](transformation/README.md)
    - generelle einmalige transformations skripte

### Shell Skripts

___run.sh___ 

Haupt Shell Skript, welches die referenzierung zur masterfassung.xml enhthält und zu den xsl skripten. Ruft je nach Eingabe auch splitting.sh auf

___splitting.sh___

Skript zur generierung der in output generierten Dateien

## Semantische Suche ##
[Semantische Suche Link](http://saraceni.uni-koeln.de/wiki/index.php?title=Spezial:Semantische_Suche)
Die Semantische Suche bietet mehrere möglichkeiten, Kategorien und Attribute zu verknüpfen.

Bsp.: 
[Link](http://saraceni.uni-koeln.de/wiki/index.php?title=Spezial:Semantische_Suche&q=%5B%5BAuff%C3%A4lligkeit%3A%3A%C3%9Cberfall%5D%5D%0A%5B%5BZeitangabe%3A%3A%3E890%5D%5D%0A%5B%5BOrt%3A%3AItalien%5D%5D&p=format%3Dtagcloud%2Flink%3Dall%2Fheaders%3Dshow%2Fsearchlabel%3D%E2%80%A6-20weitere-20Ergebnisse%2Ftagorder%3Dalphabetical%2Fincrease%3Dlog%2Fclass%3Dsortable-20wikitable-20smwtable%2Ffont%3Dimpact%2Fheight%3D400%2Fwidth%3D400%2Fmincount%3D1%2Fminsize%3D77%2Fmaxsize%3D242%2Fmaxtags%3D1000&po=%3FAuff%C3%A4lligkeit%0A%3FOrt%0A%3FSuchbegriffe%0A&sort=&order=asc%2Casc&eq=no&offset=0&limit=100)

Hierbei ist in der Linken Spalte:
```
[[Auffälligkeit::Überfall]]
[[Zeitangabe::>890]]
[[Ort::Italien]]
```
und in der rechten
```
?Auffälligkeit
?Ort
?Suchbegriffe
```
Die linke Spalte defeniert welche Dokumente abgefragt werden sollen und verfeinert die Suche. Anhand des Beispiel werden alle Seiten mit dem Attribut "Auffälligkeit" mit dem Wert "Überfall" erfasst. Das Attributt "Zeitangabe" ist vom Typ "date", wodurch mit ">890" bestimmt werden kann alle Seiten nach 890 zu erhalten.

## Installation ##
### Mediawiki ###
Mediawiki herunterladen
https://releases.wikimedia.org/mediawiki/1.31/mediawiki-1.31.12.zip

Die genutzte Version ist `1.31`.

__UNVOLLSTÄNDIG__

Mediawiki herunterladen

LocalSettings.php anpassen

install ausführen

composer ausführen(?)

AFS Dateien hochladen, LocalSettings.php überschreiben

update.php ausführen (?)

Import ausführen

#### composer ####
ausführen von composer
#### LocalSettings.php ####
Damit das Mediawiki wie gewüncht funktioniert muss die datei LocalSettings.php mit eingebunden werden. 

```php
L64    $wgDBpassword = "";
```
SQL Passwort ist im internen Wiki gespeichert.


Eingebundene Extensions
```php
wfLoadExtension( 'Cite' );
wfLoadExtension( 'CiteThisPage' );
wfLoadExtension( 'ConfirmEdit' );
wfLoadExtension( 'Gadgets' );
wfLoadExtension( 'ImageMap' );
wfLoadExtension( 'InputBox' );
wfLoadExtension( 'Interwiki' );
wfLoadExtension( 'LocalisationUpdate' );
wfLoadExtension( 'Nuke' );
wfLoadExtension( 'ParserFunctions' );
wfLoadExtension( 'PdfHandler' );
wfLoadExtension( 'Poem' );
wfLoadExtension( 'Renameuser' );
wfLoadExtension( 'SpamBlacklist' );
wfLoadExtension( 'SyntaxHighlight_GeSHi' );
wfLoadExtension( 'TitleBlacklist' );
wfLoadExtension( 'WikiEditor' );

wfLoadExtension('SemanticResultFormats');
enableSemantics( 'saraceni.uni-koeln.de' );
wfLoadExtension( 'CategoryTree' );

## Matomo / piwik Einstellungen ##
wfLoadExtension( 'Matomo' );
$wgMatomoURL = "https://webstats.cceh.uni-koeln.de";
$wgMatomoIDSite = "26";

```

#### Herunterzuladene Inhalte 

- https://www.mediawiki.org/wiki/Extension:Admin_Links
- https://www.mediawiki.org/wiki/Extension:CategorySortHeaders
- https://www.mediawiki.org/wiki/Extension:Data_Transfer
- https://www.mediawiki.org/wiki/Extension:External_Data
- https://www.mediawiki.org/wiki/Extension:Page_Schemas
- https://www.mediawiki.org/wiki/Extension:Semantic_Compound_Queries
- https://www.mediawiki.org/wiki/Extension:Semantic_Drilldown
- https://www.mediawiki.org/wiki/Extension:Semantic_Internal_Objects
- https://www.mediawiki.org/wiki/Extension:HTML_Tags
- https://www.mediawiki.org/wiki/Extension:TextExtracts
- https://www.mediawiki.org/wiki/Extension:PageImages
- https://www.mediawiki.org/wiki/Extension:Popups
- https://www.mediawiki.org/wiki/Extension:Matomo

### AFS ###
#### htaccess ####
Die htaccess Datei unter 
```
//afs/.rrz.uni-koeln.de/vol/www/projekt/sarazenen/http/docs/wiki//images/
``` 
wurde gelöscht, da es zu problemen beim darstellen hochgeladener Bilder gab.

Wichtig ist mit 
> fs la

zu prüfen ob die Schreib und Leserechte richtig sind
```
-bash-4.1$ cd //afs/.rrz.uni-koeln.de/vol/www/projekt/sarazenen/http/docs/wiki
-bash-4.1$ fs la
Access list for . is
Normal rights:
  webpro0:pro_sarazenen_n rlidwk
  webpro0:pro_sarazenen_a rlidwka
  wwwadm1:wm rlidwka
  system:administrators rlidwka
  wwwadm1 rlidwka
  webpro0 rlidwka
  w-saraze rlidwk
```


#### Import ####
Der Import ist in mehreren Schritten unterteilt
##### 1 SQL Bereinigen #####
Unter https://dbadmin.rrz.uni-koeln.de/index.php?db=sarazenen-bonn&target=db_sql.php 
mit dem Befehl > DELETE FROM page; 
alle vorhanden sql Einträge löschen
##### 2 Neue Dateien hochladen #####
Die Dateien in ```output/split``` nach ```/afs/.rrz.uni-koeln.de/vol/www/projekt/sarazenen/http/docs/files``` hochladen und mit ```php maintenance/importDump.php ../files/1.xml```  das script ausführen 
##### 3 Update.sh ausführen
In ```/afs/.rrz.uni-koeln.de/vol/www/projekt/sarazenen/http/docs/wiki``` den Befehl ```sh update.sh``` ausführen

