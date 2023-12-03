{{
    config( materialized='view',
            tags='mart',
          )

}}

with rankedorders as (
    select
        dt.year as order_year,
        doc.customer_id,
        doc.customer_name,
        sum(fo.total_price) as total_amount_ordered,
        row_number() over (
            partition by dt.year
            order by
                sum(fo.total_price) desc
        ) as rank_within_year
    from
        {{ ref('fact_order') }} as fo
    inner join {{ ref('dim_date') }} as dt on fo.date_key = dt.date_key
    inner join
        {{ ref('dim_customer') }} as doc
        on fo.customer_key = doc.customer_key
    group by
        doc.customer_id,
        doc.customer_name,
        order_year
)

select
    order_year,
    customer_id,
    customer_name,
    total_amount_ordered
from
    rankedorders
where
    rank_within_year <= 10
order by
    order_year desc,
    rank_within_year asc
