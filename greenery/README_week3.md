What is our overall conversion rate?

```
select COUNT(DISTINCT session_id) AS total_sessions
     , COUNT(DISTINCT CASE WHEN event_type = 'checkout' THEN session_id END) AS conversions
     , 1.0 * COUNT(DISTINCT CASE WHEN event_type = 'checkout' THEN session_id END) / COUNT(DISTINCT session_id)  AS conversion_rate
FROM dbt_edward_c.fct_events
```

Answer: 62.5%

What is our conversion rate by product?

```
select product_name
    , COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN e.session_id END) AS total_product_page_view_sessions
    , COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN e.session_id END) AS total_product_purchase_sessions
    , 1.0 * COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN e.session_id END) / COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN e.session_id END)  AS conversion_rate
FROM dbt_edward_c.fct_events e
JOIN dbt_edward_c.dim_products p
  ON e.product_id = p.product_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5
```

Answer: 

| Product name     | total product page view sessions | total product purchase sessions | conversion rate        |
|------------------|----------------------------------|---------------------------------|------------------------|
| String of pearls | 64                               | 44                              | 0.68750000000000000000 |
| Bamboo           | 67                               | 42                              | 0.62686567164179104478 |
| Birds Nest Fern  | 78                               | 40                              | 0.51282051282051282051 |
| Arrow Head       | 63                               | 39                              | 0.61904761904761904762 |
| Majesty Palm     | 67                               | 38                              | 0.56716417910447761194 |