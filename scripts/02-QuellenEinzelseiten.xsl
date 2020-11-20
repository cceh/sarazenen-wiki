
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" version="2.0">    
    <xsl:output method="xml" version="1.1"  indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    <xsl:param name="fid">300</xsl:param>
    <xsl:param name="sid">2</xsl:param>
    <xsl:param name="werkeN">200</xsl:param>
    <xsl:preserve-space elements=""/>
    <xsl:strip-space elements=""/>
    
    <xsl:variable name="lists">
        <xsl:copy-of select="(Sarazenen/Personen,Sarazenen/Orte)"/>
    </xsl:variable>
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
                <xsl:when test="exists(./ZeitangabeWissenschaft/Datum)"><xsl:value-of select="string-join(./ZeitangabeWissenschaft/Datum/data(.),', ')"/></xsl:when>
                <xsl:otherwise><xsl:text>Keine Zeitangabe</xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>    
        <xsl:variable name="datierungQuelle" xml:space="default">
            <xsl:choose>
                <xsl:when test="./ZeitangabeQuelle != '-'"><xsl:value-of select="./ZeitangabeQuelle/data(.)"/></xsl:when>
                <xsl:otherwise><xsl:text>Keine Zeitangabe</xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>    
        <xsl:variable name="abfssungsort"><xsl:choose>
            <xsl:when test="$parent/Abfassungsort eq ''">Abfassungsort Unbekannt</xsl:when>
            <xsl:when test="$parent/Abfassungsort eq '-'">Abfassungsort Unbekannt</xsl:when>
            <xsl:when test="$parent/Abfassungsort eq 'unbekannt'">Abfassungsort Unbekannt</xsl:when>
            <xsl:otherwise><xsl:value-of select="$parent/Abfassungsort"/></xsl:otherwise>
        </xsl:choose></xsl:variable>
        <xsl:variable name="zeitangabe">
            <xsl:call-template name="normDate"><xsl:with-param name="date" select="./ZeitangabeWissenschaft/Datum[1]/@date"/><xsl:with-param name="attr" select="'Zeitangabe'"/></xsl:call-template>
           
        </xsl:variable>
        <xsl:variable name="individuen"><xsl:for-each select="./Beteiligte/Beteiligter">
            <xsl:if test="ends-with(.,'I')"><item><xsl:choose>
                <xsl:when test=". eq 'sI'">| Individuen=Sarazenische Individuen</xsl:when>
                <xsl:when test=". eq 'aI'">| Individuen=Andere Individuen</xsl:when>                
                <xsl:when test=". eq 'sK'">| Kollektive=Sarazenische Kollektive</xsl:when>
                <xsl:when test=". eq 'aK'">| Kollektive=Andere Kollektive</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose></item>
            </xsl:if>                            
        </xsl:for-each></xsl:variable>
        
        <xsl:variable name="inhalt" xml:space="default"><xsl:for-each select="tokenize(./Inhaltsangabe,' ')">
            <xsl:if test="position() &#60; 20">
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if test="position() eq 20"><xsl:text>...</xsl:text></xsl:if>
        </xsl:for-each></xsl:variable>
        <xsl:variable name="quellentitle" select="concat($parent/WerkTitel,' ',./QuellenId)"/>
        <xsl:variable name="quellenId" select="$parent/position() + ./QuellenId + $fid + $werkeN"/>
        <xsl:variable name="eintitat" select="./Entitaeten"/>
        <xsl:variable name="index"><xsl:if test="./Inhaltsangabe != '' and ./Inhaltsangabe != '-'">
=== Inhaltsangabe ===<xsl:apply-templates select="./Inhaltsangabe" xml:space="default"/>
        </xsl:if>
            <xsl:if test="./VolltextOriginalsprache != '' and ./VolltextOriginalsprache != '-'">
=== Volltext ===<xsl:apply-templates select="./VolltextOriginalsprache" xml:space="default"/>              
            </xsl:if>
            <xsl:if test="./VolltextUebersetzung != '' and ./VolltextUebersetzung != '-'">
=== Deutsche Übersetzung ===<xsl:apply-templates select="./VolltextUebersetzung" xml:space="default"/>              
            </xsl:if>
            <xsl:if test="./ZitationUebersetzung != '' and ./ZitationUebersetzung != '-'">
=== Hinweise zur Übersetzung ===<xsl:apply-templates select="./ZitationUebersetzung" xml:space="default"/>
            </xsl:if>
            <xsl:if test="./Anmerkungen != '' and ./Anmerkungen != '-'">
=== Anmerkungen ===<xsl:apply-templates select="./Anmerkungen" xml:space="default"/>
            </xsl:if></xsl:variable>
        <page>
            <title><xsl:value-of select="$quellentitle"/></title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="$parent/position() + ./QuellenId + $fid"/>
            </id>
            <revision>                
                <id>0</id>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441">{{#css: .infobox {float:right;margin-right:50px;}}
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
                            <xsl:when test="$parent/Autoren/Autor[1] eq 'VerfasserIn unbekannt'">
                                <xsl:text>[[VerfasserIn::VerfasserIn unbekannt]]</xsl:text>
                            </xsl:when>
                            <xsl:otherwise> <xsl:text>[[VerfasserIn::</xsl:text><xsl:value-of select="$parent/Autoren/Autor/data(.)"/>]]</xsl:otherwise>
                        </xsl:choose></xsl:value-of>
|label7=Abfassungsort
|data7=[[Abfassungsort::<xsl:value-of select="$abfssungsort"/>]]
}}
{{#set: 
    Zitation=<xsl:value-of select="./Zitation"/>
                   <!--<xsl:value-of select="$zeitangabe/node()/node()/data(.)"/>-->
                    | Interaktion=<xsl:choose>
                            <xsl:when test="./Interaktion/data(.) eq 'j'">ja</xsl:when>
                            <xsl:otherwise>nein</xsl:otherwise>
                        </xsl:choose>
                    <xsl:value-of select="$individuen/node()"/>
<!--                   <xsl:value-of select="$kollektive/node()"/> -->
                    <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./Auffaelligkeiten/Schlagwort" xml:space="default"/>
                            <xsl:with-param name="type">Auffälligkeit</xsl:with-param>
                            <xsl:with-param name="enti" select="$eintitat"/>
                    </xsl:call-template>
                    <xsl:value-of  xml:space="default">                            
                            <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./GeographischesStichwort/Ort" xml:space="default"/>
                                <xsl:with-param name="type">Ort</xsl:with-param>
                                <xsl:with-param name="enti" select="$eintitat"/>
                    </xsl:call-template>
                        </xsl:value-of>  
                     <xsl:call-template name="kategorien" xml:space="default">
                        <xsl:with-param name="data" select="./Suchbegriffe/Suchwort" xml:space="default"/>
          	         <xsl:with-param name="type">Suchbegriffe</xsl:with-param>
          	         <xsl:with-param name="enti" select="$eintitat"/>
                    </xsl:call-template>
                    | Datierung= <xsl:value-of select="$datierung"/>
                    | QuellenAngabe=<xsl:value-of select="$datierungQuelle"/>
                    | Inhaltsangabe=<xsl:value-of select="replace(replace($inhalt,'\&#93;',''),'\&#91;','')"/>
                    }}
                    
<xsl:value-of select="$index"/>
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
=== Zitationshinweis ===
<xsl:text>{{BASEPAGENAME}}, in: Repertorium Saracenorum, hg. von Matthias Becher und Katharina Gahbler, URL: [{{fullurl:{{FULLPAGENAME}}}} {{fullurl:{{FULLPAGENAME}}}}] (zuletzt abgerufen am {{CURRENTDAY}}.{{CURRENTMONTH}}.{{CURRENTYEAR}}).</xsl:text>
<xsl:variable name="times" xml:space="default">
    <xsl:for-each select="./ZeitangabeWissenschaft/Datum">
                     <xsl:variable name="res"><xsl:call-template name="normDate"><xsl:with-param name="date" select="./@date"/><xsl:with-param name="attr" select="'Zeitangabe'"/></xsl:call-template></xsl:variable>
                     {{#subobject:
        <xsl:value-of select="$res/node()/node()[1]/data(.)"/> 
                    <xsl:if test="exists($res/node()/node()[2]/data(.))"><xsl:value-of select="$res/node()/node()[2]/data(.)"/></xsl:if>}}
            </xsl:for-each>     
</xsl:variable>
                    <xsl:value-of select="$times" xml:space="default"/>
                           
                
                    [[Kategorie:Quelle]]
                    __SHOWFACTBOX__
                    
                    
                        </text>
                <sha1></sha1>
            </revision>
        </page>
         </xsl:template>
    
    <xsl:template match="Anmerkungen">
&lt;poem&gt;<xsl:variable name="na" select="."/>
            <xsl:analyze-string select="." regex="\[(\d\d\d\d)\]\-\[(\d\d\d\d)\]">
                <xsl:matching-substring xml:space="default">[[<xsl:value-of select="normalize-space($na/parent::node()/parent::node()/parent::node()/parent::node()/Dokumente[./WerkId eq regex-group(1)]/WerkTitel)"/><xsl:text> </xsl:text><xsl:value-of select="regex-group(2)"/>]]</xsl:matching-substring>
                <xsl:non-matching-substring>
                   <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>&lt;/poem&gt;
    </xsl:template>
    
    <xsl:template name="kategorien" xml:space="default">
        <xsl:param name="data"/>
        <xsl:param name="type"/>
        <xsl:param name="enti"/>
        <xsl:variable name="items" xml:space="default">
            <xsl:for-each select="$data" xml:space="default">
                <item>| <xsl:value-of select="$type"/>=<xsl:value-of select="."/></item>
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
    <xsl:template match="entity">
        <xsl:variable name="ia" select="./@id/data(.)"/> 
        <xsl:text>[&#x200b;[[</xsl:text><xsl:value-of select="@type"/><xsl:text>::</xsl:text><xsl:value-of select="$lists/node()/node()[@id eq $ia]/Name"/><xsl:text> | </xsl:text><xsl:value-of select="."/><xsl:text>]]&#x200b;]</xsl:text>
    </xsl:template>
    <xsl:template match="VolltextOriginalsprache | VolltextUebersetzung | Inhaltsangabe | ZitationUebersetzung" xml:space="default" >
 <!--
     ./parent::node()/parent::node()/parent::node()/parent::node()/parent::node()/Personen/Person
        <xsl:variable name="terms">
            <xsl:for-each select="parent::node()/Entitaeten/Entitaet">
                <item><xsl:attribute name="type" select="./@Type"/>##<xsl:value-of select="./Name/data(.)"/>#</item>
                <item><xsl:attribute name="type" select="./@Type"/>##<xsl:value-of select="./Name/data(.)"/>:#</item>
            </xsl:for-each>
           
           <xsl:for-each select="parent::node()/Suchbegriffe/Suchwort">
                <item><xsl:attribute name="type">Suchbegriffe</xsl:attribute>##<xsl:value-of select="./data(.)"/>#</item>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="replacment">
            <xsl:for-each select="$terms/node()">
                <xsl:variable name="sel"><xsl:choose>
                    <xsl:when test="contains(.,':')">[&#x200b;[[<xsl:value-of select="./@type"/>::<xsl:value-of select="substring-before(substring-after(.,'##'),':#')"/>]]&#x200b;:]</xsl:when>
                    <xsl:otherwise>[&#x200b;[[<xsl:value-of select="./@type"/>::<xsl:value-of select="substring-before(substring-after(.,'##'),'#')"/>]]&#x200b;]</xsl:otherwise>
                </xsl:choose>
                </xsl:variable>
                <item><xsl:value-of select="$sel"/></item>
            </xsl:for-each>
        </xsl:variable>          
       <xsl:variable name="tex" select="replace(replace(./text(),'\&#93;','#'),'\&#91;','##')"/>
        <xsl:variable name="repl" select="functx:replace-multi($tex,$terms/node(),$replacment/node())"/>       
&lt;poem&gt;<xsl:value-of select="replace(replace(replace($repl,'##','&#91;'),'#','&#93;'),'\\n','\\n \\n')"/>&lt;/poem&gt;
    -->
        &lt;poem&gt;<xsl:apply-templates/>&lt;/poem&gt;
    </xsl:template>
    <xsl:template match="VolltextOriginalsprache/text() | VolltextUebersetzung/text() | Inhaltsangabe/text() | ZitationUebersetzung/text()"><xsl:value-of select="."/></xsl:template>
    <xsl:template name="normDate">
        <xsl:param name="attr"/>
        <xsl:param name="date"/>        
        <xsl:if test="$date != ''"><time>
            <xsl:variable name="first">
                    <xsl:choose>
                        <xsl:when test="starts-with($date,'-')">-<xsl:value-of select="substring-before(substring-after($date,'-'),'-')"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="substring-before($date,'-')"/></xsl:otherwise>
                    </xsl:choose>              
            </xsl:variable>
            <from><tag><xsl:value-of select="concat(' |',$attr,'Beginn=')" xml:space="default"/></tag><num><xsl:value-of select="$first"/></num></from>
            <xsl:if test="not($first eq substring-after($date,concat($first,'-')))">
                <to><tag><xsl:value-of select="concat(' |',$attr,'Ende=')" xml:space="default"/></tag><num><xsl:value-of select="substring-after($date,concat($first,'-'))"/></num></to>             
            </xsl:if></time>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>