{{
    config( materialized='table',
            tags='dimension'
          )

}}

SELECT
  MD5(nation_name || '-' || nation_id)  AS country_key,
  nation_id                             AS country_id,
  nation_name                           AS country,
  CURRENT_DATE()                        AS dwh_inserted_at,
  CURRENT_DATE()                        AS dwh_updated_at
FROM
  {{ source('bronze_layer', 'raw_nations') }}