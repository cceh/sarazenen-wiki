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
        <xsl:variable name="Register-List">
            <xsl:apply-templates/>
        </xsl:variable>
        
        <xsl:variable name="List-from-Quellen">
            <xsl:for-each select="distinct-values(.//Auffaelligkeiten/Schlagwort)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Auffälligkeit</mentioned>
                </entity>
            </xsl:for-each>
            <xsl:for-each select="distinct-values(.//Suchbegriffe/Suchwort)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Suchbegriffe</mentioned>
                </entity>
            </xsl:for-each>
            <xsl:for-each select="distinct-values(.//GeographischesStichwort/Ort)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Ort</mentioned>
                </entity>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:variable name="Merge-List-from-Quellen">
            <xsl:for-each-group select="$List-from-Quellen/entity" group-by="./main">
                <entity>
                    <main><xsl:value-of select="current-grouping-key()"/></main>
                    <xsl:for-each select="current-group()/mentioned">
                        <mentioned><xsl:value-of select="."/></mentioned>                        
                    </xsl:for-each>
                </entity>
            </xsl:for-each-group>
        </xsl:variable>
        
        <xsl:variable name="check-lists-each-other">
            <xsl:for-each select="$Merge-List-from-Quellen/entity">          
                <xsl:if test="functx:eq-any-of(./main,($Register-List//main, $Register-List//second))">
                    <xsl:variable name="hit" select="."/>
                    <xsl:for-each select="$Register-List//entity">
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
                            </entity>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="not(functx:eq-any-of(./main,($Register-List//main, $Register-List//second)))">
                    <entity>
                        <xsl:attribute name="id" select="./main"/>
                        <!--<main><xsl:value-of select="./main"/></main>-->
                        
                        <xsl:copy-of select="./*"/>
                        <xsl:for-each select="./mentioned">
                            <mentioned><name><xsl:value-of select="."/></name></mentioned>
                        </xsl:for-each>
                    </entity>
                </xsl:if>
                
            </xsl:for-each>
            <xsl:for-each select="$Register-List//entity">
                <xsl:if test="not(functx:eq-any-of(./main,$Merge-List-from-Quellen//main))">
                    <entity>
                        <xsl:attribute name="id" select="./@id"/>
                        <main><xsl:value-of select="./main"/></main>
                        <xsl:for-each select="./mentioned">
                            <mentioned><name><xsl:value-of select="."/></name></mentioned>
                        </xsl:for-each>
                        <xsl:copy-of select="./meta"></xsl:copy-of>
                    </entity>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="fill-mergelists" >
            <xsl:for-each-group select="$check-lists-each-other/entity" group-by="./@id">
                <entity>
                    <xsl:attribute name="id" select="distinct-values(current-group()/@id)"/>
                    <main><xsl:value-of select="distinct-values(current-group()/main)"/></main>
                    <xsl:for-each select="distinct-values(current-group()/second)">
                        <second><xsl:value-of select="."/></second>
                    </xsl:for-each>
                   <!-- <xsl:copy-of select="current-group()[1]/Typ"/>-->
                    <xsl:for-each select="distinct-values(current-group()/Typ)">
                        <Typ><xsl:value-of select="."/></Typ>
                    </xsl:for-each>
                    <xsl:copy-of select="current-group()[1]/meta"></xsl:copy-of>
                    <xsl:for-each-group select="current-group()/mentioned" group-by="./name">
                        <xsl:for-each select="current-group()">
                            <mentioned>
                                <xsl:if test="./@second">
                                    <xsl:attribute name="second" select="distinct-values(./@second)"></xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="current-grouping-key()"/>
                            </mentioned>
                        </xsl:for-each>                    
                    </xsl:for-each-group><test>
                        <xsl:for-each select="current-group()/meta/node()[.=preceding-sibling::node()]">
<!--                        <xsl:if test=". !=''"><xsl:element name="{.}"></xsl:element></xsl:if>
-->                    <xsl:copy-of select="."></xsl:copy-of>
                        </xsl:for-each></test>
                </entity>
            </xsl:for-each-group>        
        </xsl:variable>
        <!--
        <xsl:variable name="regionen">
            <xsl:for-each select="distinct-values(.//Regionen/Region)">
                <entity>
                    <main><xsl:value-of select="."/></main>
                    <mentioned>Abfassungsregion</mentioned>
                </entity>
            </xsl:for-each>
        </xsl:variable>
        -->
        <xsl:variable name="mentioned-entrys">
            <xsl:for-each select="$fill-mergelists//mentioned">
                <xsl:if test="exists(./attribute())">
                    <entity>
                        <main><xsl:value-of select="."/></main>
                        <mentioned><xsl:value-of select="./@second"/></mentioned>
                        <link>#REDIRECT [[<xsl:value-of select="parent::node()/main"/>]]</link>
                    </entity>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        
       <!-- <list>
            <register-list><xsl:value-of select="count($Register-List/entity)"/></register-list>
            <list-from-quellen><xsl:value-of select="count($List-from-Quellen/entity)"/></list-from-quellen>
            <Merge-list-from-quellen><xsl:value-of select="count($Merge-List-from-Quellen/entity)"/></Merge-list-from-quellen>
            <list3><xsl:value-of select="count($check-lists-each-other/entity)"/></list3>
            <list4><xsl:value-of select="count($fill-mergelists/entity)"/></list4>
            <xsl:copy-of select="$fill-mergelists"></xsl:copy-of>
        </list>-->
        
        
        
        <mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/"
            version="0.10" xml:lang="de">
            <xsl:copy-of select="$fill-mergelists"></xsl:copy-of>
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
            <xsl:for-each select="$fill-mergelists/entity">
                <xsl:variable name="name" select="./main"/>
                <xsl:variable name="output" xml:space="default">
                    <xsl:for-each select="(mentioned, ./meta/Typ)" xml:space="default">
                        <xsl:if test="not(exists(./attribute()))">
                            <xsl:choose xml:space="default">
                                <xsl:when test=". eq 'VerfasserIn'">
=== Werke des Verfassers ===
{{#ask: 
[[Kategorie:Werk]]
[[abgefasst von::<xsl:value-of select="$name"/>]]                    
|?Abfassungszeit#
|?Berichtszeitraum#
|?abgefasst in
|format=table
|mainlabel=Werke des Verfassers
}}
                                </xsl:when>
                                <xsl:when test=". eq 'Person'">
=== Personennennung ===
Übersicht über die Nennung von "<xsl:value-of select="$name"/>" im Repertorium Saracenorum:
{{#ask: 
[[Kategorie:Quelle]]
[[Person::<xsl:value-of select="$name"/>]]
|?Interaktion# 
|?abgefasst von
|?aus dem Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Personennennung
}}
                                </xsl:when>
                                <xsl:when test=". eq 'Ort'">
=== Ortsnennungen ===
Übersicht über die Nennung von "<xsl:value-of select="$name"/>" im Repertorium Saracenorum
{{#ask: 
[[Kategorie:Quelle]]
[[geographischer Bezug::<xsl:value-of select="$name"/>]]
|?Interaktion# 
|?abgefasst von 
|?aus dem Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Ortsnennungen
}}
                                </xsl:when>
                                <xsl:when test=". eq 'Suchbegriffe'">
=== Suchbegriff ===
Übersicht über die Verwendung von "<xsl:value-of select="$name"/>" als Suchbegriff:
{{#ask: 
[[Kategorie:Quelle]]
[[relevante Schlagworte::<xsl:value-of select="$name"/>]]
|?Interaktion# 
|?abgefasst von
|?aus dem Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Suchbegriff
}}
                                </xsl:when>
                                <xsl:when test=". eq 'Auffälligkeit'">
=== Auffälligkeit ===
Auflistung aller mit der Auffälligkeit "<xsl:value-of select="$name"/> " annotierten Quellenstellen
{{#ask: 
[[Kategorie:Quelle]]
[[berichtet von::<xsl:value-of select="$name"/>]]
|?Interaktion# 
|?abgefasst von
|?Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Auffälligkeit
}}
                                </xsl:when>
                            </xsl:choose>                                
                        </xsl:if>
                    </xsl:for-each>                    
                    <xsl:for-each select="mentioned" xml:space="default">
                        <xsl:if test="exists(./attribute())">
                            <xsl:choose xml:space="default">
                                <xsl:when test="./@second eq 'VerfasserIn'">
=== Werke des Verfassers <xsl:value-of select="."/> ===
{{#ask: 
[[Kategorie:Werk]]
[[abgefasst von::<xsl:value-of select="."/>]]                    
|?Abfassungszeit#
|?Berichtszeitraum#
|?abgefasst in
|format=table
|mainlabel=Werke des Verfassers <xsl:value-of select="."/>
}}
                                </xsl:when>
                                <xsl:when test="./@second eq 'Person'">
=== Personennennung <xsl:value-of select="."/> ===
Übersicht über die Nennung von "<xsl:value-of select="."/>" im Repertorium Saracenorum:
{{#ask: 
[[Kategorie:Quelle]]
[[Person::<xsl:value-of select="."/>]]
|?Interaktion# 
|?abgefasst von
|?aus dem Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Personennennung <xsl:value-of select="."/>
}}
                                </xsl:when>
                                <xsl:when test="./@second eq 'Ort'">
=== Ortsnennungen <xsl:value-of select="."/> ===
Übersicht über die Nennung von "<xsl:value-of select="."/>" im Repertorium Saracenorum:                    
{{#ask: 
[[Kategorie:Quelle]]
[[Geographischer Bezug::<xsl:value-of select="."/>]]
|?Interaktion# 
|?abgefasst von 
|?aus dem Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Ortsnennungen <xsl:value-of select="."/>
}}
                                </xsl:when>
                                <xsl:when test="./@second eq 'Suchbegriffe'">
=== Suchbegriff <xsl:value-of select="."/> ===
Auflistung aller mit der Suchbegriff "<xsl:value-of select="."/> " annotierten Quellenstellen
{{#ask: 
[[Kategorie:Quelle]]
[[relevante Schlagworte::<xsl:value-of select="."/>]]
|?Interaktion# 
|?abgefasst von
|?aus dem Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Suchbegriff <xsl:value-of select="."/>
}}
                                </xsl:when>
                                <xsl:when test="./@second eq 'Auffälligkeit'">
=== Auffälligkeit <xsl:value-of select="."/> ===
Auflistung aller mit der Auffälligkeit "<xsl:value-of select="."/> " annotierten Quellenstellen
{{#ask: 
[[Kategorie:Quelle]]
[[berichtet von::<xsl:value-of select="."/>]]
|?Interaktion# 
|?abgefasst von
|?aus dem Werk
|?datiert auf#
|?Datum laut Werk#
|?abgefasst in
|format=table
|mainlabel=Auffälligkeit <xsl:value-of select="."/>
}}

                                </xsl:when>
                            </xsl:choose>                                                 
                            
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <page>
                    <title>
                        <xsl:value-of select="normalize-space($name)"/>
                    </title>
                    <ns>0</ns>
                    <id>     </id>
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
                            <xsl:if test="./meta/editorial_notes/notes/note">
                                <xsl:for-each select="./meta/editorial_notes/notes/note">
<xsl:if test=". != ''">{{Template:Description|type=note|Text=<xsl:value-of select="."/>}}</xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                            <xsl:if test="./meta/getty/ScopeNote != ''">
{{Template:Description|type=getty|id={{#show:{{FULLPAGENAME}}|?getty_id|link=none}}|Text=<xsl:value-of select="./meta/getty/ScopeNote"/>}}
                            </xsl:if>                            
                            <xsl:if test="./meta/wikidata/desc != ''">
{{Template:Description|type=wikidata|id={{#show:{{FULLPAGENAME}}|?wikidata_id|link=none}}|Text=<xsl:choose>
    <xsl:when test="./meta/wikidata/desc[@lang='de'] != ''"><xsl:value-of select="./meta/wikidata/desc[@lang='de']/data(.)"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="./meta/wikidata/desc[@lang='en']/data(.)"/></xsl:otherwise>
                                </xsl:choose>}}
                            </xsl:if>                             
<xsl:variable name="typs" xml:space="default"><xsl:for-each select="./meta/Typ" xml:space="default"><xsl:choose>
                                <xsl:when test=". eq 'Ort'">
{{Template:Ort |Name={{FULLPAGENAME}}|Alternativnamen={{#show:{{FULLPAGENAME}}|?Alternativnamen|link=none}}|getty_id={{#show:{{FULLPAGENAME}}|?getty_id|link=none}}|viaf_id={{#show:{{FULLPAGENAME}}|?viaf_id|link=none}}||wikidata_id={{#show:{{FULLPAGENAME}}|?wikidata_id|link=none}}|getty_coordinates={{#show:{{FULLPAGENAME}}|?getty_coordinates|link=none}}}}
                                </xsl:when>
                                <xsl:when test=". eq 'Person'">
{{Template:Person |Name={{FULLPAGENAME}}|Alternativnamen={{#show:{{FULLPAGENAME}}|?Alternativnamen|link=none}}
|Rolle={{#show:{{FULLPAGENAME}}|?Rolle|link=none}}
|gnd_id={{#show:{{FULLPAGENAME}}|?gnd_id|link=none}}
|wikidata_id={{#show:{{FULLPAGENAME}}|?wikidata_id|link=none}}
|viaf_id={{#show:{{FULLPAGENAME}}|?viaf_id|link=none}}}}<!--{{Template:Description|type=wikidata|id={{#show:{{FULLPAGENAME}}|?wikidata_id|link=none}}|Text={{#show:{{FULLPAGENAME}}|?wikidata_desc|link=none}}}}-->
                                </xsl:when>
                                <xsl:when test=". eq 'VerfasserIn'">
{{Template:VerfasserIn
|Name={{FULLPAGENAME}}
|Alternativnamen={{#show:{{FULLPAGENAME}}|?Alternativnamen|link=none}}
|Rolle={{#show:{{FULLPAGENAME}}|?Rolle|link=none}}
|Lebensdaten={{#show:{{FULLPAGENAME}}|?Lebensdaten|link=none}}
|gnd_id={{#show:{{FULLPAGENAME}}|?gnd_id|link=none}}
|wikidata_id={{#show:{{FULLPAGENAME}}|?wikidata_id|link=none}}
|viaf_id={{#show:{{FULLPAGENAME}}|?viaf_id|link=none}}}}</xsl:when>                     
</xsl:choose></xsl:for-each></xsl:variable>
<xsl:value-of select="$typs" xml:space="default"/>
<xsl:value-of select="$output" xml:space="default"/>
                            
                            
                            <xsl:variable name="meta" xml:space="default"><xsl:apply-templates select="./meta"/></xsl:variable>
                            <xsl:if test="$meta != ''">{{#set:<xsl:value-of select="$meta"/>
                                }}</xsl:if>
                            <xsl:variable name="mentioned" ><xsl:if test="not(./mentioned/@second)"><xsl:value-of select="./mentioned/text()"/></xsl:if></xsl:variable>
                            <xsl:for-each select="distinct-values((./meta/Typ,./mentioned/@second,$mentioned))">
<xsl:if test=".!=''">[[Kategorie:<xsl:value-of select="."/>]]  </xsl:if>
                            </xsl:for-each>
                            __SHOWFACTBOX__
                        </text>
                        <sha1></sha1>
                    </revision>
                </page>
            </xsl:for-each>
            
            <xsl:for-each select="$mentioned-entrys/entity">
                <xsl:variable name="name" select="./main"/>
                <page>
                    <title>
                        <xsl:value-of select="$name"/>
                    </title>
                    <ns>0</ns>
                    <id>   </id>
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
                            <xsl:value-of select="./link"/>
                            [[Kategorie:<xsl:value-of select="./mentioned"/>]] 
                        </text>
                        <sha1></sha1>
                    </revision>
                </page>
            </xsl:for-each>
        </mediawiki>
    </xsl:template>
   
   
   
   
    <xsl:template match="VerfasserInnen/VerfasserIn | Personen/Person | Orte/Ort" >
        <xsl:variable name="id" select="./@id"/>
        <entity>
            <xsl:attribute name="id" select="Id"></xsl:attribute>
            <main><xsl:value-of select="Name"/></main>
            <Typ><xsl:value-of select="name()"/></Typ>
            <xsl:for-each select="./Alternativnamen/Name">
                <second><xsl:value-of select="."/></second>
            </xsl:for-each>            
          <meta>
              <xsl:if test="not(exists(./Typ))"><Typ><xsl:value-of select="name()"/></Typ></xsl:if>
              <xsl:if test="name() eq 'Ort'">
                  <root><xsl:value-of select="parent::node()/parent::node()/name()"/></root>
                  <xsl:for-each select="distinct-values(parent::node()/parent::node()//Abfassungsort/Ort[@id=$id]/parent::node()/parent::node()/Regionen/Region)"><Abfassungsregion><xsl:value-of select="."/></Abfassungsregion></xsl:for-each>
              </xsl:if>
              <xsl:copy-of select="./node()"></xsl:copy-of>
          </meta>
        </entity>
    </xsl:template>
    
    <xsl:template match="Rolle">
        <xsl:if test=". != ''">
        |Rolle=<xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="getty">
        <xsl:if test="./@id != ''">
            |getty_id=<xsl:value-of select="./@id"/>
        </xsl:if>
        <xsl:if test="./coordinates/@latitude != ''">|getty_coordinates=<xsl:value-of select="./coordinates"/></xsl:if> 
<!--            |getty_text=<xsl:value-of select="./ScopeNote"/>-->
    </xsl:template>
    

    <xsl:template match="wikidata">
        <xsl:if test="./@id != ''">
        |wikidata_id=<xsl:value-of select="./@id"/>
        </xsl:if>
        <xsl:if test="./desc != ''">
        |wikidata_description=<xsl:choose>
            <xsl:when test="./desc[@lang='de'] != ''"><xsl:value-of select="./desc[@lang='de']"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="./desc[@lang='en']"/></xsl:otherwise>
        </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="gnd">
        <xsl:if test="./@id != ''">            
            |gnd_id=<xsl:value-of select="./@id"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="gnd_Id">
        <xsl:if test=". != ''">
        |gnd_id=<xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="viaf">
        <xsl:if test="./@id != ''">
        |viaf_id=<xsl:value-of select="./@id"/>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="viaf_Id" >
        <xsl:if test=". != ''">
        |viaf_id=<xsl:value-of select="."/>
    </xsl:if>
    </xsl:template>
    
    <xsl:template match="Lebensdaten">
        <xsl:if test=". != ''">
        |Lebensdaten=<xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="Alternativnamen/Name">
        <xsl:if test=". != ''">
        |Alternativnamen=<xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="editorial_notes/coordinates">
        |getty_coordinates_editorial=<xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="meta/Abfassungsregion">
        |Abfassungsregion=<xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>