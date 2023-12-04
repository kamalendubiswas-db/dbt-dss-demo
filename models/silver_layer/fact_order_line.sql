{{
    config( materialized='table',
            liquid_clustered_by='order_key',
            tags='fact',
          )

}}

SELECT
    ord.order_key AS order_key,
    cust.customer_key AS customer_key,
    part.part_key AS part_key,
    sup.supplier_key AS supplier_key,
    lnt.line_number AS line_number,
    lnt.quantity AS quantity,
    lnt.extended_price AS extended_price,
    lnt.discount AS discount,
    lnt.tax AS tax,
    lnt.ship_date AS ship_date,
    lnt.receipt_date AS receipt_date,
    lnt.commit_date AS commit_date,
    ord.total_price AS total_price,
    ord.order_status AS order_status,
    CURRENT_DATE AS dwh_inserted_at,
    CURRENT_DATE AS dwh_upadted_at
FROM
    {{ source('bronze_layer', 'raw_lineitems') }} AS lnt
LEFT JOIN {{ ref('dim_order') }} AS ord ON lnt.order_id = ord.order_id
LEFT JOIN {{ ref('dim_supplier') }} AS sup ON lnt.supplier_id = sup.supplier_id
LEFT JOIN {{ ref('dim_part') }} AS part ON lnt.part_id = part.part_id
LEFT JOIN
    {{ ref('dim_customer') }} AS cust
    ON ord.customer_id = cust.customer_id
