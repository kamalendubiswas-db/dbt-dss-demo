{{
    config( materialized='view',
            tags=['mart'],
          )

}}

with rankedorders as (
    select
      dt.year as order_year,
      dsp.supplier_id,
      dsp.supplier_name,
      sum(fol.total_price) as total_amount_supplied,
      row_number() over (
        partition by dt.year
        order by
          sum(fol.total_price) desc
      ) as rank_within_year
    from
      {{ ref('fact_order_line') }}  fol
      inner join {{ ref('dim_order') }}  dor on dor.order_key = fol.order_key
      inner join {{ ref('dim_date') }}  dt on dt.date_full = dor.order_date
      inner join {{ ref('dim_supplier') }}  dsp on fol.supplier_key = dsp.supplier_key
    group by
      dsp.supplier_id,
      dsp.supplier_name,
      order_year
  )
select
  order_year,
  supplier_id,
  supplier_name,
  total_amount_supplied
from
  rankedorders
where
  rank_within_year <= 10
order by
  order_year desc,
  rank_within_year