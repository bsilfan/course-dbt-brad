{{
  config(
    materialized='table'
  )
}}

select distinct
    product_id,
    name
from {{ ref("stg_products")}}