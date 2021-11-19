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
    NULLIF(height, -99) AS height,
    publisher,
    skin_color,
    alignment,
    NULLIF(weight, -99) AS weight_lbs,
    {{ lbs_to_kgs('weight') }} AS weight_kg
from superheroes_source

)

select * from superheroes_mod