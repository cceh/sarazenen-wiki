```mermaid
classDiagram

    class KategorieWerk
    KategorieWerk <|-- Werk : ist ein 

    class Werk
    Werk: Berichtszeitraum 
    Werk: Abfassungzeitraum
    Werk <-- Quellenstelle : Aus dem Werk
    Werk --> VerfasserIn : abgefasst von
    Werk --> Ort : abgefasst in
    Werk: Abfrage(Quellenstellen)
    
    class VerfasserIn

    class Quellenstelle
    Quellenstelle: Inhaltsangabe
    Quellenstelle --> Person : nennt Person
    Quellenstelle --> Ort : nennt Ort  

    class Person

    class Ort
    Ort: Kategorie(Ort)
    Ort: Kategorie(Abfassungsort)
```