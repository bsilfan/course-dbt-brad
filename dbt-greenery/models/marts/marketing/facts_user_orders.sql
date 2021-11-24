{{
  config(
    materialized='table'
  )
}}

select
    o.user_id,
    u.created_at,
    sum(o.order_total) as lifetime_spend,
    count(o.order_id) as order_count,
    sum(o.order_total)  / count(o.order_id) as average_order_value
from {{ ref('stg_orders') }} o
left join {{ ref('stg_users') }} u using (user_id)
group by 1, 2