{{
  config(
    materialized='table'
  )
}}

select
    d.date,
    count(distinct o.order_id) as total_orders,
    sum(o.qty) as total_products_sold,
    sum(o.order_cost) as total_order_cost,
    sum(o.shipping_cost) as total_shipping_cost,
    sum(o.order_total) as total_order_total,
    sum(o.order_total) / sum(o.qty) as average_order_total
from {{ ref ( 'dim_dates' ) }} d
left join {{ ref ( 'fact_orders' ) }} o on d.date = date_trunc('day', o.created_at)
group by 1
