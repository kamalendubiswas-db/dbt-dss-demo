{{
    config( materialized='table',
            liquid_clustered_by='supplier_key',
            tags='dimension'
          )

}}

SELECT
  MD5(supplier_name || '-' || supplier_id)  AS  supplier_key,
  supplier_id                               AS  supplier_id,
  supplier_name                             AS  supplier_name,
  address                                   AS  supplier_address,
  nation_id                                 AS  country_id,
  phone                                     AS  supplier_phone,
  account_balance                           AS  account_balance,
  CURRENT_DATE()                            AS  dwh_inserted_at,
  CURRENT_DATE()                            AS  dwh_updated_at
FROM
  {{ source('bronze_layer', 'raw_suppliers') }}