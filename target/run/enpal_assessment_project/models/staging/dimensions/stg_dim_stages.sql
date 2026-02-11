
  create view "postgres"."public_pipedrive_analytics"."stg_dim_stages__dbt_tmp"
    
    
  as (
    

-- Staging model for `activity_types` source
SELECT
  stage_id,
  stage_name
FROM "postgres"."public"."stages"
  );