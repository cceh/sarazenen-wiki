<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" version="2.0">
    
    
    <xsl:param name="fid">300</xsl:param>
    <xsl:param name="sid">2</xsl:param>
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
         
         
         
            <xsl:variable name="orte" select="./Sarazenen/Orte/Ort"/>
            <!--  <xsl:variable name="suchworte" select="distinct-values(.//Suchwort)"/>
                            <xsl:variable name="auffaeligkeiten" select="distinct-values(.//Schlagwort)"/>
         -->  

            <xsl:variable name="person" select="./Sarazenen/Personen/Person"/>

            <xsl:apply-templates select="./Sarazenen/Personen/Person"></xsl:apply-templates>
            <xsl:apply-templates select="./Sarazenen/Orte/Ort"><xsl:with-param name="start" select="count($person)"></xsl:with-param></xsl:apply-templates>
            <xsl:variable name="max" select="count(($person,$orte))"/>
            <xsl:apply-templates select="./Sarazenen/VerfasserInnen/Verfasser"><xsl:with-param name="start" select="$max"></xsl:with-param></xsl:apply-templates>
            <xsl:variable name="Autoren" select="./Sarazenen/VerfasserInnen/Verfasser"/>
            <xsl:variable name="max" select="count(($person,$orte,$Autoren))"/>
          <!--
            <xsl:for-each select="$suchworte">
                <page>
                    <title>
                        <xsl:value-of select="."/>
                    </title>
                    <ns>0</ns>
                    <id>
                        <xsl:value-of select="position() + $fid + $max"/>
                    </id>
                    <revision>
                        <id>
                            <xsl:value-of select="position()+ $fid + $max"/>
                        </id>
                        <parentid>
                            <xsl:value-of select="position()"/>
                        </parentid>
                        <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                        <contributor>
                            <username>Administrator</username>
                            <id>1</id>
                        </contributor>
                        <model>wikitext</model>
                        <format>text/x-wiki</format>
                        <text xml:space="preserve" bytes="3441">
                            {{#ask: 
                            [[Kategorie:Quelle]]
                            [[Suchbegriffe::<xsl:value-of select="."/>]]                    
                            |?Interaktion# 
                            |?Verfasser 
                            |?Werk
                            |?Datierung#
                            |?QuellenAngabe#
                            |?Abfassungsort
                            |format=table
                            |mainlabel=Quelle
                            }}
                    [[Kategorie:Suchbegriffe der Stelle]]
            </text>
                        <sha1></sha1>
                    </revision>
                </page>
            </xsl:for-each>
            
            <xsl:variable name="max" select="count(($person,$orte,$Autoren,$suchworte))"/>
            <xsl:for-each select="$auffaeligkeiten">
                <page>
                    <title>
                        <xsl:value-of select="."/>
                    </title>
                    <ns>0</ns>
                    <id>
                        <xsl:value-of select="position() + $fid + $max"/>
                    </id>
                    <revision>
                        <id>
                            <xsl:value-of select="position()+ $fid + $max"/>
                        </id>
                        <parentid>
                            <xsl:value-of select="position() + $fid"/>
                        </parentid>
                        <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                        <contributor>
                            <username>Administrator</username>
                            <id>1</id>
                        </contributor>
                        <model>wikitext</model>
                        <format>text/x-wiki</format>
                        <text xml:space="preserve" bytes="3441">
                            {{#ask: 
                            [[Kategorie:Quelle]]
                            [[Auffälligkeiten::<xsl:value-of select="."/>]]                    
                            |?Interaktion# 
                            |?Verfasser 
                            |?Werk
                            |?Datierung#
                            |?QuellenAngabe#
                            |?Abfassungsort
                            |format=table
                            |mainlabel=Quelle
                            }}
                    [[Kategorie:Auffälligkeiten]]
            </text>
                        <sha1></sha1>
                    </revision>
                </page>
            </xsl:for-each>
                        <xsl:variable name="max" select="count(($person,$orte,$Autoren,$suchworte,$auffaeligkeiten))"/>

            -->
          
            <xsl:variable name="sec" select="('Geographie','Person','VerfasserIn','Quelle')"/>
            <xsl:for-each select="$sec">
                <xsl:call-template name="kateg">
                    <xsl:with-param name="data" select="."/>
                    <xsl:with-param name="pos" select="position() + $fid + $max"/>
                    <xsl:with-param name="pos2" select="position() + $fid"/>
                    <xsl:with-param name="parent"><xsl:text>Repertorium Saracenorum</xsl:text></xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
            <xsl:variable name="max" select="$max + count($sec)"/>
            <xsl:variable name="places" select="distinct-values(./Sarazenen/Orte/Ort/Typ/data(.))"/>
            <xsl:for-each select="$places">
                <xsl:call-template name="kateg">
                    <xsl:with-param name="data" select="."/>
                    <xsl:with-param name="pos" select="position() + $fid + $max"/>
                    <xsl:with-param name="pos2" select="position() + $fid"/>
                    <xsl:with-param name="parent"><xsl:text>Geographie</xsl:text></xsl:with-param>
                </xsl:call-template>
            </xsl:for-each> 
            <xsl:variable name="max" select="$max + count($places)"/>
            <xsl:variable name="attre"><list><item><i>Abfassungsort</i><e>text</e></item>
                <item><i>Auffäligkeiten</i><e>text</e></item>
                <item><i>Datierung</i><e>text</e></item>
                <item><i>Inhaltsangabe</i><e>text</e></item>
                <item><i>Interaktion</i><e>boolean</e></item>
                <item><i>Ort</i><e>page</e></item>
                <item><i>Person</i><e>page</e></item>
                <item><i>QuellenAngabe</i><e>text</e></item>
                <item><i>Suchbegriffe</i><e>text</e></item>
                <item><i>VerfasserIn</i><e>page</e></item>
                <item><i>Zitation</i><e>text</e></item>
                <item><i>Werk</i><e>page</e></item></list></xsl:variable>
         
            <xsl:for-each select="$attre/node()/node()">
                <xsl:call-template name="attri">
                    <xsl:with-param name="data" select="./node()[1]"/>
                    <xsl:with-param name="pos" select="position() + $fid + $max"/>
                    <xsl:with-param name="pos2" select="position() + $fid"/>
                    <xsl:with-param name="typus" select="./node()[2]"/>
                </xsl:call-template>
            </xsl:for-each>
            
        </mediawiki>
    </xsl:template> 
    
    <xsl:template name="kateg">
        <xsl:param name="pos"/>
        <xsl:param name="pos2"/>
        <xsl:param name="parent"/>
        <xsl:param name="data"/>
        <page>
            <title>Kategorie:<xsl:value-of select="$data"/></title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="$pos"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="$pos"/>
                </id>
                <parentid>
                    <xsl:value-of select="$pos2"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441">
                    [[Kategorie:<xsl:value-of select="$parent"/>]]
            </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    <xsl:template name="attri">
        <xsl:param name="pos"/>
        <xsl:param name="pos2"/>
        <xsl:param name="typus"/>
        <xsl:param name="data"/>
        <page>
            <title>Attribut:<xsl:value-of select="$data"/></title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="$pos"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="$pos"/>
                </id>
                <parentid>
                    <xsl:value-of select="$pos2"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441">[[has type::<xsl:value-of select="$typus"/>]]
            </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    <xsl:template match="Person">
        <xsl:variable name="va" xml:space="default">
            &lt;ul&gt;<xsl:for-each select="./Alternativnamen/Name">&lt;li&gt;<xsl:value-of select="."/>&lt;/li&gt;</xsl:for-each>&lt;/ul&gt;
        </xsl:variable>
        <page>
            <title>
                <xsl:value-of select="./Name"/>
            </title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="position() + $fid"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="position()+ $fid"/>
                </id>
                <parentid>
                    <xsl:value-of select="position() + $fid"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="default" bytes="3441">
                    {{#set:
                    Lebensdaten=Platzhalter Person
                    <xsl:for-each select="./Rolle">|Rolle=<xsl:value-of select="."/></xsl:for-each>
                    }}
Rolle: <xsl:value-of select="string-join(./Rolle,';')"/>                      
Alternativnamen: <xsl:value-of select="$va"/>
                     {{#ask: 
                            [[Kategorie:Quelle]]
                            [[Person::<xsl:value-of select="./Name"/>]]
                            |?Interaktion# 
                            |?Verfasser 
                            |?Werk
                            |?Datierung#
                            |?QuellenAngabe#
                            |?Abfassungsort
                            |format=table
                            }}
                    [[Kategorie:Person]]
            </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    
    
    <xsl:template match="Verfasser">
        <xsl:param name="start"></xsl:param>     
        <xsl:variable name="va" xml:space="default">
            &lt;ul&gt;<xsl:for-each select="./Alternativnamen/Name">&lt;li&gt;<xsl:value-of select="."/>&lt;/li&gt;</xsl:for-each>&lt;/ul&gt;
        </xsl:variable>
        <page>
            <title>
                <xsl:value-of select="./Name"/>
            </title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="position() + $fid + $start"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="position()+ $sid + $start"/>
                </id>
                <parentid>
                    <xsl:value-of select="position()"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="default" bytes="3441">
                    {{#set:
                    Lebensdaten=<xsl:value-of select="./Lebendsdaten"/>
                    |Rolle=VerfasserIn
                    }}
Alternativnamen: <xsl:value-of select="$va"/>
                    {{#ask: 
                    [[Kategorie:Werk]]
                    [[Verfasser::<xsl:value-of select="./Name"/>]]                    
                    |?Abfassungszeit#
                    |?Berichtszeitraum#
                    |?Abfassungsort
                    |format=table
                    |mainlabel=Werke des Verfassers
                    }}
                    [[Kategorie:VerfasserIn]]
                </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    <xsl:template match="Ort">
        <xsl:param name="start"></xsl:param>        
        <xsl:variable name="va" xml:space="default">
            &lt;ul&gt;<xsl:for-each select="./Alternativnamen/Name">&lt;li&gt;<xsl:value-of select="."/>&lt;/li&gt;</xsl:for-each>&lt;/ul&gt;
        </xsl:variable>
        <page>
            <title>
                <xsl:value-of select="./Name"/>
            </title>
            <ns>0</ns>
            <id>
                <xsl:value-of select="position() + $fid + $start"/>
            </id>
            <revision>
                <id>
                    <xsl:value-of select="position()+ $sid + $start"/>
                </id>
                <parentid>
                    <xsl:value-of select="position()"/>
                </parentid>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="default" bytes="3441">   
<xsl:value-of select="$va"/>                   
                     {{#ask: 
                            [[Kategorie:Quelle]]
                            [[Ort::<xsl:value-of select="./Name"/>]]
                            |?Interaktion# 
                            |?Verfasser 
                            |?Werk
                            |?Datierung#
                            |?QuellenAngabe#
                            |?Abfassungsort
                            |format=table
                            }}
[<xsl:value-of select="concat('http://vocab.getty.edu/tgn/',./getty_Id)"/> Getty]
                    <xsl:for-each select="./Typ" xml:space="default">                        
                    [[Kategorie:<xsl:value-of select="."/>]]
                    </xsl:for-each>
            </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>