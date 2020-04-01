<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.mediawiki.org/xml/export-0.10/"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" version="1.1" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"
      exclude-result-prefixes="#all"/>
    <!--
    <xsl:variable name="files" select="(doc('../files/sarazenen_masterfassung.xml'),doc('../files/Negativquellen_ergaenzt.xml'))"/>
    -->
    <xsl:template match="/" xml:space="default">
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
                    {| class="wikitable sortable"
                    |-
                    ! Verfasser
                    ! Werk
                    ! Sarazenen
                    ! Nummer
                    <xsl:for-each select="./Sarazenen/Dokumente">
                     
                        <xsl:value-of  xml:space="default">
                        |-                         
                        | <xsl:choose><xsl:when test="exists(./Autoren/Autor[2])">
                            <xsl:for-each select="./Autoren/Autor">
                                <xsl:if test="position() > 1"><xsl:text>; </xsl:text></xsl:if>
                                <xsl:text>[[:Kategorie:</xsl:text> <xsl:value-of select="."/> | <xsl:value-of select="."/><xsl:text>]]</xsl:text>                                 
                            </xsl:for-each>
                        </xsl:when>
                            <xsl:when test="./Autoren/Autor[1] eq 'unbekannt'">
                                <xsl:text>[[:Kategorie: unbekannt | unbekannt]]</xsl:text>
                            </xsl:when>
                            <xsl:otherwise> <xsl:text>[[:Kategorie: </xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/><xsl:text> | </xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/>]]</xsl:otherwise>
                        </xsl:choose> </xsl:value-of>
                            <xsl:value-of  xml:space="default">
                            
                            | [[<xsl:value-of select="./WerkTitel"/> | <xsl:value-of select="./WerkTitel"/>]]
                            </xsl:value-of>
                            <xsl:value-of  xml:space="default">
                                
                                <xsl:value-of  xml:space="default">
                            | <xsl:choose>
                                <xsl:when test="exists(./Quellen/Quelle)"><xsl:text>ja</xsl:text></xsl:when>
                                <xsl:otherwise><xsl:text>nein</xsl:text></xsl:otherwise>
                            </xsl:choose></xsl:value-of>
                            </xsl:value-of>
                            <xsl:value-of  xml:space="default">
                            
                            | <xsl:value-of select="./WerkId"/>
                            </xsl:value-of>
                        
                    </xsl:for-each>
                  |}
                </text>
                    <sha1/>                    
                </revision>
            </page>
        </mediawiki>
    </xsl:template>
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>
