

WITH months_stages AS (
  SELECT DISTINCT
    start_month,
    stage_id,
    stage_name
  FROM "postgres"."public_pipedrive_analytics"."stg_dim_dates"
  CROSS JOIN "postgres"."public_pipedrive_analytics"."interm_dim_stages"
  WHERE start_date >= '2024-01-01' --hardcoded to match the start date
),

deals_count AS (
  SELECT
    stage_id,
    date_trunc('month', initial_stage_time) AS initial_stage_month,
    count(DISTINCT deal_id) AS deals_count
  FROM "postgres"."public_pipedrive_analytics"."marts_deals_stages"
  GROUP BY 1, 2
)

SELECT
  m_s.start_month AS month,
  m_s.stage_name AS kpi_name,
  m_s.stage_id AS funnel_step,
  coalesce(deals_count.deals_count, 0) AS deals_count
FROM months_stages AS m_s
LEFT JOIN deals_count
  ON m_s.start_month = deals_count.initial_stage_month AND m_s.stage_id = deals_count.stage_id
WHERE m_s.stage_name <> 'lost' --exclude lost deals as they are not part of the funnel