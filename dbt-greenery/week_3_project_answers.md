**Question 1**: Create new models to answer the first two questions (answer questions in README file)
  - What is our overall conversion rate?
  - What is our conversion rate by product? See dbt-greenery/models/marts/product/agg_conversion_rate_by_product.sql

**Answer**

See /models/marts/product/agg_conversion_rate.sql and /models/marts/product/agg_conversion_rate_by_product.sql

--------------------------------------------------------------------------------------------------------------------

**Question 2**: Create a macro to simplify part of a model(s)

**Answer**

I created two macros which achieve the same thing in two separte models to pullevent_types from stg_events into a looped case when statement.
(I wanted to retain both methodologies for my future reference)

See /models/marts/product/fact_user_sessions.sql and /models/marts/product/fact_user_sessions_dbt_utils.sql

--------------------------------------------------------------------------------------------------------------------

**Question 3**: Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running "CREATE ROLE reporting" in your database instance.

**Answer**

Please see the dbt_projects.yml as well as the macro schema.  I'm not sure I did this correctly / would appreciate review here!

--------------------------------------------------------------------------------------------------------------------

**Question 4**: Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

**Answer**

I used dbt_utils for the fact_user_sessions_dbt_utils.sql model mentioned above.

I also used dbt_utils to make a dim_dates model to be used for reporting/agg models such as agg_daily_orders (which I just added)

--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------

**Question 5**: Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.

**Answer**

![image](https://user-images.githubusercontent.com/56136736/144652278-a7d1cf8e-fc45-4fec-99c0-d687e7a192fc.png)

--------------------------------------------------------------------------------------------------------------------
