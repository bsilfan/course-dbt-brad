{{
  config(
    materialized='table'
  )
}}

select
    e.created_at as event_date,
    e.session_id,
    e.product_id,
    p.name as product_name,
    count(distinct case when e.event_type = 'page_view' then event_id end) as total_page_views,
    count(distinct case when e.event_type = 'add_to_cart' then event_id end) as total_adds_to_cart,
    count(distinct case when e.event_type = 'delete_from_cart' then event_id end) as total_deletes_from_cart,
    count(distinct case when e.event_type = 'add_to_cart' then event_id end) 
    - count(distinct case when e.event_type = 'delete_from_cart' then event_id end) as net_adds_to_cart,
    case 
      when session_id in (SELECT distinct session_id FROM {{ ref("stg_events") }} where event_type = 'checkout') then 1
      else 0
    end as has_checkout
from {{ ref("stg_events") }} e
left join {{ ref("dim_products") }} p using (product_id)
where e.product_id is not null
group by 1, 2, 3, 4