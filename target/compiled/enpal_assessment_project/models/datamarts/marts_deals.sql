


WITH stages_aggregated AS (
  SELECT
    deal_id,
    min(initial_stage_time) AS initial_stage_time,
    min(CASE WHEN stage_order_desc = 2 THEN change_time END) AS pre_final_stage_time,
    min(CASE WHEN stage_order_desc = 2 THEN stage_id END) AS pre_final_stage_id,
    min(final_stage_time) AS final_stage_time,
    min(CASE WHEN stage_order_desc = 1 THEN stage_id END) AS final_stage_id,
    coalesce(min(CASE WHEN stage_order_desc = 1 THEN stage_id END) = 0, FALSE) AS is_lost,
    CASE
      WHEN min(CASE WHEN stage_order_desc = 1 THEN stage_id END) = 0
        THEN min(CASE WHEN stage_order_desc = 1 THEN lost_reason END)
    END AS lost_reason,
    bool_or(is_ever_lost) AS is_ever_lost,
    array_agg(stage_id ORDER BY stage_order) AS stages_sequence
  FROM "postgres"."public_pipedrive_analytics"."marts_deals_stages"
  GROUP BY deal_id
)

SELECT
  times_users.deal_id,
  times_users.deal_add_time,
  times_users.last_user_id,
  times_users.last_user_change_time,
  stages.initial_stage_time,
  stages.pre_final_stage_id,
  stages.pre_final_stage_time,
  stages.final_stage_time,
  stages.final_stage_id,
  stages.is_lost,
  stages.lost_reason,
  stages.is_ever_lost,
  stages.stages_sequence,
  stages.final_stage_time::date - times_users.deal_add_time::date AS days_to_final_stage,
  current_date - stages.final_stage_time::date AS days_since_final_stage
FROM
  (
  SELECT DISTINCT ON (deal_id)
    deal_id,
    deal_add_time,
    user_id AS last_user_id,
    change_time AS last_user_change_time
  FROM "postgres"."public_pipedrive_analytics"."interm_deals_times_users"
  ORDER BY deal_id ASC, change_time DESC
  )
  AS times_users
LEFT JOIN stages_aggregated AS stages ON times_users.deal_id = stages.deal_id