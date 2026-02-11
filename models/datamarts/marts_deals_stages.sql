{{ config(
    materialized='table',
    post_hook=[
      "create index if not exists idx_marts_stages_deal_id on {{ this }} (deal_id)", 
      "create index if not exists idx_marts_stages_stage_time on {{ this }} (stage_id, change_time)"
    ]
) }}


WITH stages_enriched AS (
  SELECT
    deal_id,
    stage AS stage_id,
    change_time,
    lost_reason,
    lead(stage) OVER (PARTITION BY deal_id ORDER BY change_time) AS next_stage_id,
    lead(change_time) OVER (PARTITION BY deal_id ORDER BY change_time) AS next_change_time,
    (lead(change_time) OVER (PARTITION BY deal_id ORDER BY change_time))::date
    - change_time::date AS days_to_next_stage,
    row_number() OVER (PARTITION BY deal_id ORDER BY change_time) AS stage_order,
    row_number() OVER (PARTITION BY deal_id ORDER BY change_time DESC) AS stage_order_desc,
    first_value(change_time) OVER (PARTITION BY deal_id ORDER BY change_time) AS initial_stage_time,
    last_value(change_time)
      OVER (
        PARTITION BY deal_id
        ORDER BY change_time ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      )
      AS final_stage_time,
    last_value(stage)
      OVER (
        PARTITION BY deal_id
        ORDER BY change_time ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      )
      AS final_stage_id,
    min(stage) OVER (PARTITION BY deal_id) AS min_stage_id
  FROM {{ ref('interm_deals_stages_enriched') }}
)

SELECT
  t.*,
  coalesce(t.min_stage_id = 0, FALSE) AS is_ever_lost
FROM stages_enriched AS t
