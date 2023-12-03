{{
    config( materialized='table',
            liquid_clustered_by='order_key',
            tags='fact',
          )

}}

SELECT
    ord.order_key AS order_key,
    ord.total_price AS total_price,
    ord.order_status AS order_status,
    cust.customer_key AS customer_key,
    con.country_key AS country_key,
    dt.date_key AS date_key,
    CURRENT_DATE AS dwh_inserted_at,
    CURRENT_DATE AS dwh_upadted_at
FROM
    {{ ref('dim_order') }} AS ord
LEFT JOIN
    {{ ref('dim_customer') }} AS cust
    ON ord.customer_id = cust.customer_id
LEFT JOIN {{ ref('dim_country') }} AS con ON cust.country_id = con.country_id
INNER JOIN {{ ref('dim_date') }} AS dt ON ord.order_date = dt.date_full
