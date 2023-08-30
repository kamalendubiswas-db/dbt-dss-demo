{{
    config( materialized='ephemeral',
            tags='mart',
            alias='supplier_count'
          )

}}

select
  dc.country,
  count(distinct fol.supplier_key) as total_suppliers,
  sum(fol.total_price) as total_amount_supplied
from
  {{ ref('fact_order_line') }}  fol
  inner join {{ ref('dim_supplier') }}  ds on ds.supplier_key = fol.supplier_key
  inner join {{ ref('dim_country') }}  dc on dc.country_id = ds.country_id
group by
  dc.country