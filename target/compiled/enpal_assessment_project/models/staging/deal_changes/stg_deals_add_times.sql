

SELECT
  deal_id,
  change_time,
  new_value AS user_id
FROM "postgres"."public"."deal_changes"
WHERE
  changed_field_key = 'add_time'

  
    -- only load rows newer than what’s already in the target table
    AND change_time > (
      SELECT coalesce(max(change_time), timestamp '1900-01-01')
      FROM "postgres"."public_pipedrive_analytics"."stg_deals_add_times"
    )
  