**Question 1:**  How many users do we have? 

**Answer:** 130
```sql
select stg_users count(*) from stg_users
```
----------------------------------------------------------------------------------------------

**Question 2:** On average, how many orders do we receive per hour?

**Answer:** 8.33
```sql
select 
  count(order_id)
  / (extract(days from date_trunc('day', max(created_at))) - extract(days from date_trunc('day', min(created_at))) + 1) 
  / 24 
from stg_orders
```
----------------------------------------------------------------------------------------------

**Question 3:** On average, how long does an order take from being placed to being delivered?

**Answer:** ~4 days
```sql
select avg(delivered_at - created_at) from stg_orders where status = 'delivered'
```

----------------------------------------------------------------------------------------------

**Question 4:** How many users have only made one purchase? Two purchases? Three+ purchases?

**Answer:** 25 users have made one purchase.  22 users have made two purchases.  81 users have made 3+ purchases
```sql
with user_orders as (
  
  select 
    user_id, 
    count(order_id) as order_count 
  from stg_orders group by 1
  
  )

select
  count(case when order_count = 1 then user_id end) as one_order,
  count(case when order_count = 2 then user_id end) as two_orders,
  count(case when order_count >= 3 then user_id end) as three_or_more_orders
from user_orders
```

----------------------------------------------------------------------------------------------

**Question 5:** On average, how many unique sessions do we have per hour?

**Answer:** ~7.3 sessions
```sql
with session_hours as (

select 
  date_trunc('hour', created_at), 
  count(distinct session_id) as sessions_per_hour 
from stg_events 
where created_at is not null group by 1

)

select avg(sessions_per_hour) from session_hours
```

----------------------------------------------------------------------------------------------

