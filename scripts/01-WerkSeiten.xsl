<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.mediawiki.org/xml/export-0.10/"
    exclude-result-prefixes="#all" version="2.0">    
    <xsl:output method="xml" version="1.1" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" undeclare-prefixes="yes"  exclude-result-prefixes="#all"/>    
    <xsl:param name="fid">300</xsl:param>
    <xsl:param name="sid">2</xsl:param>
    <xsl:preserve-space elements=""/>
    <xsl:strip-space elements=""/>
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
    <xsl:template match="Dokumente" xml:space="default">
        <xsl:variable name="abfssungsort">
            <xsl:for-each select="./Abfassungsort/Ort">
                <xsl:variable name="place" xml:space="default"><xsl:choose>
                    <xsl:when test=". eq ''">Abfassungsort Unbekannt</xsl:when>
                    <xsl:when test=". eq '-'">Abfassungsort Unbekannt</xsl:when>
                    <xsl:when test=". eq 'unbekannt'">Abfassungsort Unbekannt</xsl:when>
                    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                </xsl:choose></xsl:variable>
                <xsl:value-of select="concat('[[Abfassungsort::',$place,']]')"/>
            </xsl:for-each></xsl:variable>
        <xsl:variable name="abfssungsort-set">
            <xsl:for-each select="./Abfassungsort/Ort">
                <xsl:variable name="place" xml:space="default"><xsl:choose>
                    <xsl:when test=". eq ''">Abfassungsort Unbekannt</xsl:when>
                    <xsl:when test=". eq '-'">Abfassungsort Unbekannt</xsl:when>
                    <xsl:when test=". eq 'unbekannt'">Abfassungsort Unbekannt</xsl:when>
                    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                </xsl:choose></xsl:variable>
                <xsl:value-of xml:space="default">{{#show:[[Ort:<xsl:value-of select="$place"/>]]|?getty_coordinates|link=none}}</xsl:value-of>
            </xsl:for-each></xsl:variable>
        <page>
            <title>
                <xsl:value-of select="WerkTitel"/>
            </title>
            <ns>0</ns>
            <id>
<!--                <xsl:value-of select="position()+$sid"/>-->
            </id>
            <revision>
                <id>0</id>
                <timestamp><xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H]:[m]:[s]Z')"/></timestamp>
                <contributor>
                    <username>Administrator</username>
                    <id>1</id>
                </contributor>
                <model>wikitext</model>
                <format>text/x-wiki</format>
                <text xml:space="preserve" bytes="3441"><!--{{#css: .infobox {float:left;} #leiste {width:66%; float:right;} p {clear:both}}
{{WikiProject_Transwiki/Template:Infobox
|title=
<xsl:text>|above=</xsl:text>[[Werk::<xsl:value-of select="WerkTitel"/>]]
                    <xsl:choose>
                        <xsl:when test="exists(Alternativtitel/Titel)">
                            <xsl:text>|subheader=</xsl:text><xsl:value-of select="string-join(Alternativtitel/Titel,'/')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>|subheader=</xsl:text><xsl:value-of select="Alternativtitel"/>
                        </xsl:otherwise>
                    </xsl:choose>
|image=
|caption=

|bodyclass = class;
|bodystyle = background:#FFFFFF; width:33%; vertical-align:right; border-style: ridge;
|abovestyle = background:#1b98d0; 
|headerstyle  = background:#1b98d0; 
|labelstyle   = background:#1b98d0; width:30%;
|datastyle    = 

|label1=Werknummer
|data1=<xsl:value-of select="WerkId"/>
|label2=VerfasserIn
|data2=<xsl:value-of xml:space="default"><xsl:choose><xsl:when test="exists(./Autoren/Autor[2])">
                            <xsl:for-each select="./Autoren/Autor">
                                <xsl:if test="position() > 1"><xsl:text>; </xsl:text></xsl:if>
                                <xsl:text>[[VerfasserIn::</xsl:text><xsl:value-of select="."/><xsl:text>]]</xsl:text>                                 
                            </xsl:for-each>
                        </xsl:when>
                            <xsl:when test="./Autoren/Autor[1] eq 'unbekannt'">
                                <xsl:text>[[VerfasserIn::VerfasserIn unbekannt]]</xsl:text>
                            </xsl:when>
                            <xsl:otherwise><xsl:text>[[VerfasserIn::</xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/>]]</xsl:otherwise>
                        </xsl:choose></xsl:value-of>
|label3=Abfassungszeit
|data3=<xsl:value-of select="Abfassungszeitraum/Datum/data(.)"/>
|label4=Berichtszeitraum
|data4=<xsl:value-of select="Berichtszeitraum/Datum/data(.)"/>
|label5=Abfassungsort
|data5=[[Abfassungsort::<xsl:value-of select="$abfssungsort"/>]]
|label6=Lebensdaten des Verfassers
|data6=<xsl:value-of xml:space="default">
    <xsl:choose><xsl:when test="exists(./Autoren/Autor[2])">
                            <xsl:for-each select="./Autoren/Autor">
                                <xsl:if test="position() > 1"><xsl:text>; </xsl:text></xsl:if>
                                <xsl:choose>
                                    <xsl:when test=". eq 'VerfasserIn unbekannt'"><xsl:value-of select="."/><xsl:text>: unbekannt</xsl:text></xsl:when>
                                    <xsl:otherwise><xsl:value-of select="."/><xsl:text>: {{#show: </xsl:text><xsl:value-of select="./data(.)"/><xsl:text> |?Lebensdaten | link=none}}</xsl:text></xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:when>
                            <xsl:when test="./Autoren/Autor[1] eq 'VerfasserIn unbekannt'">
                                <xsl:text>unbekannt</xsl:text>
                            </xsl:when>
                            <xsl:otherwise><xsl:value-of select="./Autoren/Autor/data(.)"/><xsl:text>: {{#show: </xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/><xsl:text> |?Lebensdaten | link=none}}</xsl:text></xsl:otherwise>
                        </xsl:choose>
</xsl:value-of>
}}-->
                   <!-- {{#show:Reichenau|?getty_coordinates|link=none}}-->{{Template:Werk
|Name={{FULLPAGENAME}}
|Subheader=<xsl:choose xml:space="default">
                        <xsl:when test="exists(Alternativtitel/Titel)">
                            <xsl:text></xsl:text><xsl:value-of select="string-join(Alternativtitel/Titel,'/')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text></xsl:text><xsl:value-of select="Alternativtitel"/>
                        </xsl:otherwise>
                    </xsl:choose>
|Alternativnamen={{#show:{{FULLPAGENAME}}|?Alternativnamen|link=none}}
|Werknummer={{#show:{{FULLPAGENAME}}|?Werknummer|link=none}}
|Abfassungszeit={{#show:{{FULLPAGENAME}}|?Abfassungszeit|link=none}}
|Berichtszeitraum={{#show:{{FULLPAGENAME}}|?Berichtszeitraum|link=none}}
|VerfasserIn=<xsl:value-of xml:space="default"><xsl:choose><xsl:when test="exists(./Autoren/Autor[2])">
                            <xsl:for-each select="./Autoren/Autor">
                                <xsl:if test="position() > 1"><xsl:text>; </xsl:text></xsl:if>
                                <xsl:text>[[abgefasst von::</xsl:text><xsl:value-of select="."/><xsl:text>]]</xsl:text>                                 
                            </xsl:for-each>
                        </xsl:when>
                            <xsl:when test="./Autoren/Autor[1] eq 'unbekannt'">
                                <xsl:text>[[abgefasst von::VerfasserIn unbekannt]]</xsl:text>
                            </xsl:when>
                            <xsl:otherwise><xsl:text>[[abgefasst von::</xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/>]]</xsl:otherwise>
                        </xsl:choose></xsl:value-of>
|Lebensdaten=<xsl:value-of xml:space="default">
    <xsl:choose><xsl:when test="exists(./Autoren/Autor[2])">
                            <xsl:for-each select="./Autoren/Autor">
                                <xsl:if test="position() > 1"><xsl:text>; </xsl:text></xsl:if>
                                <xsl:choose>
                                    <xsl:when test=". eq 'VerfasserIn unbekannt'"><xsl:value-of select="."/><xsl:text>: unbekannt</xsl:text></xsl:when>
                                    <xsl:otherwise><xsl:value-of select="."/><xsl:text>: {{#show: </xsl:text><xsl:value-of select="./data(.)"/><xsl:text> |?Lebensdaten | link=none}}</xsl:text></xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:when>
                            <xsl:when test="./Autoren/Autor[1] eq 'VerfasserIn unbekannt'">
                                <xsl:text>unbekannt</xsl:text>
                            </xsl:when>
                            <xsl:otherwise><xsl:value-of select="./Autoren/Autor/data(.)"/><xsl:text>: {{#show: </xsl:text><xsl:value-of select="./Autoren/Autor/data(.)"/><xsl:text> |?Lebensdaten | link=none}}</xsl:text></xsl:otherwise>
                        </xsl:choose>
</xsl:value-of>
|Abfassungsort=<xsl:value-of select="string-join($abfssungsort,', ')"/>
|Abfassungsregion={{#show:{{FULLPAGENAME}}|?Abfassungsregion|link=none}}
|Abfassungsort_koordinaten=<xsl:value-of select="string-join($abfssungsort-set,', ')"/>
|getty_id={{#show:{{FULLPAGENAME}}|?getty_id|link=none}}
|viaf_id={{#show:{{FULLPAGENAME}}|?viaf_id|link=none}}
|wikidata_id={{#show:{{FULLPAGENAME}}|?wikidata_id|link=none}}
|getty_coordinates={{#show:{{FULLPAGENAME}}|?getty_coordinates|link=none}}}}

<xsl:call-template name="svg" xml:space="default"><!-- Timeline einbindung --></xsl:call-template>
&lt;br/&gt;
{{#set:
Abfassungszeit=<xsl:value-of select="Abfassungszeitraum/Datum/data(.)"/>
|Berichtszeitraum=<xsl:value-of select="Berichtszeitraum/Datum/data(.)"/>
|Werknummer=<xsl:value-of select="WerkId"/>
                    <xsl:for-each select="Regionen/Region">|Abfassungsregion= <xsl:value-of select="."/></xsl:for-each>

<!-- <xsl:call-template name="normDate"><xsl:with-param name="date" select="Berichtszeitraum/Datum/@date"/><xsl:with-param name="attr" select="'BerichtszeitraumDate'"/></xsl:call-template>
<xsl:call-template name="normDate"><xsl:with-param name="date" select="Abfassungszeitraum/Datum/@date"/><xsl:with-param name="attr" select="'AbfassungszeitraumDate'"/></xsl:call-template>
-->
}}
&lt;poem&gt;<xsl:value-of select="replace(Werkinformation,'--','')"/>&lt;/poem&gt;

&lt;br/&gt;

=== Editionshinweise ===
&lt;poem&gt;
<xsl:apply-templates select="Editionshinweise"/>
&lt;/poem&gt;
                    <xsl:if test="exists(./Quellen/Quelle)">                        
=== Quellenstellen ===
{{#ask:
[[Kategorie:Quelle]]
[[aus dem Werk::<xsl:value-of select="WerkTitel"/>]]
                    |mainlabel=Zitation
                    |?Inhaltsangabe#
                    |?datiert auf#
                    |format=table
                    |headers=plain
}}
<!--[[Kategorie:Sarazenenbezug]]-->
=== Datierung ===
{{#ask:
[[aus dem Werk::<xsl:value-of select="WerkTitel"/>]]
                        [[Zeitangabe::+]]
|?Zeitangabe  
  |sort=Zeitangabe
 |order=descending
 |format=eventline
 |timelinebands= YEAR, DECADE,CENTURY
 |timelineposition=start
 |limit=1000
}}
{{#set:
Sarazenenbezug=ja
}}
                    </xsl:if>
                    <xsl:if test="not(exists(./Quellen/Quelle))">
                        <!--[[Kategorie:Kein Sarazenenbezug]]-->
                        {{#set:
                        Sarazenenbezug=nein}}
                    </xsl:if>
=== Zitationshinweis ===
<xsl:text>{{BASEPAGENAME}}, in: Repertorium Saracenorum, hg. von Matthias Becher und Katharina Gahbler, URL: [{{fullurl:{{FULLPAGENAME}}}} {{fullurl:{{FULLPAGENAME}}}}] (zuletzt abgerufen am {{CURRENTDAY}}.{{CURRENTMONTH}}.{{CURRENTYEAR}}).</xsl:text>
<!--
=== Kategorisierung ===
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Abfassungszeitraum | Abfassungszeitraum]]: <xsl:call-template name="split-numbers-kat.leiste"><xsl:with-param name="data" select="./Abfassungszeitraum"></xsl:with-param></xsl:call-template>&lt;/div&gt;&lt;/div&gt;
                    &lt;div id='catlinks' class='catlinks'&gt;&lt;div id=&quot;mw-normal-catlinks&quot; class=&quot;mw-normal-catlinks&quot;&gt;&lt;li&gt;[[:Kategorie: Berichtszeitraum | Berichtszeitraum]]: <xsl:call-template name="split-numbers-kat.leiste"><xsl:with-param name="data" select="./Berichtszeitraum"></xsl:with-param></xsl:call-template>&lt;/div&gt;&lt;/div&gt;     
-->
 
 __SHOWFACTBOX__
<xsl:value-of xml:space="default">[[Kategorie: Werk]]</xsl:value-of>  
<!--<xsl:value-of xml:space="default"><xsl:for-each select="Regionen/Region"><xsl:if test="position() > 1"><xsl:text>; </xsl:text></xsl:if>[[Kategorie: <xsl:value-of select="."/> | <xsl:value-of select="."/>]]</xsl:for-each></xsl:value-of>-->
                        </text>
                <sha1></sha1>
            </revision>
        </page>
    </xsl:template>
    
    <xsl:template name="normDate">
        <xsl:param name="attr"/>
        <xsl:param name="date"/>
        <xsl:variable name="first">
            <xsl:if test="$date != ''">
                <xsl:choose>
                    <xsl:when test="starts-with($date,'-')">-<xsl:value-of select="substring-before(substring-after($date,'-'),'-')"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="substring-before($date,'-')"/></xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="concat('|',$attr,'=',$first)" xml:space="default"/>
        <xsl:value-of select="concat(' |',$attr,'=',substring-after($date,concat($first,'-')))" xml:space="default"/>      
    </xsl:template>
    <xsl:template match="Dokument" name="svg"  xml:space="default">       
              <xsl:variable name="dates" xml:space="default">
            <xsl:for-each select="(./Abfassungszeitraum/Datum/@date,./Berichtszeitraum/Datum/@date,./Quellen/Quelle/ZeitangabeWissenschaft/Datum/@date)">
                <xsl:if test="contains(.,',')">
                    <xsl:for-each select="tokenize(.,',')">
                        <xsl:if test="contains(.,'-') and not(starts-with(.,'-'))">
                            <item> <xsl:value-of select="substring-before(replace(.,' ','') ,'-')"/></item>
                            <item> <xsl:value-of select="substring-after(replace(.,' ',''),'-')"/></item>
                        </xsl:if>
                        <xsl:if test="contains(.,'-') and starts-with(.,'-')">
                            <item><xsl:value-of select="concat('-',substring-before(substring-after(replace(.,' ',''),'-'),'-'))"/></item>
                            <item><xsl:value-of select="substring-after(substring-after(replace(.,' ',''),'-'),'-')"/></item>
                        </xsl:if>
                        <xsl:if test="not(contains(.,'-'))">
                            <item><xsl:value-of select="replace(.,' ','')"/></item>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="not(contains(.,','))">
                    <xsl:if test="contains(.,'-') and not(starts-with(.,'-'))">
                        <item> <xsl:value-of select="substring-before(replace(.,' ',''),'-')"/></item>
                        <item> <xsl:value-of select="substring-after(replace(.,' ',''),'-')"/></item>
                    </xsl:if>
                    <xsl:if test="contains(.,'-') and starts-with(.,'-')">
                        <item><xsl:value-of select="concat('-',substring-before(substring-after(replace(.,' ',''),'-'),'-'))"/></item>
                        <item><xsl:value-of select="substring-after(substring-after(replace(.,' ',''),'-'),'-')"/></item>
                    </xsl:if>
                    <xsl:if test="not(contains(.,'-'))">
                        <item><xsl:value-of select="replace(.,' ','')"/></item>
                    </xsl:if>
                </xsl:if>                        
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="int" xml:space="default">
            <xsl:for-each select="$dates/node()">
                <xsl:sort order="ascending"/> 
                <xsl:if test=" matches(.,'[0-9]')">
                    
                    <xsl:if test=". &#60; 600">
                    <item>
                        <xsl:value-of select="xs:integer('600')"/>
                    </item>
                    </xsl:if>
                    <xsl:if test=". > 600 and . &#60; 1100 ">
                    <item>
                        <xsl:value-of select="xs:integer(.)"/>
                    </item>
                    </xsl:if>
                    <xsl:if test=". > 1100">
                    <item>
                        <xsl:value-of select="xs:integer('1100')"/>
                    </item>
                    </xsl:if>
                </xsl:if>               
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="sortet" xml:space="default">
            <xsl:for-each select="$int/node()">
                <xsl:sort order="ascending" select="number(.)"/> 
                <item>
                    <xsl:value-of select="."/>
                </item>
            </xsl:for-each>
        </xsl:variable>
                    <xsl:variable name="start" select="$sortet/node()[1]"/>
        <xsl:variable name="end" select=" $sortet/node()[count($sortet/node())]"/>
                   
                    <xsl:variable name='st1' >
                        <xsl:if test="$start &#60; 0">
                            <xsl:value-of select="xs:integer(round($start div 50)) -1"/>
                        </xsl:if>
                        <xsl:if test="$start > 0">
                            <xsl:value-of select="xs:integer(round($start div 50)) -1"/>
                        </xsl:if>
                        <xsl:if test="$start = 0">
                            <xsl:value-of select="xs:integer(-1)"/>
                        </xsl:if>
                        
                    </xsl:variable>

                    <xsl:variable name="en1" select="xs:integer(round($end div 50)) +1"/>
                    <xsl:variable name='st2' >
                        <xsl:if test="$start &#60; 0">
                            <xsl:value-of select="(xs:integer(round($start div 50)) -1)*-1"/>
                        </xsl:if>
                        <xsl:if test="$start > 0">
                            <xsl:value-of select="xs:integer(round($start div 50)) +1"/>
                        </xsl:if>
                        <xsl:if test="$start = 0">
                            <xsl:value-of select="xs:integer(1)"/>
                        </xsl:if>
                        
                    </xsl:variable>
                    <xsl:if test="count($sortet/node()) > 0">
                        &lt;div id='leiste'&gt;
                &lt;html id='preHtml'&gt;
                            &lt;svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewbox="<xsl:value-of select="$st1 * 50"/> 0 <xsl:value-of select="($en1 + $st2 +1) * 50"/> 100" width="3000" height="200"&gt;
                        &lt;g&gt;  
                        &lt;rect x="<xsl:value-of select="$st1 * 50"/>" y="1" width="8" height="8" style="fill:#1b98d0;fill-opacity:0.9;"/&gt;
                        &lt;text x="<xsl:value-of select="$st1 * 50 + 10"/>" y="9" class="legende" font-size="12px"&gt;Berichtszeitraum des Werks &lt;/text&gt;
                        &lt;rect x="<xsl:value-of select="$st1 * 50"/>" y="10" width="8" height="8" style="fill:#ffd11a;fill-opacity:0.9;"/&gt;
                        &lt;text x="<xsl:value-of select="$st1 * 50 + 10"/>" y="18" class="legende" font-size="12px"&gt;Abfassungszeitraum des Werks &lt;/text&gt;                        
                        &lt;rect x="<xsl:value-of select="$st1 * 50"/>" y="20" width="8" height="8" style="fill:#164176;fill-opacity:0.9;"/&gt;
                        &lt;text x="<xsl:value-of select="$st1 * 50 + 10"/>" y="28" class="legende" font-size="12px"&gt; ins Repertorium aufgenommene Bericht &lt;/text&gt;
                        &lt;line id="x-axis" x1="<xsl:value-of select="$st1 * 50"/>"  y1="80" x2="<xsl:value-of select="$en1 * 50"/>" y2="80" stroke="black" stroke-width="2" stroke-linecap="butt"/&gt;
                    <xsl:for-each select="($st1 to $en1)" xml:space="default">
                        <xsl:if test=". = 0">
                             &lt;line  x1="0" y1="0" x2="0" y2="80" stroke="grey" stroke-width="0.5" stroke-linecap="butt" stroke-dasharray="4"/&gt;      
                             &lt;text x="0" y="95" class="year"&gt;0 &lt;/text&gt;
                        </xsl:if>
                        <xsl:if test=". != 0">
                             &lt;line  x1="<xsl:value-of select=". * 50"/>" y1="0" x2="<xsl:value-of select=". * 50"/>" y2="80" stroke="grey" stroke-width="0.5" stroke-linecap="butt" stroke-dasharray="4"/&gt;      
                       &lt;text x="<xsl:value-of select=". * 50"/>" y="95" class="year"&gt;<xsl:value-of select=". * 50"/> &lt;/text&gt;
                        </xsl:if>
                    </xsl:for-each> 
                        &lt;/g&gt;&lt;g&gt; 
                        <xsl:apply-templates select="./Abfassungszeitraum/Datum/@date"/>                
                          &lt;/g&gt; 
                           &lt;g&gt; 
                <xsl:apply-templates select="./Berichtszeitraum/Datum/@date"/>                          
                          &lt;/g&gt; 
                          &lt;g&gt; 
           <xsl:apply-templates select="./Quellen/Quelle/ZeitangabeWissenschaft/Datum"/>
                        &lt;/g&gt; 
                            &lt;/svg&gt;&lt;/html&gt;&lt;/div&gt;                 
                    </xsl:if>                    
    </xsl:template>
    <xsl:template match="Quelle" >
        <xsl:variable name="zeitangabe">
            <xsl:if test="exists(./ZeitangabeWissenschaft/Datum)">
                <xsl:value-of select="./ZeitangabeWissenschaft/Datum[1]"/>
            </xsl:if> 
            <xsl:if test="not(exists(./ZeitangabeWissenschaft/Datum))">
                <xsl:text>Keine Zeitangabe</xsl:text>
            </xsl:if> 
        </xsl:variable>
        <xsl:variable name="tex">
            <xsl:text> </xsl:text>
            <xsl:for-each select="tokenize(./Inhaltsangabe,' ')">
                <xsl:if test="position() &#60; 20">
                    <xsl:value-of select="."/>
                    <xsl:text> </xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:text>...</xsl:text>
        </xsl:variable>
        <xsl:value-of xml:space="default">&lt;li&gt;[[<xsl:value-of select="./parent::Quellen/preceding-sibling::WerkTitel"/><xsl:text>-</xsl:text><xsl:value-of select="QuellenId"/>|<xsl:value-of select="$zeitangabe"/>]]<xsl:value-of select="$tex"/><xsl:text> [</xsl:text><xsl:value-of select="./QuellenId"/><xsl:text>]</xsl:text>&lt;/li&gt;</xsl:value-of>
  </xsl:template>
  
    <xsl:template name="split-numbers-kategorien">         
        <!-- Einstiegswerte -->
        <xsl:param name="start"/> 
        <xsl:param name="stop"/>        
        <!-- aktueller Bereich, der ausgegeben werden soll -->
        <xsl:variable name="start-range" select="(floor(number($start) div 10))*10"/> 
        <xsl:variable name="end-range" select="$start-range + 10"/>
        [[Kategorie: <xsl:value-of select="string-join((string($start-range), string($end-range)),' - ')"/>]]<xsl:if test="$end-range &lt; $stop">
            <xsl:call-template name="split-numbers-kategorien">
                <xsl:with-param name="start" select="$start-range + 10"/> 
                <xsl:with-param name="stop" select="$stop"/> 
            </xsl:call-template></xsl:if>    
    </xsl:template>
    
    <xsl:template name="split-numbers-kat.leiste">         
        <xsl:param name="data"/>       
        <xsl:if test="$data/Datum/@date != ''">
        <xsl:variable name="dates" xml:space="default">
            <xsl:for-each select="$data/Datum/@date">
                <xsl:if test="contains(.,',')">
                    <xsl:for-each select="tokenize(.,',')">
                        <xsl:if test="contains(.,'-') and not(starts-with(.,'-'))">
                            <item> <xsl:value-of select="substring-before(replace(.,' ','') ,'-')"/></item>
                            <item> <xsl:value-of select="substring-after(replace(.,' ',''),'-')"/></item>
                        </xsl:if>
                        <xsl:if test="contains(.,'-') and starts-with(.,'-')">
                            <item><xsl:value-of select="concat('-',substring-before(substring-after(replace(.,' ',''),'-'),'-'))"/></item>
                            <item><xsl:value-of select="substring-after(substring-after(replace(.,' ',''),'-'),'-')"/></item>
                        </xsl:if>
                        <xsl:if test="not(contains(.,'-'))">
                            <item><xsl:value-of select="replace(.,' ','')"/></item>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="not(contains(.,','))">
                    <xsl:if test="contains(.,'-') and not(starts-with(.,'-'))">
                        <item> <xsl:value-of select="substring-before(replace(.,' ',''),'-')"/></item>
                        <item> <xsl:value-of select="substring-after(replace(.,' ',''),'-')"/></item>
                    </xsl:if>
                    <xsl:if test="contains(.,'-') and starts-with(.,'-')">
                        <item><xsl:value-of select="concat('-',substring-before(substring-after(replace(.,' ',''),'-'),'-'))"/></item>
                        <item><xsl:value-of select="substring-after(substring-after(replace(.,' ',''),'-'),'-')"/></item>
                    </xsl:if>
                    <xsl:if test="not(contains(.,'-'))">
                        <item><xsl:value-of select="replace(.,' ','')"/></item>
                    </xsl:if>
                </xsl:if>                        
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="int" xml:space="default">
            <xsl:for-each select="$dates/node()">
                <xsl:sort order="ascending"/> 
                <xsl:if test=" matches(.,'[0-9]')">                    
                    <item><xsl:value-of select="xs:integer(.)"/></item>
                </xsl:if>               
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="sortet" xml:space="default">
            <xsl:for-each select="$int/node()">
                <xsl:sort order="ascending" select="number(.)"/> 
                <item>
                    <xsl:value-of select="."/>
                </item>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="start" select="$sortet/node()[1]"/>
        <xsl:variable name="end" select=" $sortet/node()[count($sortet/node())]"/><xsl:variable name="en1" select="xs:integer(round($end div 10))"/>
            <xsl:if test="$start &#60; 0"><xsl:value-of>
                [[:Kategorie: -5000 - 0 | -5000 - 0]]&lt;/li&gt;&lt;li&gt;
            </xsl:value-of></xsl:if>
        <xsl:variable name='st2' >
            <xsl:if test="$start &#60; 0">
                <xsl:value-of select="xs:integer(0)"/>
            </xsl:if>
            <xsl:if test="$start > 0">
                <xsl:value-of select="xs:integer(round($start div 10))"/>
            </xsl:if>
            <xsl:if test="$start = 0">
                <xsl:value-of select="xs:integer(0)"/>
            </xsl:if>            
        </xsl:variable>
            <xsl:value-of xml:space="default">                
                <xsl:for-each select="($st2 to $en1)">
                    <xsl:value-of xml:space="default">[[:Kategorie: <xsl:value-of select=". *10"/> - <xsl:value-of select="(. +1) *10"/>  | <xsl:value-of select=". *10"/> - <xsl:value-of select="(. +1) *10"/>]]&lt;/li&gt;&lt;li&gt;
                    </xsl:value-of>
                </xsl:for-each>
            </xsl:value-of>
        </xsl:if>
    </xsl:template>
   
    <!-- SVG Einbindung -->
    <xsl:template name="balken">
        <xsl:param name="value"/>
        <xsl:param name="color"/>
        <xsl:param name="y1"/>
        <xsl:param name="y2"/>
        <xsl:variable name="x1">
            <xsl:choose>
                <xsl:when test="contains($value,'-') and not(starts-with($value,'-'))">
                    <xsl:value-of select="xs:integer(substring-before($value,'-'))"/>
                </xsl:when>
                <xsl:when test="contains($value,'-') and starts-with($value,'-') and contains(substring-after($value,'-'),'-')">
                    <xsl:value-of select="xs:integer(concat('-',substring-before(substring-after($value,'-'),'-')))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="xs:integer($value)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable> 
        <xsl:variable name="x2">
            <xsl:choose>
                <xsl:when test="contains($value,'-') and not(starts-with($value,'-'))">
                    <xsl:value-of select="xs:integer(substring-after($value,'-'))"/>
                </xsl:when>
                <xsl:when test="contains($value,'-') and starts-with($value,'-') and contains(substring-after($value,'-'),'-')">
                    <xsl:value-of select="xs:integer(substring-after(substring-after($value,'-'),'-'))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="xs:integer($value)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="width">
            <xsl:choose>
                <xsl:when test="$x1 &#60; 0">
                    <xsl:value-of select="($x1 * -1)+$x2"/>
                </xsl:when>
                <xsl:when test="$x1 >= 0 and $x2 &#60;= 1150"><xsl:value-of select="$x2 -$x1"/></xsl:when>
                <xsl:when test="$x2 >= 1150"><xsl:value-of select="1155 - $x1"/></xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="markX">
            <xsl:choose>
                <xsl:when test="$x2 >= 1150">1155
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="$x2"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--
            <xsl:if test="$x1 &#60; 0">
                <xsl:value-of select="($x1 * -1)+$x2"/>
            </xsl:if>
            <xsl:if test="$x1 >= 0">
                <xsl:value-of select="$x2 -$x1"/>
            </xsl:if>      
            -->
        <xsl:variable name="start">
            <xsl:if test="$x1 > -400">
                <xsl:value-of select="$x1"/>
            </xsl:if>
            <xsl:if test="$x1 &#60; -400">
                <xsl:value-of select="xs:integer('-480')"/>
            </xsl:if>
        </xsl:variable>
        &lt;g&gt;
        &lt;rect x="<xsl:value-of select="$x1"/>" y="<xsl:value-of select="$y1"/>" width="<xsl:value-of select="$width"/>" height="45" style="fill:<xsl:value-of select="$color"/>;fill-opacity:0.9;"/&gt;
        <!-- Beschriftung der Balken: -->
        <xsl:variable name="to" select="number(substring-after(.,'-'))"/>
        &lt;text x="<xsl:value-of select="$start"/>" y="<xsl:value-of select="$y2"/>" class="label" style="color: #bfff80; text-anchor: end"><xsl:value-of select="$x1"/>&lt;/text&gt;
        &lt;text x="<xsl:value-of select="$markX"/>" y="<xsl:value-of select="$y2"/>" class="label" style="color: #bfff80; text-anchor: start"><xsl:value-of select="$x2"/>&lt;/text&gt;
        &lt;/g&gt;
    </xsl:template>
    <!-- rudimentäre darstellung vom Abfassungszeitraum -->
    <xsl:template name="balken2">
        <xsl:param name="value"/>
        <xsl:param name="color"/>
        <xsl:param name="y1"/>
        <xsl:param name="y2"/>
        <xsl:variable name="x1">
            <xsl:choose>
                <xsl:when test="contains($value,'-') and not(starts-with($value,'-'))">
                    <xsl:value-of select="xs:integer(substring-before($value,'-'))"/>
                </xsl:when>
                <xsl:when test="contains($value,'-') and starts-with($value,'-') and contains(substring-after($value,'-'),'-')">
                    <xsl:value-of select="xs:integer(concat('-',substring-before(substring-after($value,'-'),'-')))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="xs:integer($value)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable> 
        <xsl:variable name="x2">
            <xsl:choose>
                <xsl:when test="contains($value,'-') and not(starts-with($value,'-'))">
                    <xsl:value-of select="xs:integer(substring-after($value,'-'))"/>
                </xsl:when>
                <xsl:when test="contains($value,'-') and starts-with($value,'-') and contains(substring-after($value,'-'),'-')">
                    <xsl:value-of select="xs:integer(substring-after(substring-after($value,'-'),'-'))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="xs:integer($value)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--
        <xsl:variable name="width">
            <xsl:if test="$x1 &#60; 0">
                <xsl:value-of select="($x1 * -1)+$x2"/>
            </xsl:if>
            <xsl:if test="$x1 > 0">
                <xsl:value-of select="$x2 -$x1"/>
            </xsl:if>                     
        </xsl:variable>-->
        <xsl:variable name="width">
            <xsl:choose>
                <xsl:when test="$x1 &#60; 0">
                    <xsl:value-of select="($x1 * -1)+$x2"/>
                </xsl:when>
                <xsl:when test="$x1 >= 0 and $x2 &#60;= 1150"><xsl:value-of select="$x2 -$x1"/></xsl:when>
                <xsl:when test="$x2 >= 1150"><xsl:value-of select="1155 - $x1"/></xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="start">
            <xsl:if test="$x1 > -400">
                <xsl:value-of select="$x1"/>
            </xsl:if>
            <xsl:if test="$x1 &#60; -400">
                <xsl:value-of select="xs:integer('-480')"/>
            </xsl:if>
        </xsl:variable>
        &lt;g&gt;
        &lt;rect x="<xsl:value-of select="$x1"/>" y="<xsl:value-of select="$y1"/>" width="<xsl:value-of select="$width"/>" height="45" style="fill:<xsl:value-of select="$color"/>;fill-opacity:0.9;"/&gt;
        <!-- Beschriftung der Balken: -->
        <!--
        <xsl:variable name="to" select="number(substring-after(.,'-'))"/>
        &lt;text x="<xsl:value-of select="$start"/>" y="<xsl:value-of select="$y2"/>" class="label" style="color: #bfff80; text-anchor: end"><xsl:value-of select="$x1"/>&lt;/text&gt;
        &lt;text x="<xsl:value-of select="$x2"/>" y="<xsl:value-of select="$y2"/>" class="label" style="color: #bfff80; text-anchor: start"><xsl:value-of select="$x2"/>&lt;/text&gt;
        -->
        &lt;/g&gt;
    </xsl:template>
    <xsl:template match="Dokumente/Berichtszeitraum/Datum/@date">
      <xsl:if test=". != ''">
          <xsl:if test="not(contains(.,','))">     
              <xsl:call-template name="balken"> 
                  <xsl:with-param name="value" select="."/> 
                  <xsl:with-param name="color" select="'#1b98d0'"/>
              <xsl:with-param name="y1" select="26"/>
              <xsl:with-param name="y2" select="70"/>
              </xsl:call-template>
          </xsl:if>
          <xsl:if test="contains(.,',')">
              <xsl:for-each select="tokenize(.,',')">
                  <xsl:call-template name="balken"> 
                      <xsl:with-param name="value" select="."/> 
                      <xsl:with-param name="color" select="'#1b98d0'"/>
                      <xsl:with-param name="y1" select="26"/>
                      <xsl:with-param name="y2" select="70"/>
                  </xsl:call-template>
              </xsl:for-each>
          </xsl:if>
      </xsl:if>
    </xsl:template>
    <xsl:template match="Dokumente/Abfassungszeitraum/Datum/@date">
        <xsl:if test=". != ''">
            <xsl:if test="not(contains(.,','))">     
                <xsl:call-template name="balken2"> 
                    <xsl:with-param name="value" select="."/> 
                    <xsl:with-param name="color" select="'#ffd11a'"/>
                    <xsl:with-param name="y1" select="12"/>
                    <xsl:with-param name="y2" select="19"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="contains(.,',')">
                <xsl:for-each select="tokenize(.,',')">
                    <xsl:call-template name="balken2"> 
                        <xsl:with-param name="value" select="."/> 
                        <xsl:with-param name="color" select="'#ffd11a'"/>
                        <xsl:with-param name="y1" select="12"/>
                        <xsl:with-param name="y2" select="19"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="Quellen/Quelle/ZeitangabeWissenschaft/Datum">
        <xsl:if test=". != ''">
            <xsl:if test="not(contains(.,','))">    
                <xsl:variable name="tooltip">Quelle <xsl:value-of select="parent::node()/parent::node()/QuellenId"/>: <xsl:value-of select="."/></xsl:variable>
                <xsl:call-template name="quellenBalken"> 
                    <xsl:with-param name="value" select="./@date"/> 
                    <xsl:with-param name="color" select="'#ffd11a'"/>
                    <xsl:with-param name="tooltip" select="$tooltip"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="contains(.,',')">
                <xsl:variable name="t1">Quelle <xsl:value-of select="parent::node()/parent::node()/QuellenId"/>: </xsl:variable>
                <xsl:for-each select="tokenize(./@date,',')">                    
                    <xsl:call-template name="quellenBalken"> 
                        <xsl:with-param name="value" select="."/> 
                        <xsl:with-param name="color" select="'#ffd11a'"/>
                        <xsl:with-param name="tooltip" select="concat($t1,.)"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:if>
        </xsl:if>        
    </xsl:template>
    <xsl:template name="quellenBalken">
        <xsl:param name="value"/>
        <xsl:param name="color"/>
        <xsl:param name="tooltip"/>
        <xsl:variable name="x1">
            <xsl:choose>
                <xsl:when test="contains($value,'-') and not(starts-with($value,'-'))">
                    <xsl:value-of select="xs:integer(substring-before($value,'-'))"/>
                </xsl:when>
                <xsl:when test="contains($value,'-') and starts-with($value,'-') and contains(substring-after($value,'-'),'-')">
                    <xsl:value-of select="xs:integer(concat('-',substring-before(substring-after($value,'-'),'-')))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="xs:integer($value)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable> 
        <xsl:variable name="x2">
            <xsl:choose>
                <xsl:when test="contains($value,'-') and not(starts-with($value,'-'))">
                    <xsl:value-of select="xs:integer(substring-after($value,'-'))"/>
                </xsl:when>
                <xsl:when test="contains($value,'-') and starts-with($value,'-') and contains(substring-after($value,'-'),'-')">
                    <xsl:value-of select="xs:integer(substring-after(substring-after($value,'-'),'-'))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="xs:integer($value)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="w">
            <xsl:if test="$x1 &#60; 0">
                <xsl:value-of select="($x1 * -1)+$x2"/>
            </xsl:if>
            <xsl:if test="$x1 > 0">
                <xsl:value-of select="$x2 - $x1"/>
            </xsl:if>                     
        </xsl:variable>
        <xsl:variable name="width">
            <xsl:if test="$w = 0">
                <xsl:text>1</xsl:text>
            </xsl:if>
            <xsl:if test="$w > 0">
                <xsl:value-of select="$w"/>
            </xsl:if>                     
        </xsl:variable>
        <xsl:variable name="start">
            <xsl:if test="$x1 > -400">
                <xsl:value-of select="$x1"/>
            </xsl:if>
            <xsl:if test="$x1 &#60; -400">
                <xsl:value-of select="xs:integer('-500')"/>
            </xsl:if>
        </xsl:variable>
        &lt;g&gt;
        &lt;rect x="<xsl:value-of select="$start"/>" y="26" width="<xsl:value-of select="$width"/>" height="37"
        label="<xsl:value-of select="$tooltip"/>"	style="fill:#164176;stroke:black;stroke-width:0.5;opacity:1;"/&gt;
        &lt;/g&gt;
    </xsl:template>
    
    <xsl:template match="Editionshinweise">       
<xsl:if test="exists(./edition)"><xsl:value-of select="./edition"/> [<xsl:value-of select="./link/@url"/><xsl:text> </xsl:text><xsl:value-of select="./link"/>]
</xsl:if>
    </xsl:template>
    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>