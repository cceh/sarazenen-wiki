<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    exclude-result-prefixes="#all" version="2.0">
    
    <xsl:param name="fid">1000</xsl:param>
    <xsl:variable name="all" select="count(collection('../output?select=*.xml')//*:page)" />
    <xsl:template match="/">    
            <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="siteinfo"></xsl:template>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*:revision/*:id">
        <id><xsl:value-of select="count(parent::node()/parent::node()/preceding-sibling::node()) + $fid + $all"/></id>
    </xsl:template>
    
    <xsl:template match="*:page/*:id">
        <id><xsl:value-of select="count(parent::node()/preceding-sibling::node())  + $fid"/></id>
    </xsl:template>
    
</xsl:stylesheet>