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
