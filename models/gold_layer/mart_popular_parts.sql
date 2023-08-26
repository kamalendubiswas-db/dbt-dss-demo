{{
    config( materialized='view',
            tags=['mart'],
          )

}}

select
  dps.part_name,
  dps.part_phone,
  count(fol.part_key) as total_part_sold,
  count(distinct fol.supplier_key) as total_available_supplier
from
  {{ ref('fact_order_line') }} fol
  inner join {{ ref('dim_part') }} dps on dps.part_key = fol.part_key
group by
  dps.part_name,
  dps.part_type
order by
  total_part_sold desc
limit
  100