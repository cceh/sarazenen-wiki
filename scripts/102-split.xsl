<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:param name="fid">1000</xsl:param>
    <xsl:param name="size">100</xsl:param>
    <xsl:param name="div">50</xsl:param>
    <xsl:param name="foldername">./output/split</xsl:param>
    <xsl:template match="/">
        <xsl:variable name="all" select="count(.//*:page)"/>
        <xsl:variable name="max" select="xs:integer(round((count(.//*:page)-$div) div $size))"/>
        <xsl:variable name="page" select="."/>
        <xsl:for-each select="(1 to $max)">
            
            <xsl:variable name="start" select="xs:integer((. *$size - ($size -1)))"/>
            <xsl:variable name="end" select="xs:integer((. * $size))"/>
            
            <xsl:result-document href="{$foldername}/{.}.xml" method="xml">
            <mediawiki xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns="http://www.mediawiki.org/xml/export-0.10/"
                xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/"
                version="0.10"
                xml:lang="de">
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
                <xsl:for-each select="($start to $end)">
                    <xsl:variable name="posi" select="."/>
                    <xsl:apply-templates select="$page//*:page[$posi]"><xsl:with-param name="pos" select="."></xsl:with-param></xsl:apply-templates>
                </xsl:for-each>
            </mediawiki>
            </xsl:result-document>
            <xsl:if test="xs:integer(. * $size) eq xs:integer($max*$size)">
                <xsl:variable name="start" select="xs:integer((. *$size + 1))"/>
                <xsl:result-document href="{$foldername}/{. +1}.xml" method="xml">
                    <mediawiki xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                        xmlns="http://www.mediawiki.org/xml/export-0.10/"
                        xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/"
                        version="0.10"
                        xml:lang="de">
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
                <xsl:for-each select="($start to $all)">
                    <xsl:variable name="posi" select="."/>                    
                    <xsl:apply-templates select="$page//*:page[$posi]"><xsl:with-param name="pos" select="."></xsl:with-param></xsl:apply-templates>
                </xsl:for-each>
                    </mediawiki>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
      </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:param name="pos"></xsl:param>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"><xsl:with-param name="pos" select="$pos"></xsl:with-param></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="*:page/*:id">
        <xsl:param name="pos"></xsl:param>
        <id><xsl:choose><xsl:when test=".=''"><xsl:value-of select="xs:integer($pos)+ $fid"/></xsl:when><xsl:otherwise><xsl:value-of select="."/></xsl:otherwise></xsl:choose></id>
    </xsl:template>
    <xsl:template match="*:revision/*:id">
        <xsl:param name="pos"></xsl:param>
        <id><xsl:value-of select="xs:integer($pos)+ $fid"/></id>
    </xsl:template>
    <!--<xsl:template match="text()"></xsl:template>-->
</xsl:stylesheet>