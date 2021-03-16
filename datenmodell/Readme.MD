```mermaid

classDiagram

    class KategorieWerk
    
    KategorieWerk <|-- Werk : ist ein 
    
    class KategoriePerson
    KategoriePerson <|-- Person : ist ein 
    
    class KategorieVerfasserIn
    KategorieVerfasserIn <|-- VerfasserIn : ist ein 
    
    class KategorieAbfassungsregion
    KategorieAbfassungsregion <|-- Abfassungsregion : ist ein 
    
    class KategorieGeographie
    KategorieGeographie <|-- KategorieOrt: ist ein
    KategorieGeographie <|-- KategorieKloster: ist ein
    KategorieGeographie <|-- KategorieBerg: ist ein
    KategorieGeographie <|-- KategorieFluss: ist ein
    KategorieGeographie <|-- KategorieRegion: ist ein
    
    class KategorieOrt
    KategorieOrt <|-- Ort : ist ein 
    
    class KategorieKloster
    KategorieKloster <|-- Ort : ist ein 
    
    class KategorieBerg
    KategorieBerg <|-- Ort : ist ein 
    
    class KategorieFluss
    KategorieFluss <|-- Ort : ist ein 
    
    class KategorieRegion
    KategorieRegion <|-- Ort : ist ein
    
    class KategorieAbfassungsort
    KategorieAbfassungsort <|-- Ort : ist ein 
    
    class Abfassungsregion
    
    class Werk
    Werk: Seiteninhalt Beschreibung
    Werk: Seiteninhalte Editionshinweise
    Werk: Berichtszeitraum 
    Werk: Berichtszeitraum maschinenlesbar
    Werk: Abfassungzeit
    Werk: Abfassungszeit maschinenlesbar
    Werk: Sarazenenbezug
    Werk: Werknummer
    Werk <-- Quellenstelle : Aus dem Werk
    Werk --> VerfasserIn : abgefasst von
    Werk --> Ort : abgefasst in
    Werk --> Abfassungsregion : gehört zu Abfassungsregion
    Werk: Abfrage(Quellenstellen)
    Werk: Abfrage(Datierung Quellenstellen)
    
    class VerfasserIn
    VerfasserIn: Attribut Alternativnamen
    VerfasserIn: Attribut Lebensdaten
    VerfasserIn: Attribut GND ID
    VerfasserIn: Attribut VIAF ID
    VerfasserIn: Attribut Wikidata ID
    VerfasserIn: Attribut Lebensdaten
    VerfasserIn: Abfrage(Werk)

    class Quellenstelle
    Quellenstelle: Seiteninhalt Inhaltsangabe
    Quellenstelle: Seiteninhalt Voltext
    Quellenstelle: Seiteninhalt Hinweise zur Übersetzung
    Quellenstelle: Seiteninhalt Anmerkungen
    Quellenstelle: Attribut Inhaltsangabe
    Quellenstelle: Attribut datiert auf
    Quellenstelle: Attribut Individuen
    Quellenstelle: Attribut Interaktion
    Quellenstelle: Attribut Kollektive
    Quellenstelle: Attribut Zitation
    Quellenstelle: --> Auffaelligkeit : berichtet von
    Quellenstelle --> Person : nennt Person
    Quellenstelle --> Ort : nennt Ort  
    Quellenstelle --> Ort : geographischer Bezug zu 
    Quellenstelle --> Schlagwort : relevante Schlagworte
    Quellenstelle: Abfrage(benachbarte Quellenstellen)

    class Person
    Person: Alternativnamen
    Person: Rolle
    Person: GND ID
    Person: VIAF ID
    Person: Wikidata ID
    Person: Wikidata description
    Person: Abfrage(Quellenstellen)

    class Ort
    Ort: Alternativnamen
    Ort: Getty coordinates
    Ort: editorial coordinates
    Ort: Getty ID
    Ort: GND ID
    Ort: VIAF ID
    Ort: Abfrage(Quellenstellen)
    
    class Auffaelligkeit
    
    class Schlagwort

end

```