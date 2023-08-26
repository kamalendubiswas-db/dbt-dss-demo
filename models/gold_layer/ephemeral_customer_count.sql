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
    {{ ref('fact_order_line') }}  fol inner join
    {{ ref('dim_customer') }} inner join  ds on ds.customer_key = fol.customer_key
    {{ ref('dim_country') }} inner join  dc on dc.country_id = ds.country_id
  group by
    dc.country