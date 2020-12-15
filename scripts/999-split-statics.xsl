<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:param name="foldername">../files/static-sites</xsl:param>
    <xsl:template  match="/">
        <xsl:for-each select=".//page">
            <xsl:result-document href="{$foldername}/{replace(concat(./meta/type,'_',./meta/title),' ','-')}.xml" method="xml">
              
            <xsl:apply-templates select="."/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>