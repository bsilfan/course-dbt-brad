with order_items as (

select
    order_id,
    sum(order_total) as per_order_items
from {{ ref("fact_order_items") }}
group by 1

),

orders as (

select
    order_id,
    sum(order_total) as per_orders
from {{ ref("fact_orders") }}
group by 1

)

select
    order_id,
    per_order_items,
    per_orders,
    round(per_order_items - per_orders) as difference
from order_items
left join orders using (order_id)
where round(per_order_items - per_orders) != 0