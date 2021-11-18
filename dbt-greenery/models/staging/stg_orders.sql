{{
  config(
    materialized='table'
  )
}}

with orders_source as (

select * from {{ source('tutorial', 'orders') }}

),

orders_mod as (

SELECT 
    order_id,
    promo_id,
    user_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
from orders_source

)

select * from orders_mod