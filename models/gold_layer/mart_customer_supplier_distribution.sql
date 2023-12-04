{{
    config(
        materialized='materialized_view',
        tblproperties={"delta.enableChangeDataFeed":"true"},
        tags='mart',

    )
}}

select
    sc.country,
    sc.total_suppliers,
    sc.total_amount_supplied,
    cc.total_customers,
    cc.total_amount_spent
from
    {{ ref('ephemeral_supplier_count') }} as sc
inner join
    {{ ref('ephemeral_customer_count') }} as cc
    on sc.country = cc.country
order by
    country
