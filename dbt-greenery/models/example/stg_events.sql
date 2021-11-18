{{
  config(
    materialized='table'
  )
}}

with events_source as (

select * from {{ source('tutorial', 'events') }}

),

events_mod as (

select 
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at
from events_source

)

select * from events_mod