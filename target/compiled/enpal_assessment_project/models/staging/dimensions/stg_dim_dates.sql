

WITH bounds AS (
  SELECT
    
            date '2024-01-01' as run_start_date
        ,
    current_date AS end_date
),

dates AS (
  SELECT gs::date AS start_date
  FROM bounds
  CROSS JOIN LATERAL generate_series(
    bounds.run_start_date::date,
    bounds.end_date::date,
    interval '1 day'
  ) AS gs
)

SELECT
  start_date,
  (start_date + interval '1 day')::date AS next_date,
  date_trunc('month', start_date)::date AS start_month,
  date_trunc('month', (start_date + interval '1 month'))::date AS next_month,
  (start_date + interval '1 year')::date AS next_year
FROM dates