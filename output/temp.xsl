<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <html>
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">	
            <!-- Rechteck/Balken für Abfassungszeitraum (in orange)-->
            <xsl:if test="Abfassungszeitraum/Datum">
                <xsl:if test="Abfassungszeitraum/Datum/@date != ''">
                    <xsl:variable name="from"><xsl:value-of select="substring-before(Abfassungszeitraum/Datum/@date,'-')"/></xsl:variable>
                    <xsl:variable name="to"><xsl:value-of select="substring-after(Abfassungszeitraum/Datum/@date,'-')"/></xsl:variable>
                    <xsl:variable name="length"><xsl:value-of select="(number($to)-number($from)+1)*2"/></xsl:variable>
                    <xsl:variable name="start"><xsl:value-of select="(($from)-600)*2"/></xsl:variable>
                    <xsl:variable name="label-start"><xsl:value-of select="(number($start)+(number($length) div 2))"/></xsl:variable>
                    <!-- Rechteck für Abfassungszeitraum -->
                    <rect x="{$start}" y="35" rx="8" ry="8" width="{$length}" height="10"
                        style="fill:orange"/> <!-- #6ea6dd; -->
                    <text x="{$label-start}" y="55" class="label" style="text-anchor: middle"><xsl:value-of select="$from"/> - <xsl:value-of select="$to"/></text>
                </xsl:if>
            </xsl:if>
            
            <!-- Rechteck für Berichtszeitraum -->
            <xsl:if test="Berichtszeitraum/Datum">
                <xsl:variable name="BerichtsframeStart" select="(number(substring-before(Berichtszeitraum[1]/Datum/@date,'-'))-600)*2"/>
                <xsl:variable name="BerichtsframeLength" select="(number(substring-after(Berichtszeitraum[1]/Datum/@date,'-'))-number(substring-before(Berichtszeitraum[1]/Datum/@date,'-'))+1)*2"/>
                <rect x="{$BerichtsframeStart}" y="6" width="{$BerichtsframeLength}" height="27"
                    style="fill:#bfff80;"/>
            </xsl:if>
            
            <!-- Rahmenlinie für die Quellenstelle (in schwarz) -->
            <xsl:for-each select="Quellen/Quelle">
                <xsl:variable name="Startjahr" select="min(ZeitangabeWissenschaft/number(substring-before(Datum[1]/@date,'-')))"/>
                <xsl:variable name="QuellenframeStart" select="($Startjahr - 600)*2"/>
                <xsl:variable name="QuellenframeLength" select="(max(ZeitangabeWissenschaft/number(substring-after(Datum[last()]/@date,'-')))-$Startjahr + 1) *2"/>
                <xsl:variable name="tooltip">Quelle <xsl:value-of select="QuellenId"/>: <xsl:value-of select="ZeitangabeWissenschaft"/></xsl:variable>
                <xsl:variable name="link"><xsl:value-of select="../../translate(WerkTitel,' ','_')"/>_-_<xsl:value-of select="../../WerkId"/>_<xsl:value-of select="QuellenId"/></xsl:variable>
                <!-- für später: <a href="http://www.cceh.uni-koeln.de/projekte/sarazenen/sarazenen_wiki/index.php/{$link}" title="{$tooltip}"></a>-->
                <rect x="{$QuellenframeStart -1}" y="18" width="{$QuellenframeLength +1}" height="4"
                    style="fill:black;"/>
            </xsl:for-each>
            
            <!-- Einzelmarker für Quellenstellen (in rot/braun)-->
            <xsl:for-each select="Quellen/Quelle/ZeitangabeWissenschaft/Datum">
                <!-- unvollständig!!!! Die Zeitangaben sind in Wirklichkeit Zeiträume und mehrfach. 
						Zu Testzwecken hier nur der Beginn des ersten Zeitraums -->
                <xsl:variable name="QuellenstelleStart" select="(number(substring-before(@date,'-'))-600)*2"/>
                <xsl:variable name="QuellenstelleLength" select="(number(substring-after(@date,'-'))-number(substring-before(@date,'-'))+1)*2"/>
                <xsl:variable name="tooltip">Quelle <xsl:value-of select="QuellenId"/>: <xsl:value-of select="ZeitangabeWissenschaft"/></xsl:variable>
                <xsl:variable name="link"><xsl:value-of select="../../../../translate(WerkTitel,' ','_')"/>_-_<xsl:value-of select="../../../../WerkId"/>_<xsl:value-of select="../../QuellenId"/></xsl:variable>
                <!-- für später: <a href="http://www.cceh.uni-koeln.de/projekte/sarazenen/sarazenen_wiki/index.php/{$link}" title="{$tooltip}"></a>-->
                <rect x="{$QuellenstelleStart}" y="10" width="{$QuellenstelleLength}" height="20"
                    style="fill:#990000;stroke:white;stroke-width:1;opacity:0.7;"/>
            </xsl:for-each>
            
            <!-- X-Achse & Beschriftung -->
            <line id="x-axis" x1="0"  y1="70" x2="1000" y2="70" stroke="black" stroke-width="2" stroke-linecap="butt"/>
            <text x="0" y="85" class="year">600</text>
            <text x="200" y="85" class="year">700</text>
            <text x="400" y="85" class="year">800</text>
            <text x="600" y="85" class="year">900</text>
            <text x="800" y="85" class="year">1000</text>
            <text x="1000" y="85" class="year">1100</text>
        </svg>
        
    </html>
</xsl:stylesheet>