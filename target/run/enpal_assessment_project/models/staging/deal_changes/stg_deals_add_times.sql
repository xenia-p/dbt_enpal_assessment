
      insert into "postgres"."public_pipedrive_analytics"."stg_deals_add_times" ("deal_id", "change_time", "user_id")
    (
        select "deal_id", "change_time", "user_id"
        from "stg_deals_add_times__dbt_tmp223424752220"
    )


  