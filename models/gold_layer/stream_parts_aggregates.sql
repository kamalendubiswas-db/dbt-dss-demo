{{
    config( materialized='streaming_table',
            tags='stream',
          )

}}

SELECT
    part_id,
    receipt_date,
    sum(quantity) AS quantity_sold
FROM
    stream({{ ref('stream_order_line') }})
GROUP BY
    part_id,
    receipt_date
