{{
    config( materialized='table',
            liquid_clustered_by='region_key',
            tags='dimension'
          )

}}

SELECT
    region_id AS region_id,
    region_name AS region_name,
    MD5(region_name || '-' || region_id) AS region_key,
    CURRENT_DATE AS dwh_inserted_at,
    CURRENT_DATE AS dwh_updated_at
FROM
    {{ ref('raw_region_seed') }}
