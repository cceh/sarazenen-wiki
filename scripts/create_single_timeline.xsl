<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    version="2.0">
    <!-- 
    	Dies ist der Entwurf zur Darstellung einzelner Zeitstrahlen für den jeweiligen Abfassungs- & Berichtszeitraum einer Quelle. 
    -->
	
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"></meta>
            	<style type="text/css">
            		table{
            			border: 1px solid black;
            		}
            		td{
            			padding: 5px;
            		}
            		svg {
            			margin-left: 35px;
            			width: 1100px;
            		}
            		.timeline {
            			width: 1200px;
            			margin-left: 30px;
            		}
            		.time{
	            		width: 1000px;
	            		height: 30px;
	            		border-top: 1px solid black;
	            		padding-top: 10px;
	            		margin-top: 20px;
            		}
            		.year{
	            		width: 140px;
	            		text-align: center;
	            		display: inline;
	            		margin-right: 150px;
	            		margin-left: 15px;
	            		font-size: 9pt;
            		}
            		.label{
            			font-size: 7pt;
            		}
            	</style>
            </head>
            <body>
                <h2>Sarazenen - single timelines</h2>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
	
	<xsl:template match="Dokumente">
		<dokument>
			<xsl:apply-templates select="./Abfassungszeitraum/Datum/@date"/>
			<xsl:apply-templates select="./Berichtszeitraum/Datum/@date"/>
		</dokument>
	</xsl:template>
	
	<xsl:template match="Dokumente/Abfassungszeitraum/Datum/@date">
		<xsl:if test=". != ''">
			<xsl:if test="contains(.,',')">
				<xsl:for-each select="tokenize(.,',')">
					<xsl:call-template name="setAbfassung">
						<xsl:with-param name="val" select="normalize-space(.)"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="not(contains(.,','))">
				<xsl:call-template name="setAbfassung">
					<xsl:with-param name="val" select="normalize-space(.)"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>		
	</xsl:template>
	
	<xsl:template name="setAbfassung">
		<xsl:param name="val"/>
		<date>
			<xsl:if test="contains($val,'-')">				
				<xsl:variable name="from" select="substring-before($val,'-')"/>
				<xsl:variable name="to" select="substring-after($val,'-')"/>
				<xsl:call-template name="setAbfassung2">
					<xsl:with-param name="from" select="$from"/>
					<xsl:with-param name="to" select="$to"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="not(contains($val,'-'))">				
				<xsl:variable name="from" select="$val"/>
				<xsl:variable name="to" select="$val"/>
				<xsl:call-template name="setAbfassung2">
					<xsl:with-param name="from" select="$from"/>
					<xsl:with-param name="to" select="$to"/>
				</xsl:call-template>
			</xsl:if>
		</date>
	</xsl:template>
	
	<xsl:template name="setAbfassung2">
		<xsl:param name="from"/>
		<xsl:param name="to"/>
		
		<xsl:variable name="length"><xsl:value-of select="(number($to)-number($from)+1)*2"/></xsl:variable>
		<xsl:variable name="start"><xsl:value-of select="((number($from))-600)*2"/></xsl:variable>
		<xsl:variable name="label-start"><xsl:value-of select="(number($start)+(number($length) div 2))"/></xsl:variable>
		<!-- Rechteck für Abfassungszeitraum -->
		<rect x="{$start}" y="35" rx="8" ry="8" width="{$length}" height="10"
			style="fill:orange"/> <!-- #6ea6dd; -->
		<text x="{$label-start}" y="55" class="label" style="text-anchor: middle"><xsl:value-of select="$from"/> - <xsl:value-of select="$to"/></text>
		
	</xsl:template>
	
	<xsl:template match="Dokumente/Berichtszeitraum/Datum/@date">
		<xsl:if test=". != ''">
			<date>
			<xsl:variable name="BerichtsframeStart" select="(number(substring-before(.,'-'))-600)*2"/>
			<xsl:variable name="BerichtsframeLength" select="(number(substring-after(.,'-'))-number(substring-before(.,'-'))+1)*2"/>
			<rect x="{$BerichtsframeStart}" y="6" width="{$BerichtsframeLength}" height="27"
				style="fill:#bfff80;"/>
			</date>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="text()"/>
	
</xsl:stylesheet>