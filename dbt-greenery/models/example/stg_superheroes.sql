{{
  config(
    materialized='table'
  )
}}

with superheroes_source as (

select * from {{ source('tutorial', 'superheroes') }}

),

superheroes_mod as (

select
    id AS superhero_id,
    name,
    gender,
    eye_color,
    race,
    hair_color,
    height,
    publisher,
    skin_color,
    alignment,
    weight
from superheroes_source

)

select * from superheroes_mod