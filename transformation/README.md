# transformation
[[TOC]]

Sammlung diverser einmaliger Skripte

## one-times
> geo-id.xsl

Korrektur der fehlenden geo ids in der Masterfassung auf der Quellen Ebene.

Ergänzt anhand der im  Orts Register Eingetragen IDs, diese auf der Quellen Ebene zu den Geogprahischen Stichworten

Bsp.:

Einrag auf Quellenebene vorher: 
```xml
<GeographischesStichwort>
               <Ort id="">Israel</Ort>
               <Ort id="">Jerusalem</Ort>
            </GeographischesStichwort>
```

Ort Israel im Register:
```xml 
<Ort id="c295fd5c-1286-4c03-9c78-0761485715f3">
         <Id>c295fd5c-1286-4c03-9c78-0761485715f3</Id>
         <Name>Israel</Name>
         <Typ>Region</Typ>
         <Alternativnamen/>
         <getty_Id>1000119</getty_Id>
         <editorial_notes/>
      </Ort>
```      

Eintrag auf Quellenebene nach der Transformation:
```xml
<GeographischesStichwort>
               <Ort id="c295fd5c-1286-4c03-9c78-0761485715f3">Israel</Ort>
               <Ort id="107ceb7a-8e2a-4ce7-847a-8ada274b5ed5">Jerusalem</Ort>
            </GeographischesStichwort>
```

## [v2](v2/README.md)

Erstellung der aktuellen Fassung.