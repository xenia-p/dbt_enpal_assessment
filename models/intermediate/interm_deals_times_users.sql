WITH min_add_times AS (
  SELECT
    deal_id,
    new_value,
    changed_field_key,
    change_time,
    min(CASE WHEN changed_field_key = 'add_time' THEN new_value END)
      OVER (PARTITION BY deal_id)
      AS min_add_time,
    count(*) OVER (PARTITION BY deal_id) AS cnt
  FROM {{ ref('stg_deal_changes') }}
  WHERE
    changed_field_key IN ('add_time', 'user_id')
)

SELECT
  deal_id,
  new_value::integer AS user_id,
  min_add_time::timestamp AS deal_add_time,
  CASE WHEN changed_field_key = 'user_id' THEN change_time END AS change_time
FROM min_add_times
WHERE changed_field_key = 'user_id'
-- to include deals that don't have user_id changes but only have one line with add_time
OR cnt = 1
