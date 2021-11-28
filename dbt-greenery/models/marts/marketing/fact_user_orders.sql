{{
  config(
    materialized='table'
  )
}}

select
    o.user_id,
    u.created_at as user_created_at,
    min(o.created_at) as first_order_date,
    max(o.created_at) as latest_order_date,
    case 
      when max(o.created_at) > (now() - interval '90 days') then 'active'
      else 'not active'
    end as active_last_90_days,
    count(distinct o.order_id) as order_count,
    sum(o.order_total) as lifetime_spend,
    sum(o.order_total)  / nullif(count(distinct o.order_id), 0) as average_order_value,
    sum(o.qty) as total_items_ordered,
    sum(o.qty) / nullif(count(distinct o.order_id), 0) as average_items_qty,
    count(distinct o.promo_id) as promos_used,
    count(distinct o.promo_id) / nullif(count(distinct o.order_id), 0) as promo_pct_of_orders
from {{ ref('fact_orders') }} o
left join {{ ref('dim_users') }} u using (user_id)
group by 1, 2