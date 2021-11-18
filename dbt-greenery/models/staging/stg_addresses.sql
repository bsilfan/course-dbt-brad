{{
  config(
    materialized='table'
  )
}}

with addresses_source as (

select * from {{ source('tutorial', 'addresses') }}

),

addresses_mod as (

select 
    address_id,
    address,
    zipcode,
    state,
    country
from addresses_source

)

select * from addresses_mod