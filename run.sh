source=`pwd`
files=$source/files
scripts=$source/scripts
output=$source/output
java -classpath /usr/share/java/saxon9he.jar net.sf.saxon.Transform -s:$files/sarazenen_masterfassung.xml -xsl:$scripts/01-QuellenImport.xsl -o:$output/1-MasterQuellen.xml fid=300 sid=2;
java -classpath /usr/share/java/saxon9he.jar net.sf.saxon.Transform -s:$files/Negativquellen_ergaenzt.xml -xsl:$scripts/01-QuellenImport.xsl -o:$output/1-NegativQuellen.xml fid=200 sid=1;
ava -classpath /usr/share/java/saxon9he.jar net.sf.saxon.Transform -s:$files/Negativquellen_ergaenzt.xml -xsl:$scripts/02-Werkliste.xsl -o:$output/2-Werkliste.xml