```mermaid

graph TD;
  Y1[Collection_data]
  
  first{{FIRST_STEP}}
  
  Y1 --> first

  subgraph *[<br/>]

  
  first -->|imdi & media|ZZ(FILES)
  first -->|CollAccessRights.xslx|ZU
  ZZ --> ZU[legacy_check]
  
  ZU --> |legacy_check.py|output(output)  
  
  output --> |eror.log|ZU5[check_manually]
  output --> |pre_table.csv|ZU5[check_manually]
  output --> |pre_key.csv|ZU5[check_manually]
  ZU5 --> |re-do|ZU
```