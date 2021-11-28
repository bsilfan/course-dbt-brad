{{
  config(
    materialized='table'
  )
}}

with product_qty as (
select
  order_id,
  sum(quantity) as qty
from {{ ref('stg_order_items') }}
group by 1
)
select
    created_at,
    order_id,
    user_id,
    promo_id,
    address_id,
    order_cost,
    shipping_cost,
    order_total,
    delivered_at,
    shipping_service,
    qty
from {{ ref('stg_orders') }}
left join product_qty using (order_id)
where status != 'pending'