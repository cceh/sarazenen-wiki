#!/bin/bash
echo "refreshing"
php extensions/SemanticMediaWiki/maintenance/disposeOutdatedEntities.php
php extensions/SemanticMediaWiki/maintenance/purgeEntityCache.php

php extensions/SemanticMediaWiki/maintenance/rebuildData.php -f
php maintenance/deleteArchivedRevisions.php --delete

php maintenance/deleteOldRevisions.php
php maintenance/deleteOrphanedRevisions.php
php maintenance/deleteSelfExternals.php
php maintenance/rebuildall.php

echo "Updating"
echo "file 1"
php maintenance/importDump.php ../files/1.xml
echo "file 2"
php maintenance/importDump.php ../files/2.xml
echo "file 3"
php maintenance/importDump.php ../files/3.xml
echo "scripts"

php extensions/SemanticMediaWiki/maintenance/rebuildData.php -f

php maintenance/rebuildrecentchanges.php
php maintenance/initSiteStats.php
php maintenance/rebuildall.php

php maintenance/runJobs.php
php maintenance/refreshLinks.php