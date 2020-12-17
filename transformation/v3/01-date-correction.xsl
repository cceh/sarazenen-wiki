<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="Datum">
        <Datum>
            <xsl:choose>
                <xsl:when test="starts-with(./@date,'-')">
                    <xsl:variable name="from" select="concat('-',substring-before(substring-after(./@date,'-'),'-'))"/>
                    <xsl:variable name="to" select="substring-after(substring-after(./@date,'-'),'-')"/>
                    <xsl:choose>
                        <xsl:when test="$from eq $to"><xsl:attribute name="date" select="$from"/></xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="from" select="$from"/>
                            <xsl:attribute name="to" select="$to"></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>                    
                    <xsl:variable name="from" select="substring-before(./@date,'-')"/>
                    <xsl:variable name="to" select="substring-after(./@date,'-')"/>
                    <xsl:choose>
                        <xsl:when test="$from eq $to"><xsl:attribute name="date" select="$from"/></xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="from" select="$from"/>
                            <xsl:attribute name="to" select="$to"></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="."/>
        </Datum>
    </xsl:template>
    
</xsl:stylesheet>