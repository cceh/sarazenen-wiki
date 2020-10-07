source=`pwd`
saxon=`pwd`/SaxonHE9-9-0-2J/saxon9he.jar
files=$source/files
master=$files/sarazenen_masterfassung.xml
negativ=$files/Negativquellen.xml

scripts=$source/scripts
output=$source/output

java -jar $saxon -s:$master -xsl:$scripts/01-QuellenImport.xsl -o:$output/1-MasterQuellen.xml fid=300 sid=2;

java -jar $saxon -s:$master -xsl:$scripts/03-Quellenstellen.xsl -o:$output/3-QuellenEinzelseiten.xml fid=1000 sid=2;

# Auskommentiert, da die Kategorien erklärtexte haben
java -jar $saxon -s:$master -xsl:$scripts/04-kategorien.xsl -o:$output/4-kategorienseiten.xml fid=3000 sid=2;
#####
java -jar $saxon -s:$master -xsl:$scripts/04-createList.xsl -o:$output/5-kategorienseiten.xml fid=4000 sid=2;

java -jar $saxon -s:$files/0-title.xml -xsl:$scripts/00-titel.xsl -o:$output/0-title.xml;

#java -jar $saxon -s:$master -xsl:$scripts/99-merge.xsl -o:$source/99-merge.xml;
#java -jar $saxon -s:$source/99-merge.xml -xsl:$scripts/99-ids.xsl -o:$source/99-ids.xml;


#java -classpath /usr/share/java/saxon9he.jar net.sf.saxon.Transform -s:$negativ -xsl:$scripts/01-QuellenImport.xsl -o:$output/1-NegativQuellen.xml fid=200 sid=1;
#java -jar $saxon -s:$master -xsl:$scripts/02-Werkliste.xsl -o:$output/2-Werkliste.xml


