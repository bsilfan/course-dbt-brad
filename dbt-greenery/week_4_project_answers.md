**1. Modeling challenge**

**Please create any additional dbt models needed to help answer these questions from our product team, and put your answers in a README in your repo.**

See agg_daily_product_funnel.sql

**Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. Please reference the course content if you have questions.**

See exposures.yml

--------------------------------------------------------------------------------------------------------------------

**Reflection questions**

2A.  This course has given me the foundation and confidence needed to make the full jump from Finance -> Analytics Engineering.  I've always felt like I needed a "credential" to make the full leap.  Having gone through the course and learning with this community has made me feel like less of an "imposter" and like I have the skills/knowledge to do this as my profession (or at least know where to go to find the answers!).  Really appreciative of the entire staff, TAs, cohort, pod, etc.

2B.  I would be interested in using Airflow as an orchestration tool.  The order of operations would probably look like dbt seed -> dbt run -> dbt test -> dbt artifacts -> dbt docs.  Would set up slack alerting for dbt test failures as well as a table to log dbt test results.  Would use this and other dbt artifacts to build a dashboard in BI tool to monitor dbt project health.