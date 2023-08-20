{{
    config( materialized='table',
            tags=['dimension'],
          )

}}

SELECT
  MD5(part_name || '-' || part_id)  AS  part_key,
  part_id                           AS  part_id,
  part_name                         AS  part_name,
  manufacturer                      AS  part_address,
  brand                             AS  country_id,
  type                              AS  part_phone,
  size                              AS  account_balance,
  container                         AS  container,
  retail_price                      AS  retail_price,
  CURRENT_DATE()                    AS  dwh_inserted_at,
  CURRENT_DATE()                    AS  dwh_updated_at
FROM
  {{ source('bronze_layer', 'parts') }}