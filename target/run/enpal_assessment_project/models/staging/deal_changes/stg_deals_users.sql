
      -- back compat for old kwarg name
  
  
        
    

    

    merge into "postgres"."public_pipedrive_analytics"."stg_deals_users" as DBT_INTERNAL_DEST
        using "stg_deals_users__dbt_tmp223424952249" as DBT_INTERNAL_SOURCE
        on (FALSE)

    

    when not matched then insert
        ("deal_id", "change_time", "user_id")
    values
        ("deal_id", "change_time", "user_id")


  