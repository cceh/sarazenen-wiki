<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:schema="http://schema.org/"
    xmlns:sparql="http://www.w3.org/2005/sparql-results#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:gvp="http://vocab.getty.edu/ontology#"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="Orte/Ort">
        <Ort>
            <xsl:attribute name="id" select="./@id"></xsl:attribute>
            <xsl:attribute name="updated" select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/>
            <xsl:apply-templates/>
            <xsl:if test="not(./getty_Id eq '0')">
                <xsl:variable name="getty" select="doc(concat('http://vocab.getty.edu/tgn/',replace(./getty_Id/text(),' ',''),'.rdf'))"/>
                 <getty>
                     <coordinates>
                        <xsl:attribute name="latitude" select="$getty//schema:geo//schema:latitude"/>
                        <xsl:attribute name="longitude" select="$getty//schema:geo//schema:longitude"></xsl:attribute>
                        <xsl:value-of select="$getty//schema:geo//schema:latitude"/>,<xsl:value-of select="$getty//schema:geo//schema:longitude"/>                
                     </coordinates>
                     <ScopeNote>
                         <xsl:value-of select="$getty//gvp:ScopeNote/rdf:value"/>
                     </ScopeNote>
                 </getty>
            </xsl:if>
                <getty_id><xsl:value-of select="./getty_Id"/></getty_id>
                <viaf_id><xsl:call-template name="sparql"><xsl:with-param name="lib">P214</xsl:with-param><xsl:with-param name="id" select="./getty_Id"></xsl:with-param></xsl:call-template></viaf_id>
                <gnd_id><xsl:call-template name="sparql"><xsl:with-param name="lib">P227</xsl:with-param><xsl:with-param name="id" select="./getty_Id"></xsl:with-param></xsl:call-template></gnd_id> 
            </Ort>        
    </xsl:template>
    <xsl:template match="getty_Id"></xsl:template>
    <xsl:template name="sparql">
        <xsl:param name="lib"/>
        <xsl:param name="id"/>
        <xsl:value-of select="doc(concat('https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=SELECT%20%3Fid%20WHERE%20%7B%20%3Fitem%20wdt:P1667%20%22',$id,'%22%20.%20%3Fitem%20wdt:',$lib,'%20%3Fid%20%7D'))//sparql:literal"/>
    </xsl:template>
</xsl:stylesheet>