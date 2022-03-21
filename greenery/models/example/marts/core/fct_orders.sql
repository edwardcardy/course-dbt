{{
  config(
    materialized='table'
  )
}}

SELECT
o.order_id,
o.user_id,
o.promo_id,
o.address_id,
o.order_date,
o.order_cost,
o.shipping_cost,
o.order_total,
o.tracking_id,
o.shipping_service,
o.estimated_delivery_date,
o.deliery_date,
o.order_status,
p.promo_id,
p.discount,
p.promo_status

FROM {{ref('stg_orders')}} o
LEFT JOIN {{ ref('stg_promos') }} p
  ON o.promo_id = p.promo_id