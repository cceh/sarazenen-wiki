<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" version="2.0">    
    <xsl:output method="xml" version="1.1" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    <xsl:param name="fid">300</xsl:param>
    <xsl:param name="sid">2</xsl:param>
    <xsl:preserve-space elements=""/>
    <xsl:strip-space elements=""/>
    <xsl:function name="functx:if-absent" as="item()*"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="item()*"/>
        <xsl:param name="value" as="item()*"/>
        
        <xsl:sequence select="
            if (exists($arg))
            then $arg
            else $value
            "/>
        
    </xsl:function>
    <xsl:function name="functx:replace-multi" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="changeFrom" as="xs:string*"/>
        <xsl:param name="changeTo" as="xs:string*"/>
        
        <xsl:sequence select="
            if (count($changeFrom) > 0)
            then functx:replace-multi(
            replace($arg, $changeFrom[1],
            functx:if-absent($changeTo[1],'')),
            $changeFrom[position() > 1],
            $changeTo[position() > 1])
            else $arg
            "/>
        
    </xsl:function>
    <xsl:function name="functx:contains-any-of" as="xs:boolean"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="searchStrings" as="xs:string*"/>
        
        <xsl:sequence select="
            some $searchString in $searchStrings
            satisfies contains($arg,$searchString)
            "/>
        
    </xsl:function>
    
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
    <xsl:template match="Quelle" xml:space="default">
        <xsl:variable name="parent" select="parent::node()/parent::node()"/>
        <page>
            <title>
                <xsl:value-of select="concat($parent/WerkTitel,'-',./QuellenId)"/>
            </title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="$parent/WerkId + ./QuellenId + $fid"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="$parent/WerkId + ./QuellenId + $sid"/>
                </id>
                <parentid>
                    <xsl:value-of select="$parent/WerkId + ./QuellenId"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441">
                    {{#css:
            		table{
            			border: 1px solid black;
            		}
            		td{
            			padding: 5px;
            		}
            		svg {
            			margin-left: 35px;
            			width: 100%;
            		}
            		.timeline {
            			width: 1200px;
            			margin-left: 30px;
            		}
            		.time{
	            		width: 1000px;
	            		height: 30px;
	            		border-top: 1px solid black;
	            		padding-top: 10px;
	            		margin-top: 20px;
            		}
            		.year{
	            		width: 140px;
	            		text-align: center;
	            		display: inline;
	            		margin-right: 150px;
	            		margin-left: 15px;
	            		font-size: 9pt;
            		}
            		.label{
            			font-size: 7pt;
            		}
            		.infobox {
            		float:right;
            		margin-right:50px;
            		}
            		h3 {
            		clear:both;
            		}
            	}}
                    &lt;div&gt;[[<xsl:value-of select="$parent/WerkTitel"/>|Zurück zum Werk (<xsl:value-of select="$parent/WerkTitel"/>)]]&lt;/div&gt;
{{WikiProject_Transwiki/Template:Infobox
|title=|above=<xsl:value-of xml:space="default">
    <xsl:variable name="zeitangabe">
            <xsl:if test="exists(./ZeitangabeWissenschaft/Datum)">
                <xsl:value-of select="./ZeitangabeWissenschaft/Datum[1]"/>
            </xsl:if> 
            <xsl:if test="not(exists(./ZeitangabeWissenschaft/Datum))">
                <xsl:text>Keine Zeitangabe</xsl:text>
            </xsl:if> 
        </xsl:variable>
        <xsl:value-of  xml:space="default" ><xsl:value-of select="$parent/WerkTitel"/>, <xsl:value-of select="$zeitangabe"/>
            </xsl:value-of>
</xsl:value-of>
|image=
|caption=

|bodyclass = class;
|bodystyle = background:#FFFFFF; width:33%; vertical-align:right; border-style: ridge;
|abovestyle = background:#1b98d0; 
|headerstyle  = background:#1b98d0; 
|labelstyle   = background:#1b98d0; width:30%;
|datastyle    = 
|label1=Werktitel
|data1=<xsl:value-of select="$parent/WerkTitel"/>
|label2=Zitation
|data2=<xsl:value-of select="./Zitation"/>
|label4=zeitliche (Quellen-)Angabe
|data4=<xsl:value-of select="./ZeitangabeQuelle"/>
|label5=Datierung
|data5=<xsl:value-of xml:space="default">
    <xsl:choose>
        <xsl:when test="exists(./ZeitangabeWissenschaft/Datum)"><xsl:value-of select="./ZeitangabeWissenschaft/Datum[1]/data(.)"/></xsl:when>
        <xsl:otherwise><xsl:text>Keine Zeitangabe</xsl:text></xsl:otherwise>
    </xsl:choose>
</xsl:value-of>     
|label6=Verfasser
|data6=[[Verfasser::<xsl:value-of select="$parent/Autoren/Autor"/>]]
|label7=Abfassungsort
|data7=<xsl:value-of select="$parent/Abfassungsort"/>
}}
&lt;br/&gt;
=== Inhaltsangabe ===
----
<xsl:value-of select="./Inhaltsangabe"/>              

=== Volltext ===
----
<xsl:apply-templates select="./VolltextOriginalsprache"/>              
=== Deutsche Übersetzung ===
----
<xsl:value-of select="./VolltextUebersetzung"/>              


=== Hinweise zur Übersetzung ===
----
<xsl:value-of select="./ZitationUebersetzung"/>
<xsl:if test="./Anmerkungen != ''">
=== Anmerkungen ===
----
<xsl:value-of select="./Anmerkungen"/>
</xsl:if>
=== Weitere Quellenstellen ===
----
<xsl:value-of xml:space="default">&lt;div&gt;
    <xsl:for-each select="(preceding-sibling::Quelle,following-sibling::Quelle)">
         <xsl:variable name="zeitangabe">
            <xsl:if test="exists(./ZeitangabeWissenschaft/Datum)">
                <xsl:value-of select="./ZeitangabeWissenschaft/Datum[1]"/>
            </xsl:if> 
            <xsl:if test="not(exists(./ZeitangabeWissenschaft/Datum))">
                <xsl:text>Keine Zeitangabe</xsl:text>
            </xsl:if> 
        </xsl:variable>
        <xsl:variable name="tex">
            <xsl:text> </xsl:text>
            <xsl:for-each select="tokenize(./Inhaltsangabe,' ')">
                <xsl:if test="position() &#60; 20">
                    <xsl:value-of select="."/>
                    <xsl:text> </xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:text>...</xsl:text>
        </xsl:variable>
        <xsl:value-of  xml:space="default" > &lt;li&gt;[[<xsl:value-of select="$parent/WerkTitel"/><xsl:text>-</xsl:text><xsl:value-of select="QuellenId"/>|<xsl:value-of select="$zeitangabe"/>]]<xsl:value-of select="$tex"/><xsl:text> [</xsl:text><xsl:value-of select="./QuellenId"/><xsl:text>]</xsl:text>&lt;/li&gt;
            </xsl:value-of>
    </xsl:for-each>
    &lt;/div&gt;
</xsl:value-of>
                    &lt;div&gt;[[<xsl:value-of select="$parent/WerkTitel"/>|Zurück zum Werk (<xsl:value-of select="$parent/WerkTitel"/>)]]&lt;/div&gt;
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id="mw-normal-catlinks" class="mw-normal-catlinks"&gt;
                    &lt;li&gt;[[:Kategorie: Interaktion | Interaktion]]:[[Interaktion::<xsl:value-of xml:space="default"> 
                        <xsl:choose>
                            <xsl:when test="./Interaktion/data(.) eq 'j'"> ja</xsl:when>
                            <xsl:otherwise> nein</xsl:otherwise>
                        </xsl:choose>]]
                    </xsl:value-of>&lt;/li&gt;
                    &lt;/div&gt;&lt;/div&gt;
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id="mw-normal-catlinks" class="mw-normal-catlinks"&gt;
                        &lt;li&gt;[[:Kategorie: Individuen | Individuen]]:<xsl:value-of xml:space="default">
                       <xsl:variable name="individuen"><xsl:for-each select="./Beteiligte/Beteiligter">
                            <xsl:if test="ends-with(.,'I')"><item><xsl:choose>
                                <xsl:when test=". eq 'sI'">[[:Kategorie: Sarazenische Individuen | Sarazenische Individuen]]</xsl:when>
                                <xsl:when test=". eq 'aI'">[[:Kategorie: Andere Individuen | Andere Individuen]]</xsl:when>
                                <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                            </xsl:choose>&lt;/li&gt;&lt;li&gt;</item>
                            </xsl:if>                            
                        </xsl:for-each></xsl:variable>
                            <xsl:value-of select="$individuen/node()"/>
                    </xsl:value-of>
                     &lt;/div&gt;&lt;/div&gt;
                     &lt;div id='catlinks' class='catlinks'&gt;&lt;div id="mw-normal-catlinks" class="mw-normal-catlinks"&gt;
                      &lt;li&gt;[[:Kategorie: Kollektive | Kollektive]]: <xsl:value-of xml:space="default">
                    <xsl:variable name="kollektive">
                        <xsl:for-each select="./Beteiligte/Beteiligter">
                                                <xsl:if test="ends-with(.,'K')">
                                                    <item>
                                                <xsl:choose>
                                                    <xsl:when test=". eq 'sK'">[[:Kategorie: Sarazenische Kollektive | Sarazenische Kollektive]]</xsl:when>
                                                    <xsl:when test=". eq 'aK'">[[:Kategorie: Andere Kollektive | Andere Kollektive]]</xsl:when>
                                                    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                                                </xsl:choose>&lt;/li&gt;&lt;li&gt;
                                                    </item>
                                                </xsl:if>                            
                                            </xsl:for-each>
                    </xsl:variable>         
                        <xsl:value-of select="$kollektive/node()"/></xsl:value-of> 
                    &lt;/div&gt;&lt;/div&gt;
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id="mw-normal-catlinks" class="mw-normal-catlinks"&gt;
                    <xsl:value-of  xml:space="default">
                    <xsl:text>&lt;li&gt;[[:Kategorie: Auffälligkeiten | Auffälligkeiten]]:</xsl:text>
                        <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./Auffaelligkeiten/Schlagwort" xml:space="default"/>
                            <xsl:with-param name="type">Auffälligkeiten</xsl:with-param>
                    </xsl:call-template>
                    </xsl:value-of>          
                    &lt;/div&gt;&lt;/div&gt;
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id="mw-normal-catlinks" class="mw-normal-catlinks"&gt;
                    <xsl:value-of  xml:space="default">
                            <xsl:text> &lt;li&gt;[[:Kategorie: Geographie | Geographie]]: </xsl:text>
                            <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./GeographischesStichwort/Ort" xml:space="default"/>
                                <xsl:with-param name="type">Ort</xsl:with-param>
                    </xsl:call-template>
                        </xsl:value-of>                                        
                    &lt;/div&gt;&lt;/div&gt;
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id="mw-normal-catlinks" class="mw-normal-catlinks"&gt;
                    <xsl:value-of  xml:space="default">
                        <xsl:text>&lt;li&gt;[[:Kategorie: Suchbegriffe der Stelle | Suchbegriffe der Stelle]]: </xsl:text>
          	     <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./Suchbegriffe/Suchwort" xml:space="default"/>
          	         <xsl:with-param name="type">Suchbegriffe</xsl:with-param>
                    </xsl:call-template>
          	     </xsl:value-of>
                &lt;/div&gt;&lt;/div&gt;
                
                <xsl:for-each select="./Beteiligte/Beteiligter">
                                                <xsl:if test="ends-with(.,'K')">
                                                <xsl:choose>
                                                    <xsl:when test=". eq 'sK'">[[Kategorie: Sarazenische Kollektive ]]</xsl:when>
                                                    <xsl:when test=". eq 'aK'">[[Kategorie: Andere Kollektive ]]</xsl:when>
                                                    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                                                </xsl:choose>
                                                </xsl:if>                            
                                            </xsl:for-each>
                    <xsl:for-each select="./Beteiligte/Beteiligter">
                            <xsl:if test="ends-with(.,'I')"><xsl:choose>
                                <xsl:when test=". eq 'sI'">[[Kategorie: Sarazenische Individuen ]]</xsl:when>
                                <xsl:when test=". eq 'aI'">[[Kategorie: Andere Individuen ]]</xsl:when>
                                <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                            </xsl:choose>
                            </xsl:if>                            
                        </xsl:for-each>
              <xsl:call-template name="kategorienHidden" xml:space="default">
                        <xsl:with-param name="data" select="./Suchbegriffe/Suchwort" xml:space="default"/>
                    </xsl:call-template>
                 <xsl:call-template name="kategorienHidden" xml:space="default">
                        <xsl:with-param name="data" select="./GeographischesStichwort/Ort" xml:space="default"/>
                    </xsl:call-template>
                     <xsl:call-template name="kategorienHidden" xml:space="default">
                        <xsl:with-param name="data" select="./Auffaelligkeiten/Schlagwort" xml:space="default"/>
                    </xsl:call-template>
                     <xsl:call-template name="kategorienHidden" xml:space="default">
                        <xsl:with-param name="data" select="./Berichtszeitraum/Datum" xml:space="default"/>
                    </xsl:call-template>
                    __SHOWFACTBOX__
                        </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    
    <xsl:template name="kategorien" xml:space="default">
        <xsl:param name="data"/>
        <xsl:param name="type"></xsl:param>
        <xsl:variable name="items" xml:space="default">
            <xsl:for-each select="$data" xml:space="default">
                <item>[[:Kategorie: <xsl:value-of select="."/> | [[<xsl:value-of select="$type"/>::<xsl:value-of select="."/>]] ]]&lt;/li&gt;&lt;li&gt;</item>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$items/node()" xml:space="default"/>
    </xsl:template>
    
    <xsl:template name="kategorienHidden">
        <xsl:param name="data"/>
        <xsl:for-each select="$data">
            [[Kategorie: <xsl:value-of select="."/>]]
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="VolltextOriginalsprache | VolltextUebersetzung | Inhaltsangabe">
        <xsl:variable name="Entitaeten" select="parent::node()/Entitaeten" xml:space="default"/>
        <xsl:variable name="Suchbegriffe" select="parent::node()/Suchbegriffe"/>
        <xsl:variable name="generation">
             <xsl:for-each select="$Entitaeten/Entitaet">
                 <item>
                     <xsl:attribute name="type" select="./@Type"/>
                     <xsl:if test="functx:contains-any-of(./Name,$Suchbegriffe/node())">
                         <xsl:attribute name="type">Suchbegriffe</xsl:attribute>
                         <xsl:attribute name="sec" select="./@Type"/>
                     </xsl:if>
                     <xsl:value-of select="./Name"/>
                 </item>
             </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="replacment">
        <xsl:for-each select="$generation/node()">
            <xsl:variable name="sel">[<xsl:value-of select="./@type"/>::<xsl:value-of select="./data(.)"/>]</xsl:variable>
            <item><xsl:if test="./@sec"><xsl:value-of select="concat('[:Kategorie:',./data(.),'|',$sel,']')"/></xsl:if><xsl:if test="not(./@sec)"><xsl:value-of select="$sel"/></xsl:if></item>
        </xsl:for-each>
        </xsl:variable>
       
        <xsl:value-of select="functx:replace-multi(.,$Entitaeten/Entitaet/Name/data(.),$replacment/node())"/>
        
    </xsl:template>
    
    <xsl:template match="EditionLink">        
        <xsl:if test="EditionLink/@url != ''">
            [<xsl:value-of select="EditionLink/@url"/> <xsl:value-of select="EditionLink/data(.)"/>]
        </xsl:if>
    </xsl:template>    
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>