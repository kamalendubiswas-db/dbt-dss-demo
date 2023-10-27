{{
    config( materialized='table',
            tags='fact',
          )

}}

SELECT
  ord.order_key       AS  order_key,
  cust.customer_key   AS  customer_key,
  part.part_key       AS  part_key,
  sup.supplier_key    AS  supplier_key,
  lnt.line_number     AS  line_number,
  lnt.quantity        AS  quantity,
  lnt.extended_price  AS  extended_price,
  lnt.discount        AS  discount,
  lnt.tax             AS  tax,
  lnt.ship_date       AS  ship_date,
  lnt.receipt_date    AS  receipt_date,
  lnt.commit_date     AS  commit_date,
  ord.total_price     AS  total_price,
  ord.order_status    AS  order_status,
  CURRENT_DATE        AS  dwh_inserted_at,
  CURRENT_DATE        AS  dwh_upadted_at
FROM
  {{ ref('dim_order') }}  ord
  LEFT JOIN   {{ source('bronze_layer', 'raw_lineitems') }}    lnt   ON  lnt.order_id      = ord.order_id
  LEFT JOIN   {{ ref('dim_supplier') }}   sup   ON  sup.supplier_id   = lnt.supplier_id
  LEFT JOIN   {{ ref('dim_part') }}       part  ON  part.part_id      = lnt.part_id
  LEFT JOIN   {{ ref('dim_customer') }}   cust  ON  cust.customer_id  = ord.customer_id