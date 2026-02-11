
      insert into "postgres"."public_pipedrive_analytics"."stg_deals_stages" ("deal_id", "change_time", "changed_field_key", "new_value")
    (
        select "deal_id", "change_time", "changed_field_key", "new_value"
        from "stg_deals_stages__dbt_tmp223424869763"
    )


  