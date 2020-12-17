source=`pwd`
saxon=`pwd`/SaxonHE9-9-0-2J/saxon9he.jar
files=$source/files
transform=$source/transformation/v3
master=$files/sarazenen_masterfassung_v2.xml

java -jar $saxon -s:$master -xsl:$transform/01-date-correction.xsl -o:$files/sarazenen_masterfassung_v3.xml;
java -jar $saxon -s:$files/sarazenen_masterfassung_v3.xml -xsl:$transform/02-abfassungsregionen.xsl -o:$files/sarazenen_masterfassung_v3.xml;
#java -jar $saxon -s:$files/sarazenen_masterfassung_v2.xml -xsl:$transform/3-fix-dMGH.xsl -o:$files/sarazenen_masterfassung_v2.xml;
