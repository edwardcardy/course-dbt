{{
  config(
    materialized='view'
  )
}}

SELECT 
order_id,
user_id,
promo_id,
address_id,
created_at AS order_date,
order_cost,
shipping_cost,
order_total,
tracking_id,
shipping_service,
estimated_delivery_at AS estimated_delivery_date,
delivered_at AS deliery_date,
status AS order_status
FROM {{ source('tutorial', 'orders') }}
