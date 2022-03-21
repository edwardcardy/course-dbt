

with events as (
    select *
    from {{ ref('stg_events') }}
)



    select 
        page_url,
        count(event_id) as num_events,
        count(distinct session_id) as num_sessions,
        min(created_at) as first_viewed_at,
        max(created_at) as last_viewed_at
    from events
    group by 1


