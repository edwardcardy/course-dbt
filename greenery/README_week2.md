1. What is the user repeat rate?

```
select count(1) AS total_users
   , sum(case when count_orders >= 1 THEN 1 ELSE 0 END) AS order_users
   , sum(case when count_orders >= 2 THEN 1 ELSE 0 END) AS repeat_users
   , 1.00 * sum(case when count_orders >= 2 THEN 1 ELSE 0 END) / sum(case when count_orders >= 1 THEN 1 ELSE 0 END) AS user_repeat_rate
from dbt_edward_c.fct_user_orders
```

Answer: 79.8%


