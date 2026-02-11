
    
    

select
    deal_id as unique_field,
    count(*) as n_records

from "postgres"."public_pipedrive_analytics"."interm_deals_times_users"
where deal_id is not null
group by deal_id
having count(*) > 1


