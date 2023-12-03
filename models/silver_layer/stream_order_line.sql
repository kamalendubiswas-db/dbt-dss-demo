{{
    config( materialized='streaming_table',
            tags='stream',
          )

}}

SELECT
    order_id::bigint,
    part_id::bigint,
    supplier_id::bigint,
    line_number::bigint,
    quantity::int,
    extended_price::double,
    discount::double,
    tax::double,
    return_flag::string,
    line_status::string,
    ship_date::date,
    commit_date::date,
    receipt_date::date,
    ship_instruct::string,
    shipmode::string,
    comment::string,
    extra::string
FROM
    STREAM({{ source('bronze_layer', 'raw_lineitems') }})
