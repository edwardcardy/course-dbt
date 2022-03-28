{{
  config(
    materialized='view'
  )
}}

SELECT 
product_id,
name AS product_name,
REPLACE(name,' ','') AS product_name_nospaces,
price,
inventory
FROM {{ source('tutorial', 'products') }}
