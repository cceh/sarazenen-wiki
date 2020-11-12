<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" version="1.1"  indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:variable name="persList">        
        <xsl:for-each-group select="Sarazenen//entity" group-by="./@id">
            <entity>
                <xsl:attribute name="id" select="current-grouping-key()"></xsl:attribute>
            <xsl:for-each select="distinct-values(current-group())">
                <name>
                    <xsl:value-of select="."/>
                </name>
            </xsl:for-each>
            </entity>
        </xsl:for-each-group>
    </xsl:variable>
    <xsl:template match="Person | VerfasserIn | Ort">
        <xsl:element name="{./name()}">
            <xsl:attribute name="id" select="./Id"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="Person/Alternativnamen">
        <xsl:variable name="id" select="parent::node()/Id/data(.)"/>
        <Alternativnamen>
            <xsl:for-each select="distinct-values(($persList/entity[@id=$id]/name,./Name))">
                <Name><xsl:value-of select="."/></Name></xsl:for-each>
        </Alternativnamen>
    </xsl:template>
</xsl:stylesheet>