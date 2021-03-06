{{
  config(
    materialized='table'
  )
}}

with users_source as (

select * from {{ source('tutorial', 'users') }}

),

users_mod as (

select 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
from users_source

)

select * from users_mod