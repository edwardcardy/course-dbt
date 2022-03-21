{{
  config(
    materialized='view'
  )
}}

SELECT 
event_id,
session_id,
user_id,
page_url,
created_at AS event_created_date,
event_type,
order_id,
product_id
FROM {{ source('tutorial', 'events') }}
