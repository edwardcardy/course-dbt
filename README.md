# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

## License

Apache 2.0


1. How many users do we have?

``
SELECT COUNT(DISTINCT user_id)
from dbt_edward_c.stg_orders
``

Answer: 130

2. On average, how many orders do we receive per hour?

``
with hourly_orders AS (
select date_trunc('hour', created_at) AS created_hour
     , count(1) as orders 

from dbt_edward_c.stg_orders
group by 1
)

SELECT sum(orders) AS total_orders
    , count(1) AS total_hours
    , sum(orders) / count(1) AS avg_hourly_orders
from hourly_orders
``

Answer: 7.52

3. On average, how long does an order take from being placed to being delivered?

``
SELECT avg(delivered_at - created_at) AS avg_delivery_time
FROM dbt_edward_c.stg_orders
``

Answer: 3 days, 21 hours, 24 mins


4. How many users have only made one purchase? Two purchases? Three+ purchases?

``
with opu AS (
select user_id
   , count(1) AS orders_per_user
from dbt_edward_c.stg_orders
group by 1
)

SELECT CASE WHEN orders_per_user IN(1,2) THEN CAST(orders_per_user AS char)
			WHEN orders_per_user >=3 THEN '3+' END AS orders_per_user
     , count(1)
from opu
GROUP BY 1
ORDER BY 1
``

Answer: 

count_orders	count_users
1	       | 25
2	       | 28
3+       | 71



5. On average, how many unique sessions do we have per hour?

``
WITH hourly_sessions AS (
SELECT date_trunc('hour', created_at) AS session_hour
    , COUNT(DISTINCT session_id) AS sessions
FROM dbt_edward_c.stg_events
group by 1
)

SELECT avg(sessions) AS avg_hourly_sessions
FROM hourly_sessions
``

Answer: 16.33
