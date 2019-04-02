<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    exclude-result-prefixes="#all" version="2.0">    
    <xsl:output method="xml" version="1.1" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    <xsl:param name="fid">300</xsl:param>
    <xsl:param name="sid">2</xsl:param>
    <xsl:preserve-space elements=""/>
    <xsl:strip-space elements=""/>
    <xsl:template match="/">
        <mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/ http://www.mediawiki.org/xml/export-0.10.xsd"
            version="0.10" xml:lang="de">
            <siteinfo>
                <sitename>Sarazenen Wiki</sitename>
                <dbname>sarazenen-bonn</dbname>
                <!--<base>http://cceh.uni-koeln.de/projekte/sarazenen/sarazenen_wiki/index.php/SARAZENEN_WIKI</base>-->
                <!--<base>http://cceh.uni-koeln.de/projekte/sarazenen/sarazenen_wiki/index.php/Repertorium_Saracenorum</base>-->
                <base>http://saraceni.uni-koeln.de/sarazenen_wiki/Repertorium_Saracenorum</base>
                <!--<generator>MediaWiki 1.27.3</generator>-->
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
            <xsl:apply-templates/>
        </mediawiki>
    </xsl:template>
    <xsl:template match="Dokumente">
        <page>
            <title>
                <xsl:value-of select="WerkTitel"/>
            </title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="WerkId + $fid"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="WerkId + $sid"/>
                </id>
                <parentid>
                    <xsl:value-of select="WerkId"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441">
{{WikiProject_Transwiki/Template:Infobox
|title=
<xsl:text>|above=</xsl:text><xsl:value-of select="WerkTitel"/>
                    <xsl:choose>
                        <xsl:when test="exists(Alternativtitel/Titel)">
                            <xsl:text>|subheader=</xsl:text><xsl:value-of select="string-join(Alternativtitel/Titel,'/')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>|subheader=</xsl:text><xsl:value-of select="Alternativtitel"/>
                        </xsl:otherwise>
                    </xsl:choose>
|image=
|caption=

|bodyclass = class;
|bodystyle = background:#FFFFFF; width:33%; vertical-align:right; border-style: ridge;
|abovestyle = background:#ccf; 
|headerstyle  = background:#ccf; 
|labelstyle   = background:#ddf; width:30%;
|datastyle    = 

|header1=TEST
|label1=Werknummer
|data1=<xsl:value-of select="WerkId"/>
|label2=Verfasser
|data2=<xsl:choose><xsl:when test="Autoren/Autor[4]"><xsl:value-of select="Autoren/Autor[1]"/>/<xsl:value-of select="Autoren/Autor[2]"/>/<xsl:value-of select="Autoren/Autor[3]"/>/<xsl:value-of select="Autoren/Autor[4]"/></xsl:when>
<xsl:when test="Autoren/Autor[3]"><xsl:value-of select="Autoren/Autor[1]"/>/<xsl:value-of select="Autoren/Autor[2]"/>/<xsl:value-of select="Autoren/Autor[3]"/></xsl:when>
<xsl:when test="Autoren/Autor[2]"><xsl:value-of select="Autoren/Autor[1]"/>/<xsl:value-of select="Autoren/Autor[2]"/></xsl:when>
<xsl:otherwise><xsl:value-of select="Autoren/Autor[1]"/></xsl:otherwise>
</xsl:choose>
|label3=Abfassungszeit
|data3=<xsl:value-of select="Abfassungszeitraum/Datum/@date"/>
|label4=Berichtszeitraum
|data4=<xsl:value-of select="Berichtszeitraum/Datum/@date"/>
|label5=Abfassungsort
|data5=<xsl:value-of select="Abfassungsort"/>
|label6=Lebensdaten des Verfassers
|data6=<xsl:value-of select="LebensdatenVerfasser"/>
}}

&lt;br/&gt;

<xsl:value-of select="Werkinformation"/>

&lt;br/&gt;

=== Editionshinweise ===

----

<xsl:value-of select="Editionshinweise"/>

=== Quellenstellen ===

----
<xsl:apply-templates select=".//Quelle" xml:space="default"/>
<xsl:for-each select="./Abfassungszeitraum/Datum/@date">
<xsl:variable name="start" select="substring-before(.,'-')"/>
<xsl:variable name="end" select="substring-after(.,'-')"/>
<xsl:variable name="stop" select="(floor(number($end) div 10))*10+10"/>
    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Abfassungszeitraum | Abfassungszeitraum]]: 
    <xsl:call-template name="split-numbers-kat.leiste">
        <xsl:with-param name="start" select="$start"/> 
        <xsl:with-param name="stop" select="$stop"/>
    </xsl:call-template>&lt;/div&gt;&lt;/div&gt;
</xsl:for-each>
<xsl:for-each select="./Abfassungszeitraum/Datum/@date"><xsl:variable name="start" select="substring-before(.,'-')"/>
    <xsl:variable name="end" select="substring-after(.,'-')"/>
    <xsl:variable name="stop" select="(floor(number($end) div 10))*10+10"/>
    <xsl:call-template name="split-numbers-kategorien">
        <xsl:with-param name="start" select="$start"/> 
        <xsl:with-param name="stop" select="$stop"/>
    </xsl:call-template>
</xsl:for-each>
                    
<xsl:for-each select="./Berichtszeitraum/Datum/@date">
    <xsl:variable name="start" select="substring-before(.,'-')"/><xsl:variable name="end" select="substring-after(.,'-')"/>
    <xsl:variable name="stop" select="(floor(number($end) div 10))*10+10"/>&lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Berichtszeitraum | Berichtszeitraum]]: 
    <xsl:call-template name="split-numbers-kat.leiste">
        <xsl:with-param name="start" select="$start"/> 
        <xsl:with-param name="stop" select="$stop"/>
    </xsl:call-template>
    &lt;/div&gt;&lt;/div&gt;
</xsl:for-each>
                    
<xsl:for-each select="./Berichtszeitraum/Datum/@date"><xsl:variable name="start" select="substring-before(.,'-')"/>
    <xsl:variable name="end" select="substring-after(.,'-')"/><xsl:variable name="stop" select="(floor(number($end) div 10))*10+10"/>
    <xsl:call-template name="split-numbers-kategorien">
        <xsl:with-param name="start" select="$start"/> 
        <xsl:with-param name="stop" select="$stop"/>
    </xsl:call-template>
</xsl:for-each>
                    
[[Kategorie: Abfassungszeitraum]]
[[Kategorie: Berichtszeitraum]]
<xsl:choose>
    <xsl:when test="contains(Autoren/Autor[1], 'unbekannt')">[[Kategorie: Unbekannte oder mehrere Verfasser]]</xsl:when>
    <xsl:otherwise>[[Kategorie: <xsl:value-of select="Autoren/Autor[1]"/>]]</xsl:otherwise>     
</xsl:choose>
<xsl:if test="Autoren/Autor[2]">[[Kategorie: <xsl:value-of select="Autoren/Autor[2]"/>]]</xsl:if>
<xsl:if test="Autoren/Autor[3]">[[Kategorie: <xsl:value-of select="Autoren/Autor[3]"/>]]</xsl:if>
<xsl:if test="Autoren/Autor[4]">[[Kategorie: <xsl:value-of select="Autoren/Autor[4]"/>]]</xsl:if>
[[Kategorie: Werk]]
[[Kategorie: <xsl:value-of select="Regionen/Region[1]"/>]]
<xsl:if test="Regionen/Region[2]">[[Kategorie: <xsl:value-of select="Regionen/Region[2]"/>]]</xsl:if>



&lt;!-- __SHOWFACTBOX__ --&gt;
                        </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    
    <xsl:template match="Quelle" xml:space="default">
        [[<xsl:value-of select="./parent::Quellen/preceding-sibling::WerkTitel"/> - <xsl:value-of select="./parent::Quellen//preceding-sibling::WerkId"/> <xsl:value-of select="QuellenId"/> | '''<xsl:value-of select="./parent::Quellen//preceding-sibling::WerkId"/>-<xsl:value-of select="QuellenId"/>
        <xsl:text>''']] &lt;br/&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template name="split-numbers-kategorien">         
        <!-- Einstiegswerte -->
        <xsl:param name="start"/> 
        <xsl:param name="stop"/>        
        <!-- aktueller Bereich, der ausgegeben werden soll -->
        <xsl:variable name="start-range" select="(floor(number($start) div 10))*10"/> 
        <xsl:variable name="end-range" select="$start-range + 10"/>
        [[Kategorie: <xsl:value-of select="string-join((string($start-range), string($end-range)),' - ')"/>]]<xsl:if test="$end-range &lt; $stop">
            <xsl:call-template name="split-numbers-kategorien">
                <xsl:with-param name="start" select="$start-range + 10"/> 
                <xsl:with-param name="stop" select="$stop"/> 
            </xsl:call-template></xsl:if>    
    </xsl:template>
    
    <xsl:template name="split-numbers-kat.leiste">         
        <!-- Einstiegswerte -->
        <xsl:param name="start"/> 
        <xsl:param name="stop"/>        
        <!-- aktueller Bereich, der ausgegeben werden soll -->
        <xsl:variable name="start-range" select="(floor(number($start) div 10))*10"/> 
        <xsl:variable name="end-range" select="$start-range + 10"/>
        [[:Kategorie: <xsl:value-of select="string-join((string($start-range), string($end-range)),' - ')"/> | <xsl:value-of select="string-join((string($start-range), string($end-range)),' - ')"/>]]&lt;/li&gt;&lt;li&gt;<xsl:if test="$end-range &lt; $stop"> <!--Rückgabe!-->
            <xsl:call-template name="split-numbers-kat.leiste">
                <xsl:with-param name="start" select="$start-range + 10"/> 
                <xsl:with-param name="stop" select="$stop"/> 
            </xsl:call-template></xsl:if>    
    </xsl:template>
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>