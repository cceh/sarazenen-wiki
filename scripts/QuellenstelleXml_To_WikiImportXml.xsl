<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
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
                <base>http://cceh.uni-koeln.de/projekte/sarazenen/sarazenen_wiki/index.php/SARAZENEN_WIKI</base>
                <generator>MediaWiki 1.26.2</generator>
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
            
            <xsl:for-each select="Sarazenen/Dokumente">
                
                <!--         for-each dokument element in test.xml 
        Elternelement page mit Unterelementen und value of element
        Frage bezüglich IDs, nochmal mehrere Quellenstellen exportieren  -->
                
                <page>
                    <title>
                        <xsl:value-of select="WerkTitel"/> - <xsl:value-of select="WerkId"/> <xsl:value-of select="Quellen/Quelle/QuellenId"/>
                    </title>
                    <ns>0</ns>
                    <id>
                        <xsl:value-of select="WerkId + 200"/>
                    </id>
                    <revision>
                        <id>
                            <xsl:value-of select="WerkId + 1"/>
                        </id>
                        <parentid>
                            <xsl:value-of select="WerkId"/>
                        </parentid>
                        <timestamp>2017-06-12T12:43:46Z</timestamp>
                        <contributor>
                            <username>Administrator</username>
                            <id>1</id>
                        </contributor>
                        <model>wikitext</model>
                        <format>text/x-wiki</format>
                        <text xml:space="preserve" bytes="8636">[[<xsl:value-of select="WerkTitel"/>|Zurück zum Werk]]

&lt;div&gt;
{{Sarazenen Wiki:WikiProject_Transwiki/Template:Infobox
|title=
|above= <xsl:value-of select="WerkTitel"/> <xsl:value-of select="WerkId"/>-<xsl:value-of select="Quellen/Quelle/QuellenId"/>
|subheader=

|image=
|caption=

|bodyclass = class;
|bodystyle = background:#fffff; vertical-align:middle; border-style: ridge; left:0px; position:relative; width:33%;
|abovestyle = background:#ccf;
|headerstyle  = background:#ccf;
|labelstyle   = background:#ddf;
|datastyle    = 

|header1=Zitation
|label1=Werktitel
|data1=<xsl:value-of select="WerkTitel"/>
|label2=Kapitel
|data2=<xsl:value-of select="Quellen/Quelle/Zitation"/>
|label3=Seite
|data3=[http://www.mgh.de/dmgh/resolving/MGH_SS_rer._Germ._6_S._48 48]
|header4=
|label4=zeitliche (Quellen-)Angabe
|data4=<xsl:value-of select="Quellen/Quelle/ZeitangabeQuelle"/>
|label5=Datierung
|data5=<xsl:value-of select="Quellen/Quelle/ZeitangabeWissenschaft/Datum [@Text]"/>
|label6=Verfasser
|data6=[[Verfasser::<xsl:value-of select="Autoren/Autor[1]"/>]]
|label7=Abfassungsort
|data7=<xsl:value-of select="Abfassungsort"/>
}}
&lt;/div&gt;
&lt;br /&gt;

=== Inhaltsangabe ===

----

&lt;div&gt;

<xsl:value-of select="Quellen/Quelle/Inhaltsangabe"/>

&lt;/div&gt;

=== Volltext ===

----

<xsl:value-of select="Quellen/Quelle/VolltextOriginalsprache"/>

=== Deutsche Übersetzung ===

----

<xsl:value-of select="Quellen/Quelle/VolltextUebersetzung"/>

=== Hinweise zur Übersetzung ===

----

<xsl:value-of select="Quellen/Quelle/ZitationUebersetzung"/>

=== Anmerkungen ===

----

<xsl:value-of select="Quellen/Quelle/Anmerkungen"/>

=== Weitere Quellenstellen ===

----

[[<xsl:value-of select="WerkTitel"/> - Stelle <xsl:value-of select="WerkId"/> <xsl:value-of select="Quellen/Quelle/QuellenId[1]"/> | '''<xsl:value-of select="WerkId"/>-<xsl:value-of select="Quellen/Quelle/QuellenId[1]"/>''']] &lt;br /&gt;
[[<xsl:value-of select="WerkTitel"/> - Stelle <xsl:value-of select="WerkId"/> <xsl:value-of select="Quellen/Quelle/QuellenId[2]"/> | '''<xsl:value-of select="WerkId"/>-<xsl:value-of select="Quellen/Quelle/QuellenId[2]"/>''']] &lt;br /&gt;
... &lt;br /&gt;

[[<xsl:value-of select="WerkTitel"/>|Zurück zum Werk]] &lt;br /&gt;

&lt;br /&gt;

&lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[Interaktion:]] [[Interaktion::ja]]&lt;/li&gt;&lt;li&gt;&lt;/li&gt;&lt;/div&gt;&lt;/div&gt; 
&lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Individuen | Individuen]]: [[:Kategorie: andere Individuen | andere Individuen]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: sarazenische Individuen | sarazenische Individuen]]&lt;/li&gt;&lt;/div&gt;&lt;/div&gt;
&lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Kollektive | Kollektive]]: [[sarazenische Kollektive]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: sarazenische Kollektive | sarazenische Kollektive]]&lt;/li&gt;&lt;/div&gt;&lt;/div&gt;
&lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Auffälligkeiten | Auffälligkeiten]]:  [[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[1]"/> | [[Auffälligkeiten::<xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[1]"/>]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[2]"/> | [[Auffälligkeiten::<xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[2]"/>]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[3]"/> | [[Auffälligkeiten::<xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[3]"/>]] ]]&lt;/li&gt;&lt;&lt;li&gt;[[:Kategorie:"<xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[4]"/> | [[Auffälligkeiten::"<xsl:value-of select="Quellen/Quelle[2]/Auffaelligkeiten/Schlagwort[4]"/>]] ]]&lt;/li&gt;&lt;/div&gt;&lt;/div&gt;

&lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Geographie | Geographie]]: [[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[1]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[1]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[2]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[2]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[3]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[3]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[4]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[4]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie:<xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[5]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[5]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[6]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[6]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[7]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[7]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[8]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[8]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[9]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[9]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[10]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[10]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[11]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[11]"/>]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[12]"/> | <xsl:value-of select="Quellen/Quelle[2]/GeographischesStichwort/Ort[12]"/>]]&lt;/li&gt;&lt;/div&gt;&lt;/div&gt; 
&lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Suchbegriffe der Stelle | Suchbegriffe der Stelle]]: [[:Kategorie: Araber | [[Suchbegriffe::Arabus]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: Araber | [[Suchbegriffe::Araber]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: Spanien | [[Suchbegriffe::Hispania]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: Spanien | [[Suchbegriffe::Spanien]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: Sarazene | [[Suchbegriffe::Saracenus]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: Sarazene | [[Suchbegriffe::Sarracenus]] ]]&lt;/li&gt;&lt;li&gt;[[:Kategorie: Sarazene | [[Suchbegriffe::Sarazene]] ]]&lt;/li&gt;&lt;/div&gt;&lt;/div&gt;

[[Kategorie: andere Kollektive]]
[[Kategorie: andere Individuen]]
[[Kategorie: sarazenische Kollektive]]
[[Kategorie: sarazenische Individuen]]

[[Kategorie: <xsl:value-of select="Quellen/Quelle/Auffaelligkeiten/Schlagwort[1]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/Auffaelligkeiten/Schlagwort[2]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/Auffaelligkeiten/Schlagwort[3]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/Auffaelligkeiten/Schlagwort[4]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/Auffaelligkeiten/Schlagwort[5]"/>]]  
                            
[[Kategorie: Geographie]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[1]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[2]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[3]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[4]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[5]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[6]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[7]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[8]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[9]"/>]]  
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[10]"/>]]
[[Kategorie: <xsl:value-of select="Quellen/Quelle/GeographischesStichwort/Ort[11]"/>]]                     
               
                            
[[Kategorie: Spanien]]
[[Kategorie: Karl I. der Große]]
[[Kategorie: 770 - 780]]
[[Kategorie: Sarazene]]

[[Kategorie: Suchbegriffe der Stelle]]


__SHOWFACTBOX__
__KEIN_INHALTSVERZEICHNIS__
__HIDDENCAT__</text>
                        <sha1></sha1>
                    </revision>
                </page>
                
            </xsl:for-each>
        </mediawiki>
    </xsl:template>
    
</xsl:stylesheet>
