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
    
    <xsl:template match="/">
        <Sarazenen>
            <Abassungsregionen>
                <xsl:for-each-group select=".//Region" group-by=".">
                    <Region>
                        <Name><xsl:value-of select="."/></Name>
                        <Orte>
                        <xsl:for-each-group select="current-group()/parent::node()/parent::node()/Abfassungsort/Ort" group-by="./@id">
                                <Ort>
                                    <xsl:attribute name="id" select="current-grouping-key()"/>
                                    <xsl:value-of select="."/>
                                </Ort>
                        </xsl:for-each-group>
                        </Orte>
                    </Region>
                </xsl:for-each-group>
            </Abassungsregionen>
            <xsl:apply-templates></xsl:apply-templates>
        </Sarazenen>
    </xsl:template>
</xsl:stylesheet>