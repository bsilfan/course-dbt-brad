{{
  config(
    materialized='table'
  )
}}

select
    o.created_at,
    oi.order_id,
    oi.product_id,
    p.name,
    oi.quantity,
    p.price,
    oi.quantity * p.price as order_total,
    o.delivered_at
from {{ ref('stg_order_items') }} oi
left join {{ ref('stg_products')}} p using (product_id)
left join {{ ref('stg_orders') }} o using (order_id)
where o.status != 'pending'