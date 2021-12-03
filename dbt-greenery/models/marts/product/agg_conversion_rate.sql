{{
  config(
    materialized='table'
  )
}}

select
    sum(checkout) / count(distinct session_id)
from {{ ref("fact_user_sessions") }}