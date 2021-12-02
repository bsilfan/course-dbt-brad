{{
  config(
    materialized='table'
  )
}}

select
    product_id,
    product_name,
    sum(case when net_adds_to_cart > 0 and has_checkout = 1 then net_adds_to_cart end) /
    sum(total_page_views)
from {{ ref("fact_page_views") }}
group by 1, 2