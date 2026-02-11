
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select occurred_at
from "postgres"."public_pipedrive_analytics"."stg_activity"
where occurred_at is null



  
  
      
    ) dbt_internal_test