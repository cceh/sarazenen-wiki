#!/bin/bash
source=`pwd`
saxon=`pwd`/SaxonHE9-9-0-2J/saxon9he.jar
files=$source/files
master=$files/sarazenen_masterfassung_v2-1.xml
#master=$files/test2.xml
negativ=$files/Negativquellen.xml

scripts=$source/scripts
output=$source/output/single

echo "1 : Alles ausführen (Filling, Transformation, Splitting)"
echo "2 : Nur Transformation"
echo "3 : Transformation mit splitting" 
echo "4 : Filled Datei erstellen"

read -p "Nummer:" nu

case "$nu" in 
    1) echo "Alles wird ausgeführt"
        echo "Filling"
        time java -jar $saxon -s:$master -xsl:$scripts/0-fillMaster.xsl -o:$files/sarazenen_masterfassung_filled.xml;
        master=$files/sarazenen_masterfassung_filled.xml
        echo "Masterquellen"
        time java -jar $saxon -s:$master -xsl:$scripts/01-WerkSeiten.xsl -o:$output/01-MasterQuellen.xml fid=300 sid=2;
        echo "Quellenseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/02-QuellenEinzelseiten.xsl -o:$output/02-QuellenEinzelseiten.xml fid=1000 sid=2;
        echo "Kategorieseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/03-kategorienseiten.xsl -o:$output/03-kategorienseiten.xml fid=3000 sid=2;
        echo "Registerseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/04-RegisterListen.xsl -o:$output/04-RegisterListen.xml fid=4000 sid=2;
        echo "Statische Dateien"
        time java -jar $saxon -s:$master -xsl:$scripts/06-static_files.xsl -o:$output/06-static-files.xml path=$files/static-sites;
        echo "Splitting"
        time sh splitting.sh
        echo "Fertig"
        ;;
    2) echo "Nur Transformation"
        master=$files/sarazenen_masterfassung_filled.xml
        echo "Masterquellen"
        time java -jar $saxon -s:$master -xsl:$scripts/01-WerkSeiten.xsl -o:$output/01-MasterQuellen.xml fid=300 sid=2;
        echo "Quellenseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/02-QuellenEinzelseiten.xsl -o:$output/02-QuellenEinzelseiten.xml fid=1000 sid=2;
        echo "Kategorieseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/03-kategorienseiten.xsl -o:$output/03-kategorienseiten.xml fid=3000 sid=2;
        echo "Registerseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/04-RegisterListen.xsl -o:$output/04-RegisterListen.xml fid=4000 sid=2;
        echo "Statische Dateien"
        time java -jar $saxon -s:$master -xsl:$scripts/06-static_files.xsl -o:$output/06-static-files.xml path=$files/static-sites;
        echo "Fertig"
        ;;
    3) echo "Transformation mit Splitting"
        master=$files/sarazenen_masterfassung_filled.xml
        echo "Masterquellen"
        time java -jar $saxon -s:$master -xsl:$scripts/01-WerkSeiten.xsl -o:$output/01-MasterQuellen.xml fid=300 sid=2;
        echo "Quellenseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/02-QuellenEinzelseiten.xsl -o:$output/02-QuellenEinzelseiten.xml fid=1000 sid=2;
        echo "Kategorieseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/03-kategorienseiten.xsl -o:$output/03-kategorienseiten.xml fid=3000 sid=2;
        echo "Registerseiten"
        time java -jar $saxon -s:$master -xsl:$scripts/04-RegisterListen.xsl -o:$output/04-RegisterListen.xml fid=4000 sid=2;
        echo "Statische Dateien"
        time java -jar $saxon -s:$master -xsl:$scripts/06-static_files.xsl -o:$output/06-static-files.xml path=$files/static-sites;
        echo "Splitting"
        time sh splitting.sh
        echo "Fertig"
        ;;
    4) echo "Filled Datei"
        time java -jar $saxon -s:$master -xsl:$scripts/0-fillMaster.xsl -o:$files/sarazenen_masterfassung_filled.xml;
        ;;
    *) echo "Falsche Eingabe"
    ;;
    esac


