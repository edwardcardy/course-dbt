{{
  config(
    materialized='table'
  )
}}

SELECT
product_id,
product_name,
price,
inventory
FROM {{ref('stg_products')}} p