
    
    

select
    start_date as unique_field,
    count(*) as n_records

from "postgres"."public_pipedrive_analytics"."stg_dim_dates"
where start_date is not null
group by start_date
having count(*) > 1


