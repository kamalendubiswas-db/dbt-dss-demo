{{
    config( materialized='table',
            tag=['silver_layer','dimension'],
          )

}}

SELECT
  MD5(region_name || '-' || region_id)  AS region_key,
  region_id                             AS region_id,
  region_name                           AS region_name,
  CURRENT_DATE                          AS dwh_inserted_at,
  CURRENT_DATE                          AS dwh_updated_at
FROM
    {{ source('bronze_layer', 'regions') }}