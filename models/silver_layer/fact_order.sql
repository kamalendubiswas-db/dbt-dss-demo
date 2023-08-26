{{
    config( materialized='table',
            tags='fact',
          )

}}

SELECT
  ord.order_key       AS  order_key,
  ord.total_price     AS  total_price,
  ord.order_status    AS  order_status,
  cust.customer_key   AS  customer_key,
  nat.nation_key      AS  nation_key,
  dt.date_key         AS  date_key, 
  CURRENT_DATE        AS  dwh_inserted_at,
  CURRENT_DATE        AS  dwh_upadted_at
FROM
  {{ ref('dim_order') }} ord
  LEFT JOIN   {{ ref('dim_customer') }}  cust ON cust.customer_id = ord.customer_id
  LEFT JOIN   {{ ref('dim_country') }}  nat   ON cust.nation_id   = nat.nation_id   
  INNER JOIN  {{ ref('dim_date') }}  dt       ON dt.date_full     = ord.order_date