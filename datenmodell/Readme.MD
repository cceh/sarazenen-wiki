```mermaid

classDiagram
    class Werk
    WikiSeite : +Textinhalte
    classWerk <|-- classQuellenstelle : Aus dem Werk
    
    class Quellenstelle
    WikiSeite : +Textinhalte
```