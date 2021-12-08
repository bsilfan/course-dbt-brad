{{
  config(
    materialized='table'
  )
}}

with total_sessions as (

select
    d.date as date,
    count(distinct us.session_id) as total_user_sessions
from {{ ref("dim_dates") }} d
left join {{ ref("fact_user_sessions") }} us on d.date = date_trunc('day', us.created_at)
group by 1

)

select 
    t.date,
    t.total_user_sessions,
    sum(total_page_views) as total_page_views,
    sum(total_adds_to_cart) as total_adds_to_cart,
    sum(has_checkout) as total_checkouts,
    sum(total_page_views) / t.total_user_sessions as sessions_with_page_views_pct,
    sum(total_adds_to_cart) / t.total_user_sessions as sessions_with_add_to_cart_pct,
    sum(has_checkout)::float / t.total_user_sessions as sessions_with_transaction_pct
from total_sessions t 
left join {{ ref("fact_page_views") }} pv on  t.date = date_trunc('day', pv.event_date)
group by 1, 2
order by 1