
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select deals_count
from "postgres"."public_pipedrive_analytics"."metrics_monthly_kpis"
where deals_count is null



  
  
      
    ) dbt_internal_test