

WITH t AS (
  SELECT *
  FROM "postgres"."public"."fields"
  WHERE field_key = 'lost_reason'
)

SELECT
  opt ->> 'id' AS option_id,
  opt ->> 'label' AS option_label
FROM t
CROSS JOIN LATERAL jsonb_array_elements(t.field_value_options::jsonb) AS opt