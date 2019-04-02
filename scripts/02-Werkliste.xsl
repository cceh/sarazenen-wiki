<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.mediawiki.org/xml/export-0.10/"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" version="1.1" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"
      exclude-result-prefixes="#all"/>
    <xsl:variable name="files" select="(doc('../files/sarazenen_masterfassung.xml'),doc('../files/Negativquellen_ergaenzt.xml'))"/>
    <xsl:template match="/">
        <mediawiki
            xmlns="http://www.mediawiki.org/xml/export-0.10/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/ http://www.mediawiki.org/xml/export-0.10.xsd"
            version="0.10" xml:lang="de">
            <siteinfo>
                <sitename>Repertorium Saracenorum</sitename>
                <dbname>sarazenen-bonn</dbname>
                <base>http://saraceni.uni-koeln.de/wiki/Repertorium_Saracenorum</base>
                <generator>MediaWiki 1.27.4</generator>
                <case>first-letter</case>
                <namespaces/>
            </siteinfo>
            <page>
                <title>Werke</title>
                <ns>0</ns>
                <revision>
                    <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                    <contributor>
                        <username>Administrator</username>
                        <id>1</id>
                    </contributor>
                    <model>wikitext</model>
                    <format>text/x-wiki</format>
                </revision>
                <text>
                    <table>
                        
                    <xsl:for-each-group select="$files//Dokumente" group-by="substring(./WerkTitel,1,1)">                        
                        <xsl:sort order="ascending" lang="de"  select="current-grouping-key()"></xsl:sort>
                        <tr><th>Werk</th><th>Kategorie</th></tr>
                        <tr><td><xsl:text>===</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>===</xsl:text></td></tr>
                        
                        <xsl:for-each select="current-group()">               
                            <tr>
                           <!-- <xsl:sort select="./WerkTitel/data(.)"></xsl:sort> -->
                       <td> <xsl:text>[[</xsl:text><xsl:value-of select="./WerkTitel/data(.)"/><xsl:text> | </xsl:text><xsl:value-of select="./WerkTitel/data(.)"/><xsl:text> - </xsl:text><xsl:value-of select="./WerkId/data(.)"/><xsl:text>]]</xsl:text>   
                       </td>
                                <td>
                           <xsl:text>([[:Kategorie:</xsl:text><xsl:choose><xsl:when test="exists(./Autoren/Autor[2])">
                                    <xsl:text>Unbekannte oder mehrere Verfasser | Unbekannte oder mehrere Verfasser</xsl:text>
                                </xsl:when>
                                <xsl:when test="./Autoren/Autor[1] eq 'unbekannt'">
                                    <xsl:text>Unbekannte oder mehrere Verfasser | Unbekannte oder mehrere Verfasser</xsl:text>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="./Autoren/Autor/data(.)"/><xsl:text> | </xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/></xsl:otherwise>
                            </xsl:choose><xsl:text>]])</xsl:text>
                                </td>
                            </tr>
                        </xsl:for-each>
                            
                    </xsl:for-each-group>
                    </table>
                </text>
                    <sha1/>
            </page>
        </mediawiki>
    </xsl:template>
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>
