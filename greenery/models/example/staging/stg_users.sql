{{
  config(
    materialized='table'
  )
}}

SELECT 
user_id,
first_name,
last_name,
email,
phone_number,
created_at AS signup_date,
updated_at AS updated_date,
address_id
FROM {{ source('tutorial', 'users') }}
