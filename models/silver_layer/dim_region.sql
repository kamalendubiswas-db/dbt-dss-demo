{{
    config( materialized='table',
            tags='dimension'
          )

}}

SELECT
  MD5(region_name || '-' || region_id)  AS region_key,
  region_id                             AS region_id,
  region_name                           AS region_name,
  CURRENT_DATE                          AS dwh_inserted_at,
  CURRENT_DATE                          AS dwh_updated_at
FROM
    {{ source('bronze_layer', 'raw_regions') }}