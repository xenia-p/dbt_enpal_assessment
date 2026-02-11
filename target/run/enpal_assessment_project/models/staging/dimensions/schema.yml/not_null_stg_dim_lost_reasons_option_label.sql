
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select option_label
from "postgres"."public_pipedrive_analytics"."stg_dim_lost_reasons"
where option_label is null



  
  
      
    ) dbt_internal_test