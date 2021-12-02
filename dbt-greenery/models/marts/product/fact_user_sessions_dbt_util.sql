{{
  config(
    materialized='table'
  )
}}

{% set event_types = dbt_utils.get_query_results_as_dict(
    "select distinct event_type from" 
    ~ ref('stg_events')
    )
%}

select
  created_at
  , user_id
  , session_id
  {% for event_type in event_types %}
  , count(distinct case when event_type = '{{event_type}}' then event_id end) as {{ event_type }}
  {% endfor %}
from {{ ref("stg_events") }}
group by 1, 2, 3