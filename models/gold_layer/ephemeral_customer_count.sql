{{
    config( materialized='ephemeral',
            tags='mart',
            alias='customer_count'
          )

}}

select
    dc.country,
    count(distinct fol.customer_key) as total_customers,
    sum(fol.total_price) as total_amount_spent
from
    {{ ref('fact_order_line') }} as fol
inner join {{ ref('dim_customer') }} as ds on fol.customer_key = ds.customer_key
inner join {{ ref('dim_country') }} as dc on ds.country_id = dc.country_id
group by
    dc.country
