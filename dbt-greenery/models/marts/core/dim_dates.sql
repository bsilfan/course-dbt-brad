{{
  config(
    materialized='table'
  )
}}

with date_spine as (
{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2021-01-01' as date)",
    end_date="cast('2021-03-01' as date)"
   )
}}
)

select
    date_day as date,
    extract(dow from date_day) as day_of_week,
    date_trunc('week', date_day) as week_starting_on,
    date_trunc('month', date_day) as month_starting_on,
    date_trunc('quarter', date_day) as quarter_starting_on,
    date_trunc('year', date_day) as year_starting_on,
    extract(year from date_day) as year
from date_spine