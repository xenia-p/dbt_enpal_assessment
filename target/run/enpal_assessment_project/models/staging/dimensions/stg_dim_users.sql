
  
    

  create  table "postgres"."public_pipedrive_analytics"."stg_dim_users__dbt_tmp"
  
  
    as
  
  (
    SELECT
  id,
  name,
  email,
  modified
FROM "postgres"."public"."users"
  );
  