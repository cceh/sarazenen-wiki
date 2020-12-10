source=`pwd`
saxon=`pwd`/SaxonHE9-9-0-2J/saxon9he.jar
files=$source/files
transform=$source/transformation
master=$files/sarazenen_masterfassung.xml

java -jar $saxon -s:$master -xsl:$transform/1-generateTags.xsl -o:$files/sarazenen_masterfassung_v2.xml;
java -jar $saxon -s:$files/sarazenen_masterfassung_v2.xml -xsl:$transform/2-fillRegister.xsl -o:$files/sarazenen_masterfassung_v2.xml;
java -jar $saxon -s:$files/sarazenen_masterfassung_v2.xml -xsl:$transform/3-fix-dMGH.xsl -o:$files/sarazenen_masterfassung_v2.xml;
