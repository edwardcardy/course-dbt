{{
  config(
    materialized='view'
  )
}}

SELECT 
product_id,
name AS product_name,
REPLACE(product_name,' ','') AS product_name_nospaces,
price,
inventory
FROM {{ source('tutorial', 'products') }}
