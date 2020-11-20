<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output method="xml" version="1.1"  indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    
    
    
    <xsl:function name="functx:if-absent" as="item()*"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="item()*"/>
        <xsl:param name="value" as="item()*"/>
        
        <xsl:sequence select="
            if (exists($arg))
            then $arg
            else $value
            "/>
        
    </xsl:function>
    <xsl:function name="functx:replace-multi" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="changeFrom" as="xs:string*"/>
        <xsl:param name="changeTo" as="xs:string*"/>
        
        <xsl:sequence select="
            if (count($changeFrom) > 0)
            then functx:replace-multi(
            replace($arg, $changeFrom[1],
            functx:if-absent($changeTo[1],'')),
            $changeFrom[position() > 1],
            $changeTo[position() > 1])
            else $arg
            "/>
        
    </xsl:function>
    <xsl:function name="functx:contains-any-of" as="xs:boolean"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="searchStrings" as="xs:string*"/>
        
        <xsl:sequence select="
            some $searchString in $searchStrings
            satisfies contains($arg,$searchString)
            "/>
        
    </xsl:function>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="VolltextOriginalsprache | VolltextUebersetzung | Inhaltsangabe | ZitationUebersetzung" xml:space="default" >
        <xsl:element name="{./name()}">
            <xsl:variable name="pat" select="parent::node()/Entitaeten/Entitaet"/>
            <xsl:analyze-string select="." regex="\[.*?\]">
                    <xsl:matching-substring>
                        <xsl:variable name="ma" select="."/>
                        <xsl:choose>
                            <xsl:when test="functx:contains-any-of($ma,$pat/Name)">
                                <xsl:for-each select="$pat">
                                    <xsl:if test="$ma eq concat('&#91;',./Name,'&#93;')">
                                        <entity><xsl:attribute name="id" select="./@Id"/><xsl:attribute name="type" select="./@Type"></xsl:attribute><xsl:value-of select="./Name"/></entity>
                                    </xsl:if>
                                </xsl:for-each>         
                            </xsl:when>
                            <xsl:otherwise><xsl:value-of select="$ma"/></xsl:otherwise>
                        </xsl:choose>                                       
                    </xsl:matching-substring>
                    <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
                </xsl:analyze-string>
        </xsl:element>
      </xsl:template>
</xsl:stylesheet>