{{
    config( materialized='table',
            liquid_clustered_by='part_key',
            tags='dimension'
          )

}}

SELECT
    part_id AS part_id,
    part_name AS part_name,
    manufacturer AS part_address,
    brand AS country_id,
    type AS part_type,
    size AS account_balance,
    container AS container,
    retail_price AS retail_price,
    MD5(part_name || '-' || part_id) AS part_key,
    CURRENT_DATE() AS dwh_inserted_at,
    CURRENT_DATE() AS dwh_updated_at
FROM
    {{ source('bronze_layer', 'raw_parts') }}
