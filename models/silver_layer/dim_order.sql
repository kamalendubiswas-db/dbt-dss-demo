{{
    config( materialized='table',
            tag=['silver_layer','dimension'],
          )

}}

SELECT
    MD5(order_id || '_')  AS  order_key,
    order_id              AS  order_id,
    customer_id           AS  customer_id,
    order_status          AS  order_status,
    total_price           AS  total_price,
    order_date            AS  order_date,
    order_priority        AS  order_priority,
    ship_priority         AS  ship_priority,
    CURRENT_DATE          AS  dwh_inserted_at,
    CURRENT_DATE          AS  dwh_upadted_at
FROM
    {{ source('bronze_layer', 'orders') }};