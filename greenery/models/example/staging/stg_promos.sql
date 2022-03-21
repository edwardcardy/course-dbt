{{
  config(
    materialized='view'
  )
}}

SELECT 
promo_id,
discount,
status AS promo_status
FROM {{ source('tutorial', 'promos') }}
