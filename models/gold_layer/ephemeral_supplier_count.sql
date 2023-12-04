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
    {{ ref('fact_order_line') }} as fol
inner join {{ ref('dim_supplier') }} as ds on fol.supplier_key = ds.supplier_key
inner join {{ ref('dim_country') }} as dc on ds.country_id = dc.country_id
group by
    dc.country
