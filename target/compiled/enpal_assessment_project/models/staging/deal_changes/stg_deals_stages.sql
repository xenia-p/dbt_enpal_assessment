

SELECT
  deal_id,
  change_time,
  changed_field_key,
  new_value
FROM "postgres"."public"."deal_changes"
WHERE
  changed_field_key IN ('stage_id', 'lost_reason')

  
    -- only load rows newer than what’s already in the target table
    AND change_time >= (
      SELECT coalesce(max(change_time), timestamp '1900-01-01')
      FROM "postgres"."public_pipedrive_analytics"."stg_deals_stages"
    )
  