# Transformation
## Changes
### Person | VerfasserIn | Ort
### VolltextOriginalsprache | VolltextUebersetzung | ZitationUebersetzung
### Entitaeten
### Editionshinweise
## Scripts 
### 1-generateTags
Erstellung von Elementen innerhalb der Volltexte auf Quellenebene

```xml
<VolltextOriginalsprache>
Huius [Ebf. Gero von Köln] sancta mater, 
Hidda nomine, Ierusalem [Jerusalem] orationis gratia petens infirmata,
hanc suis legationem pedissequis commendavit: 
[...]
</VolltextOriginalsprache>
```

in der Version 1 waren entitaeten noch innerhalb von eckigen Klammern (`[Ebf. Gero von Köln]`] makiert. 

Um eine bessere Lesbarkeit und Aufbereitung zu erreichen, wurden diese in XML komforme Elemente umgewandelt, zudem wurden die attribute `id` und `type` hinzugefügt.
`id` ist die angegebene ID im Register und `type` welche Registerart.

Ergebnis:

```xml
<VolltextOriginalsprache>
Huius <entity id="7d8390d6-bd06-4702-8b36-1da196a9105f" type="Person">Ebf. Gero von Köln</entity> sancta mater, 
Hidda nomine, Ierusalem <entity id="107ceb7a-8e2a-4ce7-847a-8ada274b5ed5" type="Ort">Jerusalem</entity> orationis gratia petens infirmata, 
hanc suis legationem pedissequis commendavit: [...]</VolltextOriginalsprache>
```

### 2-fillRegister

[2-fillRegister.xsl#L25](L25)

Der erste Teil ersetzt die alte ID angabe in den Register, welches vorher als Element angeben war und setzt diese als `id` attribut ein.

v1
```xml
 <VerfasserIn>
             <Id>47q8uc8o-m82y-0oca-ldn4-gd5k8qeqmmxa</Id>
             <Name>VerfasserIn unbekannt</Name>
             <Alternativnamen/>       
             <Lebensdaten date=""/>
             <gnd_Id/>
             <wikidata_Id/>
             <viaf_Id/>
        </VerfasserIn>
```

v2
```xml
<VerfasserIn id="47q8uc8o-m82y-0oca-ldn4-gd5k8qeqmmxa">
         <Id>47q8uc8o-m82y-0oca-ldn4-gd5k8qeqmmxa</Id>
         <Name>VerfasserIn unbekannt</Name>
         <Alternativnamen/>
         <Lebensdaten date=""/>
         <gnd_Id/>
         <wikidata_Id/>
         <viaf_Id/>
      </VerfasserIn>
```

[2-fillRegister.xsl#L31](L31)

Der zweite Teil, fügt mögliche Alternativnamen die auf Quellenebene in den Volltexten genannt werden, in die Registereinträge ein.

### 3-fix-dMGH
Ersetzt die vorhanden dMGH Links innerhalb der Dokumente durch die aktualisierten. 

Die aktuallisierten werden vorher in `fixdmgh` erstellt