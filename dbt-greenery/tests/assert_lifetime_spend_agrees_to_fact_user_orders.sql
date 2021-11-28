with orders as (

select 
    user_id, 
    sum(order_total) as orders_total 
from {{ ref("fact_orders") }}
group by 1

),

user_orders as (

select 
    user_id,
    sum(lifetime_spend) as user_orders_total 
from {{ ref("fact_user_orders") }}
group by 1

)

select 
    user_id, 
    orders_total, 
    user_orders_total,
    round(orders_total - user_orders_total) as difference
from orders 
left join user_orders using (user_id)
where round(orders_total - user_orders_total) != 0