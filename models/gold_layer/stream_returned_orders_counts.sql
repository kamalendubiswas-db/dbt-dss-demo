{{
    config( materialized='streaming_table',
            tags='stream',
          )

}}

SELECT
    receipt_date,
    count(order_id) count_of_returned_order
FROM
  STREAM( {{ ref('stream_order_line') }} )
WHERE
  return_flag = 'R'
GROUP BY
  receipt_date