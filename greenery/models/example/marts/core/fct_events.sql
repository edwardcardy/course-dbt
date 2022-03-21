{{
  config(
    materialized='table'
  )
}}

SELECT
event_id,
session_id,
user_id,
page_url,
event_created_date,
event_type,
order_id,
product_id
FROM {{ref('stg_events')}} e
