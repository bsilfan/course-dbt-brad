{{
  config(
    materialized='table'
  )
}}

select
    d.date as date,
    count(distinct us.session_id) as total_user_sessions,
    count(distinct case when page_view > 0 then session_id end) as total_page_views,
    count(distinct case when add_to_cart > 0 then session_id end) as total_adds_to_cart,
    count(distinct case when checkout > 0 then session_id end) as total_checkouts,
    count(distinct case when page_view > 0 then session_id end)::float / count(distinct us.session_id)::float  as sessions_with_page_views_pct,
    count(distinct case when add_to_cart > 0 then session_id end)::float / count(distinct us.session_id)::float  as sessions_with_add_to_cart_pct,
    count(distinct case when checkout > 0 then session_id end)::float / count(distinct us.session_id)::float  as sessions_with_transaction_pct
from {{ ref("dim_dates") }} d
left join {{ ref("fact_user_sessions") }} us on d.date = date_trunc('day', us.created_at)
group by 1
having count(distinct us.session_id) != 0