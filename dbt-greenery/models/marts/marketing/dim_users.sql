{{
  config(
    materialized='table'
  )
}}

select
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  u.phone_number,
  a.address,
  a.zipcode,
  a.state,
  a.country,
  u.created_at
from {{ ref("stg_users") }} u
left join{{ ref("stg_addresses") }} a using (address_id)