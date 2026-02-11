{{ config(
    materialized='incremental',
    incremental_strategy='append'
) }}

SELECT
  deal_id,
  change_time,
  changed_field_key,
  new_value
FROM {{ source('postgres_public', 'deal_changes') }}
WHERE 1 = 1

  {% if is_incremental() %}
    -- only load rows newer than what’s already in the target table
    -- this assumes that change_time is never updated after the fact, which should be true for a change log
    AND change_time > (
      SELECT coalesce(max(change_time), timestamp '1900-01-01')
      FROM {{ this }}
    )
  {% endif %}
