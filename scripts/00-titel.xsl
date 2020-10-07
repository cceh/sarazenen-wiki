<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" version="2.0">
    <!--
    <xsl:template match="/">
        <mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/"
            version="0.10" xml:lang="de">
            <siteinfo>
                <sitename>Sarazenen Wiki</sitename>
                <dbname>sarazenen-bonn</dbname>
                <base>http://saraceni.uni-koeln.de/sarazenen_wiki/Repertorium_Saracenorum</base>
                <generator>MediaWiki 1.27.4</generator>
                <case>first-letter</case>
                <namespaces>
                    <namespace key="-2" case="first-letter">Medium</namespace>
                    <namespace key="-1" case="first-letter">Spezial</namespace>
                    <namespace key="0" case="first-letter"/>
                    <namespace key="1" case="first-letter">Diskussion</namespace>
                    <namespace key="2" case="first-letter">Benutzer</namespace>
                    <namespace key="3" case="first-letter">Benutzer Diskussion</namespace>
                    <namespace key="4" case="first-letter">Sarazenen Wiki</namespace>
                    <namespace key="5" case="first-letter">Sarazenen Wiki Diskussion</namespace>
                    <namespace key="6" case="first-letter">Datei</namespace>
                    <namespace key="7" case="first-letter">Datei Diskussion</namespace>
                    <namespace key="8" case="first-letter">MediaWiki</namespace>
                    <namespace key="9" case="first-letter">MediaWiki Diskussion</namespace>
                    <namespace key="10" case="first-letter">Vorlage</namespace>
                    <namespace key="11" case="first-letter">Vorlage Diskussion</namespace>
                    <namespace key="12" case="first-letter">Hilfe</namespace>
                    <namespace key="13" case="first-letter">Hilfe Diskussion</namespace>
                    <namespace key="14" case="first-letter">Kategorie</namespace>
                    <namespace key="15" case="first-letter">Kategorie Diskussion</namespace>
                    <namespace key="102" case="first-letter">Attribut</namespace>
                    <namespace key="103" case="first-letter">Attribut Diskussion</namespace>
                    <namespace key="106" case="first-letter">Formular</namespace>
                    <namespace key="107" case="first-letter">Formular Diskussion</namespace>
                    <namespace key="108" case="first-letter">Konzept</namespace>
                    <namespace key="109" case="first-letter">Konzept Diskussion</namespace>
                    <namespace key="170" case="first-letter">Filter</namespace>
                    <namespace key="171" case="first-letter">Filter Diskussion</namespace>
                    <namespace key="828" case="first-letter">Modul</namespace>
                    <namespace key="829" case="first-letter">Modul Diskussion</namespace>
                </namespaces>
            </siteinfo>
            <xsl:apply-templates/>
        </mediawiki>
    </xsl:template>
    -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="timestamp" xpath-default-namespace="http://www.mediawiki.org/xml/export-0.10/">
        <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
    </xsl:template>
    <!--
    <xsl:template match="*:div">
        <xsl:variable name="css">     /* Das folgende CSS wird für alle Benutzeroberflächen geladen. */
            
            /* Hauptseite */
            
            .hauptseite-rechts {
            margin-left: .5em;
            }
            
            .hauptseite-links {
            margin-right: .5em;
            }
            
            .hauptseite-oben h2, .hauptseite-unten h2 {
            text-align: center;
            }
            
            .hauptseite-links h2, .hauptseite-rechts h2 {
            text-indent: .8em;
            }
            
            .hauptseite-oben, .hauptseite-links, .hauptseite-rechts {
            margin-bottom: 1em;
            }
            
            #hauptseite .inhalt {
            background: #fff;
            border: 1px solid #8898bf;
            border-top-color: rgb(136, 152, 191);
            border-top-style: solid;
            border-top-width: 1px;
            border-top: 0;
            min-height: 0;
            padding: .3em .8em .4em;
            font-color:green;
            }
            
            #hauptseite h2 {
            background: #d8e8ff;
            border: 1px solid #8898bf;
            font-family: inherit;
            font-size: 1em;
            font-weight: bold;
            line-height: 1.5;
            margin: 0;
            padding: .1em 0;
            }
            
      </xsl:variable>
        <xsl:value-of select="normalize-space($css)"/>
    </xsl:template>
    -->
</xsl:stylesheet>