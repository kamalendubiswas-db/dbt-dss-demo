{{
    config( materialized='table',
            tags='dimension'
          )

}}

SELECT
  MD5(region_name || '-' || region_id)  AS region_key,
  region_id                             AS region_id,
  region_names                           AS region_name,
  CURRENT_DATE                          AS dwh_inserted_at,
  CURRENT_DATE                          AS dwh_updated_at
FROM
    {{ ref('raw_region_seed') }}