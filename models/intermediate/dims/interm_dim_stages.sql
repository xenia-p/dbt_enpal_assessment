SELECT
  stage_id,
  stage_name
FROM {{ ref('stg_dim_stages') }}

UNION ALL

SELECT
  2.1 AS stage_id,
  'Sales Call 1' AS stage_name

UNION ALL

SELECT
  3.1 AS stage_id,
  'Sales Call 2' AS stage_name

UNION ALL

SELECT
  0 AS stage_id,
  'lost' AS stage_name
