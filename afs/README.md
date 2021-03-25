# afs Verzeichnis
Ordner der alle wichtigen Dateien zur erstellung des Mediawikis benötigt werden.

In >docs/wiki/LocalSettings.php sind alle wichtigen Einträge zur generierung 

> docs/wiki/extensions 

enthält alle herunterladbaren Erweiterungen

> icons 

beinhaltet die erstellten icons, müssen aber bei einer neuinstallation händisch im Wiki hochgeladen werden

evtl. mit [ImportImages](https://www.mediawiki.org/wiki/Manual:ImportImages.php) hochladbar im batch verfahren.

## update.sh
Shell Skript, welches auf dem AFS mehrere Befehle ausführt und die Einträge importiert

Alle Befehle sind hier chronologisch aufgelistet

[disposeOutdatedEntities](https://www.semantic-mediawiki.org/wiki/Help:Maintenance_script_disposeOutdatedEntities.php)
>php extensions/SemanticMediaWiki/maintenance/disposeOutdatedEntities.php

Aufräumfunktion

[purgeEntityCache](https://www.semantic-mediawiki.org/wiki/Help:Maintenance_script_purgeEntityCache.php)
>php extensions/SemanticMediaWiki/maintenance/purgeEntityCache.php
 
Aufräumfunktion

[deleteOldRevisions](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:DeleteOldRevisions.php)
>php maintenance/deleteOldRevisions.php

Aufräumfunktion

[deleteOrphanedRevisions](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:DeleteOrphanedRevisions.php)
>php maintenance/deleteOrphanedRevisions.php

Aufräumfunktion

[deleteSelfExternals](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:DeleteSelfExternals.php)
>php maintenance/deleteSelfExternals.php

Aufräumfunktion

[refreshLinks](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:RefreshLinks.php)
>php maintenance/refreshLinks.php

Aufräumfunktion

Muss zweimal ausgeführt werden, weil sonst das Semantic-Media-Wiki fehler produziert


[importDump](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:ImportDump.php)
>php maintenance/importDump.php

Funktion zum automatischen Upload der Seiten. Wird 3 mal ausgeführt

[Rebuildrecentchanges](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Rebuildrecentchanges.php)
>php maintenance/rebuildrecentchanges.php
 
[InitSiteStats](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:InitSiteStats.php)
>php maintenance/initSiteStats.php
 
[runJobs](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:runJobs.php)
>php maintenance/runJobs.php

[refreshLinks](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:refreshLinks.php)
>php maintenance/refreshLinks.php