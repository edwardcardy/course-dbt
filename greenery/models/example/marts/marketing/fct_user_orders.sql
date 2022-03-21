with users as (
    select *
    from {{ ref('stg_users') }}
),

orders as (
    select *
    from {{ ref('stg_orders') }}
),

order_facts as (
    select user_id,
    count(order_id) as count_orders,
    sum(order_total) as total_order_spend,
    min(order_date) as first_order_date,
    max(order_date) as latest_order_date,
    sum(case when promo_id is not null then 1 else 0 end) as count_promo_orders
    from orders
    group by 1
),


    select 
        u.*
        o.count_orders,
        o.total_order_spend,
        o.first_order_date,
        o.last_order_date,
        count_promo_orders

    from order_facts o
    left join users u
        ON o.user_id = u.user_id