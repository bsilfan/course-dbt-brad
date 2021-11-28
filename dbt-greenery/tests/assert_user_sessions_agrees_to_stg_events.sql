with user_sessions as 

(

select 
    'total' as total, 
    sum(account_created + page_view + add_to_cart + delete_from_cart + checkout) as user_sessions 
from {{ ref("fact_user_sessions") }}

),

events as (

select 
    'total' as total, 
    count(distinct case when event_type in ('account_created', 'page_view', 'add_to_cart', 'delete_from_cart', 'checkout') 
        then event_id 
    end) as events 
from {{ ref("stg_events") }}

)

select 
    *, 
    user_sessions - events as difference
from user_sessions
join events using (total)
where user_sessions - events != 0