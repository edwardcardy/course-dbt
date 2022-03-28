
{{ 
    config(
        materialized='table'
    ) 
}}

{% set event_types = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') %}

with events as (
    select * from {{ ref('stg_events') }}
)




select
    session_id,
    event_created_date,
    user_id,
    {% for event_type in event_types %}
    SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS count_{{event_type}}_events
    {% if not loop.last %},{% endif %}  
    {% endfor %}
from events

{{ dbt_utils.group_by(3) }}