SELECT
  activity_id,
  type,
  assigned_to_user AS user_id,
  deal_id,
  done,
  due_to
FROM "postgres"."public"."activity"