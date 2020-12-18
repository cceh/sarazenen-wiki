<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" version="1.1"  indent="no" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all" xml:space="default"/>    
    
    <xsl:param name="path">../files/static-sites</xsl:param>
    <xsl:template match="/" xml:space="default">
        <xsl:variable name="files" select="collection(concat($path,'?select=*.xml'))"/>
        <mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/"
            version="0.10" xml:lang="de" xml:space="default">
            <!--<xsl:copy-of select="$fill-mergelists"></xsl:copy-of>-->
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
<xsl:for-each select="$files/page" xml:space="default">
            <page>
            <title><xsl:if test="./meta/type !='' and ./meta/type !='Site'"><xsl:value-of select="concat(./meta/type,':')"/></xsl:if><xsl:value-of select="./meta/title"/></title>
            <ns>0</ns>
            <id><xsl:value-of select="./meta/id"/></id>
            <revision>
                <id>0</id>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor><xsl:choose>
                    <xsl:when test="exists(./meta/model)">
                        <xsl:copy-of select="./meta/model"/>
                        <xsl:copy-of select="./meta/format"></xsl:copy-of>
                    </xsl:when>
                    <xsl:otherwise>
                <model>wikitext</model>
                <format>text/x-wiki</format></xsl:otherwise></xsl:choose><text xml:space="preserve" bytes="3441"><xsl:apply-templates select="./text" xml:space="default"/><xsl:for-each select="./meta/categories/category" xml:space="default"><xsl:if test=". != ''"> 
[[Kategorie:<xsl:value-of select="."/>]]</xsl:if>
</xsl:for-each>
</text>
                <sha1/>
            </revision>
            </page>
</xsl:for-each>
        </mediawiki>
    </xsl:template>
    <xsl:template match="div | pre | noinclude | onlyinclude" xml:space="default">
        <xsl:choose>
<xsl:when test="exists(./attribute())">
&lt;<xsl:value-of select="name()"/><xsl:text> </xsl:text><xsl:for-each select="./attribute()"><xsl:value-of select="name()"/>=&quot;<xsl:value-of select="."/>&quot; </xsl:for-each>&gt;
</xsl:when>
<xsl:otherwise>&lt;div&gt;</xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates xml:space="default"/>
&lt;/<xsl:value-of select="name()"/>&gt;</xsl:template>
    <xsl:template match="wikisyntax" xml:space="default">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="header" xml:space="default"><xsl:variable name="level"><xsl:for-each select="(1 to ./@level)">=</xsl:for-each></xsl:variable><xsl:value-of select="string-join(($level,.,$level),' ')" xml:space="default"/></xsl:template>
    <xsl:template match="ul" xml:space="default">
<xsl:for-each select="./li">* <xsl:apply-templates/>
</xsl:for-each>
    </xsl:template>
    <xsl:template match="a" xml:space="default">[[<xsl:if test="./@linking = 'no'">:</xsl:if><xsl:value-of select="./@link"/> | <xsl:value-of select="."/> ]]</xsl:template>
    <xsl:template match="b" xml:space="default">'''<xsl:apply-templates xml:space="default"/>'''</xsl:template>
    <xsl:template match="i" xml:space="default">''<xsl:apply-templates xml:space="default"/>''</xsl:template>
    <xsl:template match="tab" xml:space="default">; <xsl:apply-templates xml:space="default"/></xsl:template>
    <xsl:template match="text()" xml:space="default"><xsl:value-of select="normalize-space(.)"/></xsl:template>
</xsl:stylesheet>