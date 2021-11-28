{{
  config(
    materialized='table'
  )
}}

select
  created_at,
  user_id,
  session_id,
  count(distinct case when event_type = 'account_created' then event_id end) as account_created,
  count(distinct case when event_type = 'page_view' then event_id end) as page_view,
  count(distinct case when event_type = 'add_to_cart' then event_id end) as add_to_cart,
  count(distinct case when event_type = 'delete_from_cart' then event_id end) as delete_from_cart,
  count(distinct case when event_type = 'checkout' then event_id end) as checkout
from {{ ref("stg_events") }}
group by 1, 2, 3