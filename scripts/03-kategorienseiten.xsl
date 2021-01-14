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
          <xsl:variable name="max">0</xsl:variable>
            
            <xsl:variable name="max" select="$max"/>
           
            <xsl:variable name="places" select="distinct-values(./Sarazenen/Orte/Ort/Typ/data(.))"/>
            <xsl:for-each select="$places">
               <xsl:if test=".!=''"> <xsl:call-template name="kateg">
                    <xsl:with-param name="data" select="."/>
                    <xsl:with-param name="pos" select="position() + $fid + $max"/>
                    <xsl:with-param name="pos2" select="position() + $fid"/>
                    <xsl:with-param name="parent"><xsl:text>Geographie</xsl:text></xsl:with-param>
                </xsl:call-template></xsl:if>
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
<!--                <xsl:value-of select="$pos"/>-->
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
                <text xml:space="preserve" bytes="3441">
                    <xsl:if test="$parent eq 'Abfassungsregion'">#REDIRECT [[<xsl:value-of select="$data"/>]]</xsl:if>
                    [[Kategorie:<xsl:value-of select="$parent"/>]]
            </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>