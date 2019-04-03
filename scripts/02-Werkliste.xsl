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
                <id>21</id>
                <revision>
                    <id>3467</id>
                    <parentid>3466</parentid>
                    <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                    <contributor>
                        <username>Administrator</username>
                        <id>1</id>
                    </contributor>
                    <model>wikitext</model>
                    <format>text/x-wiki</format>
                <text>
                    <xsl:text>&lt;table&gt;</xsl:text>
                        
                    <xsl:for-each-group select="$files//Dokumente" group-by="substring(./WerkTitel,1,1)">                        
                        <xsl:sort order="ascending" lang="de"  select="current-grouping-key()"></xsl:sort>
                        <xsl:text>&lt;tr&gt;&lt;th&gt;Werk&lt;/th&gt;&lt;th&gt;Nummer&lt;/th&gt;&lt;th&gt;Verfasser&lt;/th&gt;</xsl:text>
                            <!--
                            &lt;th&gt;Bericht&lt;br/&gt;Beginn&lt;/th&gt;&lt;th&gt;Bericht&lt;br/&gt;Ende&lt;/th&gt;&lt;th&gt;Abfassung&lt;br/&gt;Beginn&lt;/th&gt;&lt;th&gt;Abfassung&lt;br/&gt;Ende&lt;/th&gt;
                            -->
                            <xsl:text>&lt;th&gt;Sarazenen&lt;/th&gt;&lt;/tr&gt;</xsl:text>
                        <xsl:text>&lt;tr&gt;&lt;td&gt;</xsl:text><xsl:text>===</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>===</xsl:text><xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
                        
                        <xsl:for-each select="current-group()">               
                            <xsl:text>&lt;tr&gt;</xsl:text>
                           <!-- <xsl:sort select="./WerkTitel/data(.)"></xsl:sort> -->
                                <!-- Werk -->
                       <xsl:text>&lt;td&gt;</xsl:text> <xsl:text>[[</xsl:text><xsl:value-of select="./WerkTitel/data(.)"/><xsl:text> | </xsl:text><xsl:value-of select="./WerkTitel/data(.)"/><xsl:text>]]</xsl:text>   
                       <xsl:text>&lt;/td&gt;</xsl:text>
                            <xsl:text>&lt;td&gt;</xsl:text><xsl:value-of select="./WerkId"/><xsl:text>&lt;/td&gt;</xsl:text>
                            
                                <!-- Verfasser -->
                                <xsl:text>&lt;td&gt;</xsl:text>
                           <xsl:text>([[:Kategorie:</xsl:text><xsl:choose><xsl:when test="exists(./Autoren/Autor[2])">
                                    <xsl:text>Unbekannte oder mehrere Verfasser | Unbekannte oder mehrere Verfasser</xsl:text>
                                </xsl:when>
                                <xsl:when test="./Autoren/Autor[1] eq 'unbekannt'">
                                    <xsl:text>Unbekannte oder mehrere Verfasser | Unbekannte oder mehrere Verfasser</xsl:text>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="./Autoren/Autor/data(.)"/><xsl:text> | </xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/></xsl:otherwise>
                            </xsl:choose><xsl:text>]])</xsl:text>
                                <xsl:text>&lt;/td&gt;</xsl:text>
                                <!-- Bericht Beginn & Ende -->
                                <!-- Abassung Beginn & Ende -->
                                <!-- Sarazen, noch unklar -->
                            <xsl:text>&lt;/tr&gt;</xsl:text>
                        </xsl:for-each>
                            
                    </xsl:for-each-group>
                    <xsl:text>&lt;/table&gt;</xsl:text>
                </text>
                    <sha1/>                    
                </revision>
            </page>
        </mediawiki>
    </xsl:template>
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>
