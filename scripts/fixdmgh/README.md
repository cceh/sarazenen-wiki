# Aktualisierung der dMGH-Links in den Quellenstellen

Die Links zu den Digitalisaten in der dMGH werden nicht mehr maintained und führen ins Leere (404).

Das Skript dmgh-links.xql extrahiert die Verweise auf Digitalisate in der dMGH (dmgh.de) und versucht diese mit der Hilfe der dmgh-API in "kanonische" resovling-Links zur übersetzen.
Zur API s. hier: https://www.mgh.de/mgh-digital/dmgh/api-und-rest-schnittstelle

Als Ergebnis produziert das Skript einen csv-output, der händisch überprüft werden kann. Anschließend können die Links in die Master-XML übernommen werden (ToDo).

## Ausführen
Das Skript wurde so konzipiert, dass die Master-XML in BaseX in die Wurzelcollection eines Repositories mit dem Namen "sarazenen-wiki" geladen wird und das Skrpit dann in BaseX ausgeführt wird.

## Vorgehen
Das Skript anbei produziert eine Tabelle mit allen Editionshinweisen, in denen "MGH" vorkommt und fügt wo immer es geht den MGH-Link hinzu. Editionshinweise stehen in der Master-XML in einem Element und darunter sind die Editions-URLs als einzelne Elemente aufgeschlüsselt. Wenn es mehrere Einträge in Editionshinweise gibt, dann sind diese mit Semicolon getrennt oder durch Zeilenumbruch (in einem Fall durch "Teilweise auch ediert in:"). aber praktisch unverknüpft mit der URL. z.B. hier: http://saraceni.uni-koeln.de/wiki/Rerum_gestarum_Saxonicarum_libri_tres
Das wird also nicht so einfach, die aktualisierten Einträge hinterher wieder zusammenzubringen.

Das Skript parst die einzelnen Editionshinweise zur MGH und normalisiert die MGH-Band-Angabe (z.B. Script./SS./SS oder N.S/N. S). Die API ist da sehr streng. Weiterhin werden Sub-Bände (15,1 und 15,2) und Halbgeviertstriche als Bis-Zeichen berücksichtig. Wenn über diese Angabe die Bsb-Nummer gefunden wird, sind wir schon halb am Ziel, wenn nicht, versucht es das Skript noch mit dem Titel oder Autor (der ersten zwei Items in der Literaturangabe), wodurch auch einige zugeordnet werden können. Wenn es eine Seitenangabe gibt, wird hiervon der Beginn der Seitenzählung genommen. Daraus wird dann über die API der Link generiert.

Das funktioniert bei mehr als der Hälfte der Einträge. Über bleiben dann hauptsächlich die Bände mit der einstellingen Zählung (MGH SS 1, MGH SS 2, ...). Wenn ihr für diese die Bsb-Id rausfinden und nachtragen könntet, wäre der Rest einfach. Ich zähle da nur so ca. 9 unterschiedliche Bände bei denen die Id fehlt.

Für diese Bände lässt sich aber der resolving Link nach dem bekannten Schema zusammensetzen (ohne die API zu Hilf zu nehmen). Diese konstruiuerten Links werden in die Spalte "alternativ" geschrieben und müsen ggfs. überprüft werden.
