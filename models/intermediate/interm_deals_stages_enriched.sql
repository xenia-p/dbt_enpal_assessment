WITH activities AS (
  SELECT
    activity.deal_id,
    CASE
      WHEN type = 'meeting' THEN 2.1
      WHEN type = 'sc_2' THEN 3.1
    END AS stage,
    due_to AS change_time,
    null AS lost_reason
  FROM {{ ref('stg_activity') }} AS activity
  --theoretically this join is not needed when all deals in activities have a stage change, 
  --I add it to avoid including activities for deals that are not in our main dataset
  INNER JOIN (SELECT DISTINCT deal_id FROM {{ ref('stg_deal_changes') }}) AS deals
    ON activity.deal_id = deals.deal_id
  WHERE
    done IS true
    AND type IN ('meeting', 'sc_2')
),

unioned AS (
  SELECT
    deal_id,
    CASE
      WHEN changed_field_key = 'stage_id'
        THEN new_value::numeric
      WHEN changed_field_key = 'lost_reason'
        THEN 0::numeric
    END AS stage,
    change_time,
    CASE
      WHEN changed_field_key = 'lost_reason'
        THEN new_value
    END AS lost_reason
  FROM {{ ref('stg_deal_changes') }}
  WHERE changed_field_key IN ('stage_id', 'lost_reason')

  UNION ALL

  SELECT *
  FROM activities
)

SELECT *
FROM unioned
