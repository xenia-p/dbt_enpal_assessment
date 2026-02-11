SELECT
  id,
  name,
  email,
  modified
FROM {{ source('postgres_public', 'users') }}
