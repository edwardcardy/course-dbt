{{
  config(
    materialized='table'
  )
}}




with events as (
    select *
    from {{ ref('stg_events') }}
)



    select 
        page_url,
        count(event_id) as num_events,
        count(distinct session_id) as num_sessions,
        min(event_created_date) as first_event_created_date,
        max(event_created_date) as last_event_created_date
    from events
    group by 1


