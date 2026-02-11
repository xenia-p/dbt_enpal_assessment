
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select stage
from "postgres"."public_pipedrive_analytics"."interm_deals_stages_enriched"
where stage is null



  
  
      
    ) dbt_internal_test