
with page_views as (
    select *
    from {{ ref('int_page_views') }}
)


    select
        *,
        num_events*1.0/num_sessions as avg_views_per_session
    from page_views
