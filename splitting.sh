source=`pwd`
saxon=`pwd`/SaxonHE9-9-0-2J/saxon9he.jar
files=$source/files
master=$files/sarazenen_masterfassung_v2.xml
#master=$files/test.xml

scripts=$source/scripts
output=$source/output

master=$files/sarazenen_masterfassung_filled.xml
java -jar $saxon -s:$master -xsl:$scripts/101-merge.xsl -o:$output/101-merge.xml;
java -jar $saxon -s:$output/101-merge.xml -xsl:$scripts/103-split.xsl foldername=$output/split size=1000 div=500;


