{{
  config(
    materialized='table'
  )
}}

{% set products = dbt_utils.get_column_values(table=ref('stg_products'), column='product_name_nospaces') %}


with users as (
    select *
    from {{ ref('stg_users') }}
),

orders as (
    select *
    from {{ ref('stg_orders') }}
),

products as (
    select *
    from {{ ref('stg_products') }}
),

order_items as (
    select *
    from {{ ref('stg_order_items') }}
),

order_facts as (
    select user_id,
    count(order_id) as count_orders,
    sum(order_total) as total_order_spend,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date,
    sum(case when promo_id is not null then 1 else 0 end) as count_promo_orders

    from orders o
    group by 1
),

order_item_facts AS (
SELECT user_id,
{% for product in products %}
    SUM(CASE WHEN product_name = '{{product}}' THEN oi.quantity ELSE 0 END) AS total_{{product}}s_ordered
    {% if not loop.last %},{% endif %}  
    {% endfor %}
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
)


    select 
        u.*,
        o.count_orders,
        o.total_order_spend,
        o.first_order_date,
        o.last_order_date,
        count_promo_orders,
        oif.*

    from order_facts o
    left join users u
        ON o.user_id = u.user_id
    left join order_item_facts oif
        ON oif.user_id = o.user_id