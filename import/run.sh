source=`pwd`
saxon=`pwd`/SaxonHE9-9-0-2J/saxon9he.jar
files=$source/files
master=$files/sarazenen_masterfassung.xml

scripts=$source/scripts
output=$source/output

java -jar $saxon -s:$master -xsl:$scripts/01-QuellenImport.xsl -o:$output/1-MasterQuellen.xml fid=300 sid=2;