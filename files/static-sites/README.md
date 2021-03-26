# XML zu Mediawikisyntax
[[_TOC_]]
## meta Elemente
Meta Elemente die statische Seite auszeichnen
```xml
<meta>
        <title>Seitentitel</title>
        <type>Site</type>
        <id/>
        <categories>
            <category>Dokumentation</category>
        </categories>
        <rules>
            <rule></rule>
        </rules>
    </meta>
```
### title
Seitentitel, muss nicht gleichbedeutend mit dem Dateinamen sein
### type
Typisierung, möglichkeiten
* Site -> Normale Seite
* Kategorie 
* Mediawiki
* Attribut
* Templates

### wikitype
Spezial Element für Attribute, wie z.B.
* date
* text

### id
standardmäßig leer, muss nur vergeben werden wenn eine Seite eine spezielle ID haben muss
### categories
Kategoriebezeichnung, wird am Ende der Datei hinzugefügt
### rule
Wikiinterne Regel, z.b. ```__NOTOC__```


## klassische Elemente
### bold
wiki : ```''' text '''```

xml : ```<b>text</b> ```
### italic
wiki : ```'' text ''```

xml : ```<i>text</i> ```

### underline
### div | p | table | h2 | h3
Diese Elemente werden automatisch in Wikisyntax umgewandelt.
Eingetragende Attribute und Klassen werden auch übernommen

```<element> ``` wird zu  ```&lt;element&gt; ```

### header
Anzahl an ```=``` wird zu ```<header level="X"```, X steht für die Überschriftsebene

## wiki Elemente
### noinclude | onlyinclude
Template eigenes Elemente, werden automatisch interpretiert
### hasPropertyDiscreption
Tooltips innerhalb der Templates, wird zum  ```[[Has property description:: TEXT ]] ```

## listen
### klassisch 
 ```xml <ul>
 <li>LISTENELEMENT</li>
</ul>
 ```
wird zu 
  ``` * LISTENELEMENT ```
### definitions Listen ;
 ```xml 
 <dl>
<dt>HEADER</dt>
<dd>ELEMENT</dd>
</diff>
  ```
wird zu  
 ```
 ; HEADER
 : ELEMENT 
  ```  
## links
No linking: `[: | ]]`

Link: `[ | ] `

Intern Link `[[ | ]]`

## Bilder
```xml 
<img url="BILDNAME" size="BILDGRÖßE" link="VERLINKUNG"/> 
```

## wikisyntax
` #set | #ask` Befehle und alle nicht umgesetzen Syntax Elemente können dort eingetragen werden

# Elementnutzung
## Karten
Die folgenden Templates nutzen Karten

- [Template:LocationMap](templates/Template_LocationMap)
- [Template:WerkKarte](templates/Template_WerkKarte)
- [Template:Verfasserin](templates/Template_Verfasserin)
- [Template:HauptseiteKarte](templates/Template_Abfassungsregion)
- [Template:Abfassungsregion](templates/Template_Abfassungsregion)
- [Kategorie:Abfassungsregion](kategorien/Kategorie_Abfassungsregion)

Alle Karten nutzen `Esri.WorldShadedRelief` 



