<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:schema="http://schema.org/"
    xmlns:sparql="http://www.w3.org/2005/sparql-results#"
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
            <xsl:copy-of select="./node()"/>
            <xsl:if test="not(./getty_Id eq '0')">
            <xsl:variable name="getty" select="doc(concat('http://vocab.getty.edu/tgn/',replace(./getty_Id/text(),' ',''),'.rdf'))"/>
             <geo_getty>
                <latitude><xsl:value-of select="$getty//schema:geo//schema:latitude"/></latitude>
                <longitude><xsl:value-of select="$getty//schema:geo//schema:longitude"/></longitude>
             </geo_getty>
            </xsl:if>
           <!--
            <xsl:variable name="i"><xsl:text>"</xsl:text>7008799<xsl:text>"</xsl:text></xsl:variable>
            <xsl:variable name="tet" select="concat('https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=SELECT%20%3Fid%20WHERE%20%7B%20%3Fitem%20wdt:P1667%20%22','7005233','%22%20.%20%3Fitem%20wdt:','P227','%20%3Fid%20%7D')"/> 
            <xsl:copy-of select="doc($tet)//literal" xpath-default-namespace="http://www.w3.org/2005/sparql-results#"/>
           
                
https://query.wikidata.org/bigdata/namespace/wdq/sparql%3Fquery=SELECT %3Fid WHERE%20%7B %3Fitem wdt:P1667 ',$i,' . %3Fitem wdt:P214 %3Fid%7D'
            <xsl:value-of select=" doc-available(concat('https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=SELECT%20?id%20WHERE%20{%20?item%20wdt:P1667%20%22','7008799','%22%20.%20?item%20wdt:','P227','%20?id%20}'))"/>
           https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=SELECT ?id WHERE%20{ ?item wdt:P1667 "7008799" . ?item wdt:P214 ?id}
           https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=SELECT%20?id%20WHERE%20{%20?item%20wdt:P1667%20%227008799%22%20.%20?item%20wdt:P227%20?id%20}
            -->
            <ids>
            <viaf_id><xsl:call-template name="sparql"><xsl:with-param name="lib">P214</xsl:with-param><xsl:with-param name="id" select="./getty_Id"></xsl:with-param></xsl:call-template></viaf_id>
                <gnd_id><xsl:call-template name="sparql"><xsl:with-param name="lib">P227</xsl:with-param><xsl:with-param name="id" select="./getty_Id"></xsl:with-param></xsl:call-template></gnd_id>
            </ids>
            
            </Ort>
        
    </xsl:template>
    <xsl:template name="sparql">
        <xsl:param name="lib"/>
        <xsl:param name="id"/>
        <xsl:value-of select="doc(concat('https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=SELECT%20%3Fid%20WHERE%20%7B%20%3Fitem%20wdt:P1667%20%22',$id,'%22%20.%20%3Fitem%20wdt:',$lib,'%20%3Fid%20%7D'))//sparql:literal"/>
    </xsl:template>
</xsl:stylesheet>