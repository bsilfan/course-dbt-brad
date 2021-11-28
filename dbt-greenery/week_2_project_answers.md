**(Part 1) Models**

----------------------------------------------------------------------------------------------
**Question 1:** What is our user repeat rate?

**Answer:** 80.5%

```sql

with user_orders as (

select 
 user_id,
count(user_id) as purchases
from stg_orders
group by 1

)

select
 count(case when purchases >= 2 then user_id end)::float / count(user_id)::float
from user_orders
```
----------------------------------------------------------------------------------------------
**Question 2:** What are good indicators of a user who will likely purchase again?

**Answer:**  If they submitted a rating on their first order, if they had any order issues (i.e.
late delivery, defective products), if they had positive interactions with customer service,
how often they view products/the website, how long it's been since they last logged in/purchased

----------------------------------------------------------------------------------------------
**Question 3:** Explain the marts models you added.  Why did you organize it the way you did?

**Answer:**  

In core I wanted to focus on orders/financial information at both the order level
and the order item level (more to discuss here in the testing section).  I think the basis for
any analysis is knowing how the company is doing is having sales data at both of these granularities.

In marketing I focused on user data and metrics.  It's built upon the core fact table and aggregating
by user for many key metrics such as lifetime spend, average order value and adding some non-financial
metrics such as "did the customer place an order in the last 90 days?".  The marketing team could use
this to see what customers to target.

In products I went back and added/parsed product_id from the url in the staging model itself in order
to aggregate page views and metrics at this granularity.  Since this was a simple translation I did not
do it in a dim table.

Overall I struggled with the idea of making many dim/int tables unnecessarily since the dataset 
was very simple and the queries to produce the fact tbales were not that complex.  I definitely understood
the reasoning of why they should be used though and have thought of some real world examples from my company
of where they make sense.

----------------------------------------------------------------------------------------------

**(Part 2) Tests**

----------------------------------------------------------------------------------------------

**Question 1:** What assumptions are you making about each model? (i.e. why did you add each test?)

**Answer:** The purpose of the tests I implemented were to ensure that the fact models I materialized
to the end users agreed to the source information (and that non of the transformations/joins/aggregations
messed this up).

----------------------------------------------------------------------------------------------

**Question 2:** Did you find any "bad" data as you added and ran tests on your models? 

**Answer:** Yes - my order items test is currently failing.  I can not fix this because this is due to 
a failure in the data itself.  I would take this test and show it to our software engineering team to show
what kind of data we need to be capturing in source tables so that the required business analysis could
be performed.

----------------------------------------------------------------------------------------------

**Question 3:** Explain how you would ensure tests are passing regularly and how you would alert
stakeholders about bad data getting through?

**Answer:** I would set up these tests to run on a schedule and have any failures create slack alerts in a 
dedicated slack channel.  Additionally I would capture all test results in a table (with columns such as
test name, last run, pass/fail, number of exceptions, etc.) which could be used to make an automated dashboard
using whatever BI tool we had (i.e. Looker/Mode).  Additionally, would consider storing all failed data in a temporary
table and only allow data that passes tests to make it through to the final target.  Lastly would make the tests part 
of the github workflow (i.e. do not allow any pull requests to be merged before running tests/seeing if the pass/fail)
