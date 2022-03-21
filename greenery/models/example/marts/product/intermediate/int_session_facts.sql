
{{ 
    config(
        materialized='table'
    ) 
}}

with events as (
    select * from {{ ref('fct_events') }}
)

select
    session_id,
    event_created_date,
    user_id,
    sum(case when event_type = 'page_view' then 1 end) as count_page_view,
    sum(case when event_type = 'add_to_cart' then 1 end) as count_add_to_cart,
    sum(case when event_type = 'checkout' then 1 end) as count_checkout,
    sum(case when event_type = 'package_shipped' then 1 end) as count_package_shipped
from events

{{ dbt_utils.group_by(3) }}