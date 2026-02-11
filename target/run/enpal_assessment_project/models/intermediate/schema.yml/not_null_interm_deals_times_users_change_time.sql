
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select change_time
from "postgres"."public_pipedrive_analytics"."interm_deals_times_users"
where change_time is null



  
  
      
    ) dbt_internal_test