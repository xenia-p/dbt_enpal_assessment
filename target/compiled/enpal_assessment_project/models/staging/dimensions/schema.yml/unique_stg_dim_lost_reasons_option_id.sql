
    
    

select
    option_id as unique_field,
    count(*) as n_records

from "postgres"."public_pipedrive_analytics"."stg_dim_lost_reasons"
where option_id is not null
group by option_id
having count(*) > 1


