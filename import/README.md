 Wiki Import Doku 
======
- [Mediawiki Transofrmation](#transformation)
    -  [Wiki Header](#wikiheader)



<a name="transformation"></a>
## Mediawiki Transformation ##
Einige der Hauptprobleme bei der Transformation von XML zu Mediawiki sind Leerzeichen und Vergleichszeichen.

### Leerzeichen ###
Häufig kommt es durch Leerzeichen innerhalb des XSLT Codes zu einer falschen Transformation innerhalb des MediaWiki. 
Eine möglichkeit das zu umgehen, ist teile der zur erstellenden Syntax in Variablen zu speichern und mit <xsl:value-of select="$someAttr" xml:space="default"/> aufzurufen


Bsp.:
```xsl
<xsl:variable name="someAttribute"><xsl:text>Some Text</xsl:text></xsl:variable>
<xsl:value-of select="$someAttr" xml:space="default"/>
```

Durch Einrückungen kann es zu Absätzen innerhalb der Wikiseiten kommen, dass lässt sich auch verhindern wie oben im Beispiel oder indem die XSL Funktionen keine Einrückungen haben.

### Vergleichszeichen ( < | > ) ###
Um HTML und/oder Mediawiki Elemente einzubinden, müssen die Vergleichszeichen innerhalb des <text> Elements mit ASCII Code ausgetauscht werden
> &lt; = <
> 
> &gt; = >


<a name="wikiheader"></a>
### Wiki Header ###
```xml
<mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/ http://www.mediawiki.org/xml/export-0.10.xsd"
            version="0.10" xml:lang="de">
            <siteinfo>
                <sitename>Sarazenen Wiki</sitename>
                <dbname>sarazenen-bonn</dbname>
                <base>http://saraceni.uni-koeln.de/sarazenen_wiki/Repertorium_Saracenorum</base>
                <generator>MediaWiki 1.27.4</generator>                
                <case>first-letter</case>
                <namespaces>
                    <namespace key="-2" case="first-letter">Medium</namespace>
                    <namespace key="-1" case="first-letter">Spezial</namespace>
                    <namespace key="0" case="first-letter"/>
                    <namespace key="1" case="first-letter">Diskussion</namespace>
                    <namespace key="2" case="first-letter">Benutzer</namespace>
                    <namespace key="3" case="first-letter">Benutzer Diskussion</namespace>
                    <namespace key="4" case="first-letter">Sarazenen Wiki</namespace>
                    <namespace key="5" case="first-letter">Sarazenen Wiki Diskussion</namespace>
                    <namespace key="6" case="first-letter">Datei</namespace>
                    <namespace key="7" case="first-letter">Datei Diskussion</namespace>
                    <namespace key="8" case="first-letter">MediaWiki</namespace>
                    <namespace key="9" case="first-letter">MediaWiki Diskussion</namespace>
                    <namespace key="10" case="first-letter">Vorlage</namespace>
                    <namespace key="11" case="first-letter">Vorlage Diskussion</namespace>
                    <namespace key="12" case="first-letter">Hilfe</namespace>
                    <namespace key="13" case="first-letter">Hilfe Diskussion</namespace>
                    <namespace key="14" case="first-letter">Kategorie</namespace>
                    <namespace key="15" case="first-letter">Kategorie Diskussion</namespace>
                    <namespace key="102" case="first-letter">Attribut</namespace>
                    <namespace key="103" case="first-letter">Attribut Diskussion</namespace>
                    <namespace key="106" case="first-letter">Formular</namespace>
                    <namespace key="107" case="first-letter">Formular Diskussion</namespace>
                    <namespace key="108" case="first-letter">Konzept</namespace>
                    <namespace key="109" case="first-letter">Konzept Diskussion</namespace>
                    <namespace key="170" case="first-letter">Filter</namespace>
                    <namespace key="171" case="first-letter">Filter Diskussion</namespace>
                    <namespace key="828" case="first-letter">Modul</namespace>
                    <namespace key="829" case="first-letter">Modul Diskussion</namespace>
                </namespaces>
            </siteinfo>
            <page/>
        </mediawiki>
```
### Seiten / Page ###

```xml
    <page>
            <title>
                   SEITENNAME
            </title>
            <ns>0</ns>
            <id>
                SEITENID    
            </id>
            <revision>
                <id>
                    REVISIONSID
                </id>
                <parentid>
                    PARENTID                
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441">
                </text>
                <sha1></sha1>
            </revision>
    </page>
```