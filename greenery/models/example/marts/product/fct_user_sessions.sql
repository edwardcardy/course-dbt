
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
    u.*
from events