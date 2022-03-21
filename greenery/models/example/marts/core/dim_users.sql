{{
  config(
    materialized='table'
  )
}}

SELECT
u.user_id,
u.first_name,
u.last_name,
u.email,
u.phone_number,
u.signup_date,
u.updated_date,
u.address_id,
ad.street_address,
ad.zipcode,
ad.state,
ad.country
FROM {{ref('stg_users')}} u
LEFT JOIN {{ ref('stg_addresses') }} ad
  ON u.address_guid = ad.address_guid