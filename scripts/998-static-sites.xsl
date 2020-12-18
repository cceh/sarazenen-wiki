<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:param name="foldername">../files/static-sites</xsl:param>
    <xsl:param name="attributes">
        <list>
            <item>Abfassungsort</item>
            <item>Abfassungsregion</item>
            <item>Abfassungszeit</item>
            <item>Berichtszeitraum</item>
            <item>Sarazenenbezug</item>
            <item>Werknummer</item>
            <item>Alternativnamen</item>
            <item>Auffälligkeit</item>
            <item>Ereignete sich in</item>
            <item>Getty coordinates</item>
            <item>Getty id</item>
            <item>Getty text</item>
            <item>Gnd id</item>
            <item>Individuen</item>
            <item>Kollektive</item>
            <item>Viaf id</item>
            <item>Wikidata id</item>
            <item>ZeitangabeBeginn</item>
            <item>ZeitangabeEnde</item>            
            <item>Zitiert nach</item>
        </list>
    </xsl:param>
    <xsl:template  match="/">
        <xsl:for-each select="distinct-values(.//*:Region)">
            <xsl:result-document href="{$foldername}/{replace(concat('Site_',.),' ','-')}.xml" method="xml">                
                <page>
                    <meta>
                        <title><xsl:value-of select="."/></title>
                        <type>Site</type>
                        <id/>
                        <categories>
                            <category>Abfassungsregion</category>
                        </categories>
                        <rules>
                            <rule/>
                        </rules>
                    </meta>
                    <text>     
                        <wikisyntax>
                            {{#ask: [[Abfassungsregion::<xsl:value-of select="."/>]] 
                            |?Abfassungsort
                            |format=broadtable
                            |limit=500
                            |offset=0
                            |link=all
                            |sort=
                            |order=asc
                            |headers=show
                            |searchlabel=… weitere Ergebnisse
                            |class=sortable wikitable smwtable
                            }}
                        </wikisyntax>
                    </text>
                </page>
            </xsl:result-document>
        </xsl:for-each>
        <xsl:for-each select="$attributes//item">
            <xsl:result-document href="{$foldername}/{replace(concat('Attribut_',.),' ','-')}.xml" method="xml">               
            <page>
                <meta>
                    <title><xsl:value-of select="."/></title>
                    <type>Attribut</type>
                    <id/>
                    <categories>
                        <category/>
                    </categories>
                    <rules>
                        <rule/>
                    </rules>
                </meta>
                <text>     
                    <hasPropertyDiscreption>
                        Tooltip Text
                    </hasPropertyDiscreption>
                </text>
            </page>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>