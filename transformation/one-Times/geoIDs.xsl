<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output method="xml" version="1.1"  indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    
    
    <xsl:variable name="places" select="/Sarazenen/Orte/Ort"/>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="Quelle/GeographischesStichwort/Ort">
        <xsl:variable name="name" select="."/>
       <xsl:for-each select="$places">
           <xsl:variable name="id" select="./@id"/>
           <xsl:for-each select="(./Name,./Alternativnamen/Name)">
           <xsl:if test="$name eq .">
               <Ort><xsl:attribute name="id" select="$id"/><xsl:value-of select="$name"/></Ort>
           </xsl:if>
           </xsl:for-each>
           
       </xsl:for-each>
    </xsl:template>
    
    
</xsl:stylesheet>