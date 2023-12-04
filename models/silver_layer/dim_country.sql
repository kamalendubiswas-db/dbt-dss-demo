{{
    config( materialized='table',
            liquid_clustered_by='country_key',
            tags='dimension'
          )

}}

SELECT
    nation_id AS country_id,
    nation_name AS country,
    MD5(nation_name || '-' || nation_id) AS country_key,
    CURRENT_DATE() AS dwh_inserted_at,
    CURRENT_DATE() AS dwh_updated_at
FROM
    {{ source('bronze_layer', 'raw_nations') }}
