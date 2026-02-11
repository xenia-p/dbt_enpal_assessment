{{ config(materialized='view') }}

-- Staging model for `activity_types` source
SELECT
  stage_id,
  stage_name
FROM {{ source('postgres_public', 'stages') }}
