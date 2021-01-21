#!/bin/bash
echo "refreshing"
php maintenance/refreshLinks.php
echo "Updating"
echo "file 1"
php maintenance/importDump.php ../files/1.xml
echo "file 2"
php maintenance/importDump.php ../files/2.xml
echo "file 3"
php maintenance/importDump.php ../files/3.xml
echo "scripts"
php maintenance/rebuildrecentchanges.php
php maintenance/initSiteStats.php
php maintenance/runJobs.php
php maintenance/refreshLinks.php