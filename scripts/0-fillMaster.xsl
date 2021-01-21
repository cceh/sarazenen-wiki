<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:schema="http://schema.org/"
    xmlns:sparql="http://www.w3.org/2005/sparql-results#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:gvp="http://vocab.getty.edu/ontology#"
    xmlns:schemaDataset="http://schema.org/Dataset"
    exclude-result-prefixes="#all"
    version="2.0">
    <!--<xsl:output method="text"></xsl:output>-->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="Orte/Ort">
        <Ort>
            <xsl:attribute name="id" select="./@id"></xsl:attribute>
            <xsl:apply-templates/>
            <viaf><xsl:attribute name="id"><xsl:call-template name="sparql"><xsl:with-param name="lib">P214</xsl:with-param><xsl:with-param name="id" select="./getty_Id"></xsl:with-param></xsl:call-template></xsl:attribute></viaf>
            <gnd><xsl:attribute name="id"><xsl:call-template name="sparql"><xsl:with-param name="lib">P227</xsl:with-param><xsl:with-param name="id" select="./getty_Id"></xsl:with-param></xsl:call-template></xsl:attribute></gnd> 
            </Ort>        
    </xsl:template>
    
    <xsl:template match="getty_Id">
        <getty>
            <xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
            
            <xsl:if test="not(. eq '0')">
            <xsl:variable name="getty" select="doc(concat('http://vocab.getty.edu/tgn/',replace(./text(),' ',''),'.rdf'))"/>
                <xsl:attribute name="updated" select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/>
                <coordinates>
                    <xsl:attribute name="latitude"><xsl:call-template name="correct-cords"><xsl:with-param name="cord" select="$getty//schema:geo//schema:latitude"></xsl:with-param></xsl:call-template></xsl:attribute>
                    <xsl:attribute name="longitude"><xsl:call-template name="correct-cords"><xsl:with-param name="cord" select="$getty//schema:geo//schema:longitude"></xsl:with-param></xsl:call-template></xsl:attribute>
                    <xsl:call-template name="correct-cords"><xsl:with-param name="cord" select="$getty//schema:geo//schema:latitude"></xsl:with-param></xsl:call-template>,<xsl:call-template name="correct-cords"><xsl:with-param name="cord" select="$getty//schema:geo//schema:longitude"></xsl:with-param></xsl:call-template>             
                </coordinates>
                <ScopeNote>
                    <xsl:value-of select="$getty//gvp:ScopeNote/rdf:value"/>
                </ScopeNote>            
        </xsl:if>
        </getty>
    </xsl:template>
    <xsl:template match="VerfasserIn/wikidata_Id">
        <xsl:variable name="i" select="."/>
        <wikidata>
            <xsl:attribute name="id" select="$i"/>            
            <xsl:if test=". != '' and  starts-with($i,'Q')" >
                <xsl:attribute name="updated" select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/>
                <xsl:variable name="data" select="doc(concat('https://www.wikidata.org/wiki/Special:EntityData/',$i,'.rdf'))" as="node()"/>
                <xsl:variable name="idurl">http://www.wikidata.org/entity/<xsl:value-of select="$i"/></xsl:variable>
            <desc>    
                <xsl:attribute name="lang">de</xsl:attribute>
                <xsl:value-of select="$data//rdf:Description[@rdf:about=$idurl][2]/schema:description[@xml:lang='de']"/>
            </desc>
                <desc>    
                    <xsl:attribute name="lang">en</xsl:attribute>
                    <xsl:value-of select="$data//rdf:Description[@rdf:about=$idurl][2]/schema:description[@xml:lang='en']"/>
                </desc>                
        </xsl:if>
            <xsl:if test=". != '' and  not(starts-with($i,'Q'))" >
                <xsl:attribute name="broekn">true</xsl:attribute>
            </xsl:if>
        </wikidata>
    </xsl:template>
    
    <xsl:template match="Person/wikidata_Id">
        <xsl:variable name="i" select="."/>
        <xsl:if test=". != '' and  starts-with($i,'Q')" >
        <wikidata>
            <xsl:attribute name="id" select="$i"/>      
                <xsl:attribute name="updated" select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/>
                <xsl:variable name="data" select="doc(concat('https://www.wikidata.org/wiki/Special:EntityData/',$i,'.rdf'))" as="node()"/>
                <xsl:variable name="idurl">http://www.wikidata.org/entity/<xsl:value-of select="$i"/></xsl:variable>
                <desc>    
                    <xsl:attribute name="lang">de</xsl:attribute>
                    <xsl:value-of select="$data//rdf:Description[@rdf:about=$idurl][2]/schema:description[@xml:lang='de']"/>
                </desc>
                <desc>    
                    <xsl:attribute name="lang">en</xsl:attribute>
                    <xsl:value-of select="$data//rdf:Description[@rdf:about=$idurl][2]/schema:description[@xml:lang='en']"/>
                </desc>          
        </wikidata>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="viaf_Id | gnd_Id">
        <xsl:if test=". != ''">
            <xsl:element name="{name()}">
                <xsl:value-of select="."/>
            </xsl:element>
            <!--
            <xsl:if test="name() eq 'gnd_Id'">
                <germania>
                    <xsl:call-template name="germania-sacra"><xsl:with-param name="gnd" select="."/></xsl:call-template>
                </germania>
            </xsl:if>-->
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="sparql">
        <xsl:param name="lib"/>
        <xsl:param name="id"/>
        <xsl:value-of select="doc(concat('https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=SELECT%20%3Fid%20WHERE%20%7B%20%3Fitem%20wdt:P1667%20%22',$id,'%22%20.%20%3Fitem%20wdt:',$lib,'%20%3Fid%20%7D'))//sparql:literal"/>
    </xsl:template>
    
    <xsl:template name="correct-cords">
        <xsl:param name="cord"/>
        <xsl:choose>
            <xsl:when test="starts-with($cord,'.')"><xsl:value-of select="concat('0',$cord)"/></xsl:when>
            <xsl:when test="starts-with($cord,'-.')"><xsl:value-of select="concat('-0',substring-after($cord,'-'))"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$cord"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
    <xsl:template name="germania-sacra">
        <xsl:param name="gnd"/>
        <xsl:variable name="amp"><xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text></xsl:variable>
        <xsl:variable name="output" select="concat('http://personendatenbank.germania-sacra.de/api/v1.0/person?query[0][field]=person.gndnummer',$amp,'query[0][value]=',$gnd,$amp,'format=xml')"/>
        <xsl:value-of select="$output"  disable-output-escaping="yes"/>
        <!-\-
        <xsl:if test="$o1">
            <xsl:copy-of  select="$o1" ></xsl:copy-of>
        </xsl:if>-\->
    </xsl:template>-->
</xsl:stylesheet>