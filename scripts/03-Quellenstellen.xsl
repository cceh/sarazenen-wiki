
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" version="2.0">    
    <xsl:output method="xml" version="1.1"  indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    <xsl:param name="fid">300</xsl:param>
    <xsl:param name="sid">2</xsl:param>
    <xsl:preserve-space elements=""/>
    <xsl:strip-space elements=""/>
    
    <xsl:variable name="lists" select="(Sarazenen/Personen,Sarazenen/Orte)"/>
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
            xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/"
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
            <xsl:apply-templates/>       
       </mediawiki>
    </xsl:template> 
    <xsl:template match="Quelle" xml:space="default">
        <xsl:variable name="parent" select="parent::node()/parent::node()"/>
        <xsl:variable name="datierung" xml:space="default">
            <xsl:choose>
                <xsl:when test="exists(./ZeitangabeWissenschaft/Datum)"><xsl:value-of select="./ZeitangabeWissenschaft/Datum[1]/data(.)"/></xsl:when>
                <xsl:otherwise><xsl:text>Keine Zeitangabe</xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>    
        <xsl:variable name="datierungQuelle" xml:space="default">
            <xsl:choose>
                <xsl:when test="./ZeitangabeQuelle != '-'"><xsl:value-of select="./ZeitangabeQuelle/data(.)"/></xsl:when>
                <xsl:otherwise><xsl:text>Keine Zeitangabe</xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>    
        <page>
            <title><xsl:value-of select="concat($parent/WerkTitel,'-',./QuellenId)"/>
            </title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="$parent/position() + ./QuellenId + $fid"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="$parent/position() +./QuellenId + $sid"/>
                </id>
                <parentid>
                    <xsl:value-of select="$parent/position()+./QuellenId"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441">
&lt;div&gt;[[<xsl:value-of select="$parent/WerkTitel"/>|Zurück zum Werk (<xsl:value-of select="$parent/WerkTitel"/>)]]&lt;/div&gt;
{{WikiProject_Transwiki/Template:Infobox
|title=|above=<xsl:value-of xml:space="default">
        <xsl:value-of  xml:space="default" ><xsl:value-of select="$parent/WerkTitel"/>, <xsl:value-of select="$datierung"/>
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
|data1=[[Werk::<xsl:value-of select="$parent/WerkTitel"/>]]
|label2=Zitation
|data2=<xsl:value-of select="./Zitation"/>
|label4=zeitliche (Quellen-)Angabe
|data4=<xsl:value-of select="$datierungQuelle"/>
|label5=Datierung
|data5=<xsl:value-of select="$datierung"/>
|label6=VerfasserIn
|data6=<xsl:value-of xml:space="default"><xsl:choose><xsl:when test="exists($parent/Autoren/Autor[2])">
                            <xsl:for-each select="$parent/Autoren/Autor">
                                <xsl:if test="position() > 1"><xsl:text>; </xsl:text></xsl:if>
                                <xsl:text>[[VerfasserIn::</xsl:text><xsl:value-of select="."/><xsl:text>]]</xsl:text>                                 
                            </xsl:for-each>
                        </xsl:when>
                            <xsl:when test="$parent/Autoren/Autor[1] eq 'unbekannt'">
                                <xsl:text>[[VerfasserIn::VerfasserIn unbekannt]]</xsl:text>
                            </xsl:when>
                            <xsl:otherwise> <xsl:text>[[VerfasserIn::</xsl:text><xsl:value-of select="$parent/Autoren/Autor/data(.)"/>]]</xsl:otherwise>
                        </xsl:choose></xsl:value-of>
|label7=Abfassungsort
|data7=[[Abfassungsort::<xsl:value-of select="$parent/Abfassungsort"/>]]
}}
&lt;br/&gt;
<xsl:variable name="inhalt" xml:space="default"><xsl:for-each select="tokenize(./Inhaltsangabe,' ')">
                <xsl:if test="position() &#60; 20">
                    <xsl:value-of select="."/>
                    <xsl:text> </xsl:text>
                </xsl:if>
            </xsl:for-each></xsl:variable>
{{#set: 
    Zitation=<xsl:value-of select="./Zitation"/>
                    | Datierung=<xsl:value-of select="$datierung"/>
                    | QuellenAngabe=<xsl:value-of select="$datierungQuelle"/>
                    | Inhaltsangabe=<xsl:value-of select="replace(replace($inhalt,'\&#93;',''),'\&#91;','')"/>
                    }}
=== Inhaltsangabe ===
<xsl:apply-templates select="./Inhaltsangabe"/>
=== Volltext ===
<xsl:apply-templates select="./VolltextOriginalsprache"/>              
=== Deutsche Übersetzung ===
<xsl:apply-templates select="./VolltextUebersetzung"/>              


=== Hinweise zur Übersetzung ===
<xsl:apply-templates select="./ZitationUebersetzung"/>
<xsl:if test="./Anmerkungen != ''">
=== Anmerkungen ===
<xsl:value-of select="./Anmerkungen"/>
</xsl:if>
=== Weitere Quellenstellen ===
{{#ask:
[[Kategorie:Quelle]]
[[Werk::<xsl:value-of select="$parent/WerkTitel"/>]]
                    |mainlabel=Zitation
                    |?Inhaltsangabe#                   
                    |?Datierung#
                    |format=table
                    |headers=plain
}}                
&lt;div&gt;[[<xsl:value-of select="$parent/WerkTitel"/>|Zurück zum Werk (<xsl:value-of select="$parent/WerkTitel"/>)]]&lt;/div&gt;
&lt;br/&gt;
=== Kategorisierung ===
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id="mw-normal-catlinks" class="mw-normal-catlinks"&gt;
                    &lt;li&gt;[[:Kategorie: Interaktion | Interaktion]]: [[Interaktion::<xsl:value-of xml:space="default"> 
                        <xsl:choose>
                            <xsl:when test="./Interaktion/data(.) eq 'j'">ja</xsl:when>
                            <xsl:otherwise>nein</xsl:otherwise>
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
                    <xsl:variable name="eintitat" select="./Entitaeten"/>
                    &lt;div  class='catlinks'&gt;&lt;div  class="mw-normal-catlinks"&gt;
                    <xsl:value-of  xml:space="default">
                    <xsl:text>&lt;li&gt;[[:Kategorie: Auffälligkeiten | Auffälligkeiten]]:</xsl:text>
                        <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./Auffaelligkeiten/Schlagwort" xml:space="default"/>
                            <xsl:with-param name="type">Auffälligkeiten</xsl:with-param>
                            <xsl:with-param name="enti" select="$eintitat"/>
                    </xsl:call-template>
                    </xsl:value-of>          
                    &lt;/div&gt;&lt;/div&gt;
                    &lt;div  class='catlinks'&gt;&lt;div  class="mw-normal-catlinks"&gt;
                    <xsl:value-of  xml:space="default">
                            <xsl:text> &lt;li&gt;[[:Kategorie: Geographie | Geographie]]: </xsl:text>
                            <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./GeographischesStichwort/Ort" xml:space="default"/>
                                <xsl:with-param name="type">Ort</xsl:with-param>
                                <xsl:with-param name="enti" select="$eintitat"/>
                    </xsl:call-template>
                        </xsl:value-of>                                        
                    &lt;/div&gt;&lt;/div&gt;
                    &lt;div  class='catlinks'&gt;&lt;div  class="mw-normal-catlinks"&gt;
                    <xsl:value-of  xml:space="default">
                        <xsl:text>&lt;li&gt;[[:Kategorie: Suchbegriffe der Stelle | Suchbegriffe der Stelle]]: </xsl:text>
          	     <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./Suchbegriffe/Suchwort" xml:space="default"/>
          	         <xsl:with-param name="type">Suchbegriffe</xsl:with-param>
          	         <xsl:with-param name="enti" select="$eintitat"/>
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
                
                    [[Kategorie:Quelle]]
                    __SHOWFACTBOX__
                        </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    
    <!--
                <xsl:if test="functx:contains-any-of(.,$enti/Entitaet/Name/data(.))">
                    found
                </xsl:if>
                <item>[[<xsl:value-of select="$type"/>::<xsl:value-of select="."/>]]&lt;/li&gt;&lt;li&gt;</item>
                <xsl:value-of select="$lists//node()[./Id/data(.) = ./@Id]"></xsl:value-of>
                -->
    <xsl:template name="kategorien" xml:space="default">
        <xsl:param name="data"/>
        <xsl:param name="type"/>
        <xsl:param name="enti"/>
        <xsl:variable name="items" xml:space="default">
            <xsl:for-each select="$data" xml:space="default">
                <xsl:choose>
                    <xsl:when test="functx:contains-any-of(.,$enti/Entitaet/Name/data(.))">          
                        <xsl:variable name="se" select="."/>
                        <xsl:variable name="id">
                            <xsl:for-each select="$enti/Entitaet">
                               <xsl:if test="./Name eq $se">
                                   <xsl:variable name="id2" select="./@Id"/>
                                   <xsl:for-each select="$lists/node()">
                                       <xsl:if test="./Id/data(.) = $id2">
                                           <xsl:value-of select="./Name/data(.)"/>
                                       </xsl:if>
                                   </xsl:for-each>                                   
                               </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <item>[[<xsl:value-of select="$type"/>::<xsl:value-of select="$id"/> | <xsl:value-of select="."/>]]&lt;/li&gt;&lt;li&gt;</item></xsl:when>
                    <xsl:otherwise><item>[[<xsl:value-of select="$type"/>::<xsl:value-of select="."/>]]&lt;/li&gt;&lt;li&gt;</item></xsl:otherwise>
                </xsl:choose>
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
    
    <xsl:template match="VolltextOriginalsprache | VolltextUebersetzung | Inhaltsangabe | ZitationUebersetzung" xml:space="default" >
        <xsl:variable name="terms">
            <xsl:for-each select="parent::node()/Entitaeten/Entitaet">
                <item><xsl:attribute name="type" select="./@Type"/>##<xsl:value-of select="./Name/data(.)"/>#</item>
            </xsl:for-each>
            <xsl:for-each select="parent::node()/Suchbegriffe/Suchwort">
                <item><xsl:attribute name="type">Suchbegriffe</xsl:attribute>##<xsl:value-of select="./data(.)"/>#</item>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="replacment">
            <xsl:for-each select="$terms/node()">
                <xsl:variable name="sel">[&#x200b;[[<xsl:value-of select="./@type"/>::<xsl:value-of select="substring-before(substring-after(.,'##'),'#')"/>]]&#x200b;]</xsl:variable>
                <item><xsl:value-of select="$sel"/></item>
            </xsl:for-each>
        </xsl:variable>
          
       <xsl:variable name="tex" select="replace(replace(./text(),'\&#93;','#'),'\&#91;','##')"/>
        <xsl:variable name="repl" select="functx:replace-multi($tex,$terms/node(),$replacment/node())"/>       
        <xsl:value-of select="replace(replace(replace($repl,'##','&#91;'),'#','&#93;'),'\\n','\\n \\n')"/>
    </xsl:template>
    
    <xsl:template match="EditionLink">        
        <xsl:if test="EditionLink/@url != ''">
            [<xsl:value-of select="EditionLink/@url"/> <xsl:value-of select="EditionLink/data(.)"/>]
        </xsl:if>
    </xsl:template>    
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>