{{ config(materialized='view') }}

SELECT
  id,
  name,
  active,
  type
FROM {{ source('postgres_public', 'activity_types') }}
