<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:functx="http://www.functx.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0"
     xml:space="default">    
    
    <xsl:function name="functx:replace-multi" as="xs:string?"
       >
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
    <xsl:variable name="edition">
        <xsl:for-each select="tokenize(unparsed-text('editionshinweise.csv'),'\n')">
            <item>
                <xsl:for-each select="tokenize(.,';')">
                    <xsl:choose>
                        <xsl:when test="position() eq 1"><string><xsl:value-of select="."/></string></xsl:when>
                        <xsl:when test="position() eq 5 or position() eq 6"><link><xsl:value-of select="."/></link></xsl:when>
                    </xsl:choose>                    
                </xsl:for-each>
            </item>
        </xsl:for-each>
    </xsl:variable>
    <xsl:template match="@* | node()" xml:space="default">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" xml:space="default"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="Editionshinweise">
        <Editionshinweise>            
            <xsl:variable name="content"><text><xsl:value-of select="."/></text></xsl:variable>
            <xsl:variable name="run"><xsl:call-template name="pipe"><xsl:with-param name="data" select="$content"></xsl:with-param></xsl:call-template></xsl:variable>
            <xsl:if test="count($run/hit) != 1">
                <xsl:variable name="isolatet" select="functx:replace-multi($content,$run/hit/edition/text(),$run/hit/rep/text())"/>
                <xsl:for-each select="tokenize($isolatet,'###')">
                    <xsl:if test="position() >  count($run)">
                            <xsl:variable name="pos" select="position() -1"/>
                            <xsl:copy-of select="$run/hit[$pos]/edition"/>
                        </xsl:if>
                        <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="count($run/hit) eq 1">
               <xsl:for-each select="$run/hit/node()">
                   <xsl:choose>
                       <xsl:when test="./name() eq 'text'"><xsl:value-of select="."/></xsl:when>
                       <xsl:when test="./name() eq 'edition'"><xsl:copy-of select="."></xsl:copy-of></xsl:when>
                   </xsl:choose>
               </xsl:for-each>
                </xsl:if></Editionshinweise>
    </xsl:template>
    
    <xsl:template name="pipe" as="item()*">
        <xsl:param name="data" as="node()"/>
        <xsl:for-each select="$data/node()">
            <xsl:variable name="content" select="."/>
            <xsl:choose>
                <xsl:when test="$content/name() eq 'text'">
                    <xsl:for-each select="$edition/node()">
                        <xsl:if test="contains($content,./string)">
                            <hit><rep>###</rep><text><xsl:value-of select="substring-before($content,./string)"/></text><edition><xsl:attribute name="url" select="normalize-space(string-join(./link,''))"/><xsl:value-of select="./string"/></edition><text><xsl:value-of select="substring-after($content,./string)"/></text></hit>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise><xsl:copy-of select="$content"></xsl:copy-of></xsl:otherwise>
            </xsl:choose>            
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="EditionLink[@url eq ''] | EditionLink[contains(./@url,'https://www.dmgh.de')]" xml:space="default"/>
<!-- 
                    <xsl:if test="$content/name() = edition"><xsl:copy-of select="$content"></xsl:copy-of></xsl:if>
            <xsl:if test="$content/name() = text"><xsl:for-each select="$edition/node()">
                <xsl:if test="contains($content,./string)">
                    <hit><text><xsl:value-of select="substring-before($content,./string)"/></text><edition><xsl:attribute name="url" select="normalize-space(string-join(./link,''))"/><xsl:value-of select="./string"/></edition><text><xsl:value-of select="substring-after($content,./string)"/></text></hit>
                </xsl:if>
            </xsl:for-each>
            </xsl:if>
            -->

</xsl:stylesheet>