<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:media="http://www.mediawiki.org/xml/export-0.10/"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" version="2.0">
    
    <xsl:param name="fid">300</xsl:param>
    <xsl:param name="sid">2</xsl:param>    
    <xsl:function name="functx:eq-any-of" as="xs:boolean"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="searchStrings" as="xs:string*"/>        
        <xsl:sequence select="
            some $searchString in $searchStrings
            satisfies $arg eq $searchString
            "/>        
    </xsl:function>
    
    <xsl:template match="/">
        <xsl:variable name="list"><list>
            <xsl:apply-templates/>
        </list></xsl:variable>
        
        <xsl:variable name="aufa">
            <xsl:for-each select="distinct-values(.//Auffaelligkeiten/Schlagwort)">
                <item><xsl:value-of select="normalize-space(.)"/></item>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="such">
            <xsl:for-each select="distinct-values(.//Suchbegriffe/Suchwort)">
                <item><xsl:value-of select="normalize-space(.)"/></item>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="geo">
            <xsl:for-each select="distinct-values(.//GeographischesStichwort/Ort)">
                <item><xsl:value-of select="normalize-space(.)"/></item>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="regionen">
            <xsl:for-each select="distinct-values(.//Regionen/Region/data(.))">
                <item><xsl:value-of select="normalize-space(.)"/></item>
            </xsl:for-each>
        </xsl:variable> 
        <xsl:variable name="list2">
            <xsl:for-each select="distinct-values($aufa/item)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Auffälligkeit</mentioned>
                </entity>
            </xsl:for-each>            
            <xsl:for-each select="distinct-values($such/item)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Suchbegriffe</mentioned>
                </entity>
            </xsl:for-each>
            <xsl:for-each select="distinct-values($geo/item)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Ort</mentioned>
                </entity>
            </xsl:for-each>
            <!--
            <xsl:for-each select="distinct-values($regionen/item)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Abfassungsregion</mentioned>
                </entity>
            </xsl:for-each>
            -->
        </xsl:variable>
       <!--
        <xsl:value-of select="count($list/node()/node()/node()[1])"/>
        <br/>
        <xsl:value-of select="count(distinct-values($list/node()/node()/node()[1]))"/>
        <xsl:value-of select="conta"/>
     
        <xsl:copy-of select="$list"/>
        <xsl:copy-of select="$list2"/>
       --> 
        <xsl:variable name="list3">
        <xsl:for-each select="$list2/entity">          
            <xsl:if test="functx:eq-any-of(./main,($list//main, $list//second))">
                <xsl:variable name="hit" select="."/>
                <xsl:for-each select="$list//entity">
                    <xsl:if test="./main eq $hit/main">
                        <entity>
                            <xsl:attribute name="id" select="./@id"/>
                            <xsl:copy-of select="./*"/>
                            <xsl:for-each select="$hit/mentioned">
                                <mentioned><name><xsl:value-of select="."/></name></mentioned>
                            </xsl:for-each>
                            <!--<mentioned><xsl:value-of select="$hit/mentioned"/></mentioned>-->
                        </entity>
                    </xsl:if>
                    <xsl:if test="functx:eq-any-of($hit/main, ./second)">
                        <entity>
                            <xsl:attribute name="id" select="./@id"/>
                            <xsl:copy-of select="./*"/>
                            <xsl:for-each select="$hit/mentioned">
                                <mentioned><xsl:attribute name="second" select="."></xsl:attribute><name><xsl:value-of select="$hit/main"/></name></mentioned>
                            </xsl:for-each>
                          <!--  <mentioned><xsl:attribute name="second" select="$hit/mentioned"></xsl:attribute><xsl:value-of select="$hit/main"/></mentioned>-->
                        </entity>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="not(functx:eq-any-of(./main,($list//main, $list//second)))">
                <entity>
                    <xsl:attribute name="id" select="./main"/>
                    <main><xsl:value-of select="./main"/></main>
                    <xsl:for-each select="./mentioned">
                        <mentioned><name><xsl:value-of select="."/></name></mentioned>
                    </xsl:for-each>
                </entity>
            </xsl:if>
            
        </xsl:for-each>
            <xsl:for-each select="$list//entity">
                <xsl:if test="not(functx:eq-any-of(./main,$list2//main))">
                        <entity>
                            <xsl:attribute name="id" select="./@id"/>
                            <main><xsl:value-of select="./main"/></main>
                            <xsl:for-each select="./mentioned">
                                <mentioned><name><xsl:value-of select="."/></name></mentioned>
                            </xsl:for-each>
                            <xsl:if test="exists(./Lebensdaten)"><Lebensdaten><xsl:value-of select="./Lebensdaten/text()"/></Lebensdaten></xsl:if>
                            <xsl:if test="exists(./Rolle)"><xsl:for-each select="./Rolle"><Rolle><xsl:value-of select="."/></Rolle></xsl:for-each></xsl:if>
                            <xsl:if test="exists(./getty_Id)"><getty_Id><xsl:value-of select="./getty_Id"/></getty_Id></xsl:if>
                            <xsl:if test="exists(geo_getty)"><xsl:copy-of select="geo_getty"/></xsl:if>
                            <xsl:if test="exists(./gnd_Id)"><gnd_Id><xsl:value-of select="./gnd_Id"/></gnd_Id></xsl:if>
                            <xsl:if test="exists(./Typ)"><xsl:for-each select="./Typ"><Typ><xsl:value-of select="."/></Typ></xsl:for-each></xsl:if>
                        </entity>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="list4" >
        <xsl:for-each-group select="$list3/entity" group-by="./@id">
            <entity>
                <xsl:attribute name="id" select="distinct-values(current-group()/@id)"/>
                <main><xsl:value-of select="distinct-values(current-group()/main)"/></main>
               <xsl:for-each select="distinct-values(current-group()/second)">
                   <second><xsl:value-of select="."/></second>
               </xsl:for-each>
                <xsl:if test="exists(current-group()/Lebensdaten)"><Lebensdaten><xsl:value-of select="distinct-values(current-group()/Lebensdaten/text())"/></Lebensdaten></xsl:if>
                <xsl:if test="exists(current-group()/Rolle)"><xsl:for-each select="distinct-values(current-group()/Rolle)"><Rolle><xsl:value-of select="."/></Rolle></xsl:for-each></xsl:if>
                <xsl:if test="exists(current-group()/getty_Id)"><getty_Id><xsl:value-of select="distinct-values(current-group()/getty_Id)"/></getty_Id></xsl:if>
                <xsl:if test="exists(current-group()/gnd_Id)"><gnd_Id><xsl:value-of select="distinct-values(current-group()/gnd_Id)"/></gnd_Id></xsl:if>
                <xsl:if test="exists(current-group()/geo_getty)"><geo_getty><longitude><xsl:value-of select="distinct-values(current-group()/geo_getty/longitude)"/></longitude><latitude><xsl:value-of select="distinct-values(current-group()/geo_getty/latitude)"/></latitude></geo_getty></xsl:if>
                <xsl:if test="exists(current-group()/Typ)"><xsl:for-each select="distinct-values(current-group()/Typ)"><Typ><xsl:value-of select="."/></Typ></xsl:for-each></xsl:if>
                <xsl:for-each-group select="current-group()/mentioned" group-by="./name">
                    <xsl:for-each select="current-group()">
                        <mentioned>
                            <xsl:if test="./@second">
                                <xsl:attribute name="second" select="distinct-values(./@second)"></xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="current-grouping-key()"/>
                        </mentioned>
                    </xsl:for-each>                    
                </xsl:for-each-group>
            </entity>
        </xsl:for-each-group>        
            </xsl:variable>
        
        <xsl:variable name="regionen">
            <xsl:for-each select="distinct-values(.//Regionen/Region)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Abfassungsregion</mentioned>
                </entity>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:variable name="menti">
            <xsl:for-each select="$list4//mentioned">
                <xsl:if test="exists(./attribute())">
                    <entity>
                        <main><xsl:value-of select="."/></main>
                        <mentioned><xsl:value-of select="./@second"/></mentioned>
                        <link>#REDIRECT [[<xsl:value-of select="parent::node()/main"/>]]</link>
                    </entity>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>       
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
            <xsl:for-each select="($list4/entity,$menti/entity)">
            
                <xsl:variable name="name" select="main"/>
            
                <!--
                <xsl:variable name="name">
                    <xsl:choose>
                        <xsl:when test="./@id != ''"><xsl:value-of select="substring-after(./@id,'-')"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="main"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                -->
            <xsl:variable name="set">
                <xsl:if test="exists(./Lebensdaten)"><item>Lebensdaten=<xsl:value-of select="./Lebensdaten"/></item></xsl:if>
                <xsl:if test="exists(./Rolle)"><xsl:for-each select="Rolle"><item>Rolle=<xsl:value-of select="."/></item></xsl:for-each></xsl:if>
            </xsl:variable>
            <xsl:variable name="va" xml:space="default">&lt;ul&gt;<xsl:for-each select="second">&lt;li&gt;<xsl:value-of select="."/>&lt;/li&gt;</xsl:for-each>&lt;/ul&gt;</xsl:variable>
                <xsl:variable name="ro" xml:space="default">&lt;ul&gt;<xsl:for-each select="Rolle">&lt;li&gt;<xsl:value-of select="."/>&lt;/li&gt;</xsl:for-each>&lt;/ul&gt;</xsl:variable>
                <xsl:variable name="se" xml:space="default">
                    <xsl:if test="exists(second)"><xsl:text>&lt;br /&gt; Für </xsl:text><xsl:value-of select="$name"/><xsl:text> werden diese Alternativnamen verwendet:</xsl:text><xsl:value-of select="$va"></xsl:value-of></xsl:if>
                    <xsl:if test="exists(./Rolle)"><xsl:text>&lt;br /&gt;</xsl:text><xsl:value-of select="$name"/><xsl:text> wird in den Berichten mit folgenden Rollen bzw. Funktionen erwähnt:</xsl:text><xsl:value-of select="$ro"></xsl:value-of></xsl:if>
                    <xsl:if test="getty_Id"><xsl:text>&lt;br /&gt;Weiterführende Hinweise finden Sie bei Getty Thesaurus of Geographic Names Online </xsl:text><xsl:value-of select="concat('[','http://vocab.getty.edu/tgn/',./getty_Id,' Getty]')"/></xsl:if>
                    <xsl:if test="gnd_Id"><xsl:text>&lt;br /&gt;Weiterführende Hinweise finden Sie bei </xsl:text><xsl:value-of select="concat('[','http://d-nb.info/gnd/',./gnd_Id,' GND]')"/></xsl:if>
                </xsl:variable>
            <page>
                <title>
                    <xsl:value-of select="$name"/>
                </title>
                <ns>0</ns>
                <id>
                    <xsl:value-of select="position() + $fid"/>
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
                    <text xml:space="default" bytes="3441">
<xsl:if test="exists(link)"><xsl:value-of select="link"/></xsl:if>
                        {{WikiProject_Transwiki/Template:Infobox
                        |title=
                        |above=<xsl:value-of select="$name"/>
                        |image=
                        |caption=
                        
                        |bodyclass = class;
                        |bodystyle = background:#FFFFFF; width:33%; vertical-align:right; border-style: ridge;
                        |abovestyle = background:#1b98d0; 
                        |headerstyle  = background:#1b98d0; 
                        |labelstyle   = background:#1b98d0; width:30%;
                        |datastyle    = 
                        
                        |label1=getty
                        |data1=<xsl:value-of select="./geo_getty"/>
                        |label2=viaf
                        |data2=
                        |label3=gnd
                        |data3=
                        }}
                        <xsl:if test="exists(./geo_getty)">
                            {{#display_map:center=<xsl:value-of select="./geo_getty/latitude"/>,<xsl:value-of select="./geo_getty/longitude"/>}}
{{#set:
|latitude=<xsl:value-of select="./geo_getty/latitude"/>
                            |longitude=<xsl:value-of select="./geo_getty/longitude"/>
}}
                        </xsl:if>
                        {{#set:
                        <xsl:value-of select="string-join($set/node(),' |')"/>
                        }}
<xsl:if test="exists(./Lebensdaten)">Lebensdaten: <xsl:value-of select="./Lebensdaten/data(.)"/></xsl:if>                        
<xsl:value-of select="$se" xml:space="default"/>                        
                        <xsl:for-each select="mentioned">
                            <xsl:if test="not(exists(./attribute()))">
                                 <xsl:choose xml:space="default">
                                     <xsl:when test=". eq 'VerfasserIn'">
=== Werke des Verfassers ===
                                         {{#ask: 
                                         [[Kategorie:Werk]]
                                         [[VerfasserIn::<xsl:value-of select="$name"/>]]                    
                                         |?Abfassungszeit#
                                         |?Berichtszeitraum#
                                         |?Abfassungsort
                                         |format=table
                                         |mainlabel=Werke des Verfassers
                                         }}
                                     </xsl:when>
                                     <xsl:when test=". eq 'Person'">
=== Personennennung ===
Übersicht über die Nennung von <xsl:value-of select="$name"/> im Repertorium Saracenorum:
                                         {{#ask: 
                                         [[Kategorie:Quelle]]
                                         [[Person::<xsl:value-of select="$name"/>]]
                                         |?Interaktion# 
                                         |?VerfasserIn
                                         |?Werk
                                         |?Datierung#
                                         |?QuellenAngabe#
                                         |?Abfassungsort
                                         |format=table
                                         |mainlabel=Personennennung
                                         }}
                                     </xsl:when>
                                     <xsl:when test=". eq 'Ort'">
=== Ortsnennungen ===
Übersicht über die Nennung von <xsl:value-of select="$name"/> im Repertorium Saracenorum
                                         {{#ask: 
                                         [[Kategorie:Quelle]]
                                         [[Ort::<xsl:value-of select="$name"/>]]
                                         |?Interaktion# 
                                         |?VerfasserIn 
                                         |?Werk
                                         |?Datierung#
                                         |?QuellenAngabe#
                                         |?Abfassungsort
                                         |format=table
                                         |mainlabel=Ortsnennungen
                                         }}
                                     </xsl:when>
                                     <!--<xsl:when test=". eq 'Abfassungsregion'">
=== Abfassungsregion ===
                                         {{#ask: 
                                         [[Kategorie:Werk]]
                                         [[Abfassungsregion::<xsl:value-of select="$name"/>]]
                                         |?VerfasserIn
                                         |?Datierung#
                                         |?Abfassungsort
                                         |format=table
                                         |mainlabel=Abfassungsregion
                                         }}
                                     </xsl:when>
                                     
                                     <xsl:when test=". eq 'Abfassungsregion'">
=== Abfassungsregion ===
                                         {{#ask: 
                                         [[Kategorie:Werk]]
                                         [[Abfassungsregion::<xsl:value-of select="$name"/>]]
                                         |?Sarazenenbezug# 
                                         |?VerfasserIn
                                         |?Berichtszeitraum#
                                         |?Abfassungszeit#
                                         |?Abfassungsort
                                         |format=table
                                         |mainlabel=Abfassungsregion
                                         }}
                                     </xsl:when>
                                     -->
                                     <xsl:when test=". eq 'Suchbegriffe'">
=== Suchbegriff ===
Übersicht über die Verwendung von <xsl:value-of select="$name"/> als Suchbegriff:
                                         {{#ask: 
                                         [[Kategorie:Quelle]]
                                         [[Suchbegriffe::<xsl:value-of select="$name"/>]]
                                         |?Interaktion# 
                                         |?VerfasserIn
                                         |?Werk
                                         |?Datierung#
                                         |?QuellenAngabe#
                                         |?Abfassungsort
                                         |format=table
                                         |mainlabel=Suchbegriff
                                         }}
                                     </xsl:when>
                                     <xsl:when test=". eq 'Auffälligkeit'">
=== Vorkommen ===
                                         {{#ask: 
                                         [[Kategorie:Quelle]]
                                         [[Auffälligkeit::<xsl:value-of select="$name"/>]]
                                         |?Interaktion# 
                                         |?VerfasserIn
                                         |?Werk
                                         |?Datierung#
                                         |?QuellenAngabe#
                                         |?Abfassungsort
                                         |format=table
                                         |mainlabel=Auffälligkeit
                                         }}
                                     </xsl:when>
                                 </xsl:choose>                                
                                <xsl:if test="not(. eq 'Ort')">[[Kategorie:<xsl:value-of select="."/>]]</xsl:if>                          
                            </xsl:if>
                        </xsl:for-each>
                        
                        <xsl:for-each select="mentioned">
                            <xsl:if test="exists(./attribute())">
                                <xsl:choose>
                                    <xsl:when test="./@second eq 'VerfasserIn'">
=== Werke des Verfassers <xsl:value-of select="."/> ===
                                        {{#ask: 
                                        [[Kategorie:Werk]]
                                        [[VerfasserIn::<xsl:value-of select="."/>]]                    
                                        |?Abfassungszeit#
                                        |?Berichtszeitraum#
                                        |?Abfassungsort
                                        |format=table
                                        |mainlabel=Werke des Verfassers <xsl:value-of select="."/>
                                        }}
                                    </xsl:when>
                                    <xsl:when test="./@second eq 'Person'">
=== Personennennung <xsl:value-of select="."/> ===
                                        {{#ask: 
                                        [[Kategorie:Quelle]]
                                        [[Person::<xsl:value-of select="."/>]]
                                        |?Interaktion# 
                                        |?VerfasserIn
                                        |?Werk
                                        |?Datierung#
                                        |?QuellenAngabe#
                                        |?Abfassungsort
                                        |format=table
                                        |mainlabel=Personennennung <xsl:value-of select="."/>
                                        }}
                                    </xsl:when>
                                    <xsl:when test="./@second eq 'Ort'">
=== Ortsnennungen <xsl:value-of select="."/> ===
                                        {{#ask: 
                                        [[Kategorie:Quelle]]
                                        [[Ort::<xsl:value-of select="."/>]]
                                        |?Interaktion# 
                                        |?VerfasserIn 
                                        |?Werk
                                        |?Datierung#
                                        |?QuellenAngabe#
                                        |?Abfassungsort
                                        |format=table
                                        |mainlabel=Ortsnennungen <xsl:value-of select="."/>
                                        }}
                                    </xsl:when>
                                    <!--
                                    <xsl:when test="./@second eq 'Abfassungsregion'">
=== Abfassungsregion <xsl:value-of select="."/> ===
                                        {{#ask: 
                                        [[Kategorie:Werk]]
                                        [[Abfassungsregion::<xsl:value-of select="."/>]]
                                        |?VerfasserIn
                                        |?Datierung#
                                        |?Abfassungsort
                                        |format=table
                                        |mainlabel=Abfassungsregion <xsl:value-of select="."/>
                                        }}
                                    </xsl:when>
                                    -->
                                    <xsl:when test="./@second eq 'Suchbegriffe'">
=== Suchbegriff <xsl:value-of select="."/> ===
                                        {{#ask: 
                                        [[Kategorie:Quelle]]
                                        [[Suchbegriffe::<xsl:value-of select="."/>]]
                                        |?Interaktion# 
                                        |?VerfasserIn
                                        |?Werk
                                        |?Datierung#
                                        |?QuellenAngabe#
                                        |?Abfassungsort
                                        |format=table
                                        |mainlabel=Suchbegriff <xsl:value-of select="."/>
                                        }}
                                    </xsl:when>
                                    <xsl:when test="./@second eq 'Auffälligkeit'">
=== Vorkommen <xsl:value-of select="."/> ===
                                        {{#ask: 
                                        [[Kategorie:Quelle]]
                                        [[Auffälligkeit::<xsl:value-of select="."/>]]
                                        |?Interaktion# 
                                        |?VerfasserIn
                                        |?Werk
                                        |?Datierung#
                                        |?QuellenAngabe#
                                        |?Abfassungsort
                                        |format=table
                                        |mainlabel=Auffälligkeit <xsl:value-of select="."/>
                                        }}
                                    </xsl:when>
                                </xsl:choose>                                
                                <xsl:if test="not(./@second eq 'Ort')">[[Kategorie:<xsl:value-of select="./@second"/>]]</xsl:if>                          
                                                               
                            </xsl:if>
                        </xsl:for-each>
                        
                        <xsl:if test="exists(Typ)">
                            <xsl:for-each select="Typ">
                                [[Kategorie:<xsl:value-of select="."/>]]  
                            </xsl:for-each>
                        </xsl:if>
                    </text>
                    <sha1></sha1>
                </revision>
            </page>
        </xsl:for-each>           
        
            <xsl:for-each select="$regionen/node()">
                <page>
                    <title>Kategorie:<xsl:value-of select="./main"/></title>
                    <ns>0</ns>
                    <id>
                        <xsl:value-of select="position() + $fid"/>
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
                        <text xml:space="default" bytes="3441">
                            [[Kategorie:Abfassungsregion]]
                            [[has type::page]]
                        </text>                        
                        <sha1></sha1>
                    </revision>
                </page>
            </xsl:for-each>
        </mediawiki>
    </xsl:template>
    
    <xsl:template match="VerfasserInnen/VerfasserIn | Personen/Person | Orte/Ort" >
        <entity>
            <xsl:attribute name="id" select="concat(name(),'-',Id)"></xsl:attribute>
            <main><xsl:value-of select="Name"/></main>
            <xsl:for-each select="./Alternativnamen/Name">
                <second><xsl:value-of select="."/></second>
            </xsl:for-each>
            <xsl:if test="exists(Lebensdaten)"><Lebensdaten><xsl:value-of select="Lebensdaten/text()"/></Lebensdaten></xsl:if>
            <xsl:if test="exists(Rolle)"><xsl:for-each select="./Rolle"><Rolle><xsl:value-of select="."/></Rolle></xsl:for-each></xsl:if>
            <xsl:if test="exists(getty_Id)"><getty_Id><xsl:value-of select="getty_Id"/></getty_Id></xsl:if>
            <xsl:if test="exists(geo_getty)"><xsl:copy-of select="geo_getty"/></xsl:if>
            <xsl:if test="exists(gnd_Id) and gnd_Id != ''"><gnd_Id><xsl:value-of select="gnd_Id"/></gnd_Id></xsl:if>
            <xsl:if test="exists(Typ)"><xsl:for-each select="Typ"><Typ><xsl:value-of select="."/></Typ></xsl:for-each></xsl:if>
            <mentioned><xsl:value-of select="name()"/></mentioned>
        </entity>
    </xsl:template>
    
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>