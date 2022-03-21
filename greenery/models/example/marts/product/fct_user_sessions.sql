
{{ 
    config(
        materialized='table'
    ) 
}}

with session_facts as (
    select * from {{ ref('int_session_facts') }}
)

, users as (
    select * from {{ ref('stg_users') }}
)

select
    sf.*,
    first_name,
    last_name,
    email,
    phone_number,
    signup_date,
    updated_date,
    address_id
from session_facts sf
left join users u
    on sf.user_id = u.user_id