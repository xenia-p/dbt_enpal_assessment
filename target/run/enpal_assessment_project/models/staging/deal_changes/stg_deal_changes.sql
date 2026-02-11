
      
  
    

  create  table "postgres"."public_pipedrive_analytics"."stg_deal_changes__dbt_tmp"
  
  
    as
  
  (
    

SELECT
  deal_id,
  change_time,
  changed_field_key,
  new_value
FROM "postgres"."public"."deal_changes"
WHERE 1 = 1

  
  );
  
  