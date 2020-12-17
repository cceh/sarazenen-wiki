<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output method="xml" version="1.1"  indent="yes"  undeclare-prefixes="yes"  exclude-result-prefixes="#all" doctype-system="sarazenen_masterfassung_v2-1.dtd"/>    
    
    <xsl:template match="@* | node()"  xml:space="default">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" xml:space="default"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="Anmerkungen[.!='']">
        <editorial_notes>
            <notes>
                <note><xsl:value-of select="."/></note>
            </notes>
        </editorial_notes>
    </xsl:template>
    <xsl:template match="Anmerkungen[.='']"><editorial_notes/></xsl:template>

</xsl:stylesheet>