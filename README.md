## Setup

1. This project uses Postgres in Docker
2. The local deps and python version are manages with uv. Run `uv sync` if you have uv installed. Use requirements.txt otherwise.
3. Sqlfluff is used for code beautifying. 

## DBT Approach

1. 4 layers are created: staging, intermediate, datamarts and metrics. 
2. The intermediate layer is rather for logical transformations.
3. The metrics layer is designed to feed the metric reports.
4. The datamarts layer includes the tables that cover the most frequent business use cases for the data. 
5. I don't join dimensional tables to the mart tables. This is arbitrary but I assume that the hash join for small dim tables is gonna be fast enough so that multiplied storage of these values is not justified.
5. The marts_deals table gives an overview for each deal so one can easily check a specific deal. The table can be enriched with the other deal-level data in the future, like financial data.
6. The marts_deals_stages answers questions about the deal journey and allows to inspect the patterns of going from one stage to another.  
7. Business logic added: for marts_deals_stages I consider lost as another stage so that one can explore which stages lead to the lost state the most. 
8. In the metrics table I used the minimal stage date as the attribution date for a deal. This approach is arbitrary but easy to follow and allows cohort-level analysis. However even later stages are attributed to the first month and that leads to recalculation, one should consider this when interpreting metrics.


## Assumptions and notes about the data
1. For some reason activity_id in activity_table is not unique. I will just ingore it.
2. All deals are lost, I ignore it.
3. Almost no deals in activity_table are present in deal_changes. It's ok if these are just some data extracts but in general I assume it shouldn't be like this.
4. I assume that there are no double entries in the table (e.g. one deal stage added twice) so I don't do any cleaning to address it.
5. There is a lost reason with the name duplicate entry, I don't filter this reason out and just consider it as any other lost reason.
6. I assume that the deal_changes table is an append-only event-log like table. 
