
  create view "postgres"."public_pipedrive_analytics"."stg_dim_activity_types__dbt_tmp"
    
    
  as (
    

SELECT
  id,
  name,
  active,
  type
FROM "postgres"."public"."activity_types"
  );