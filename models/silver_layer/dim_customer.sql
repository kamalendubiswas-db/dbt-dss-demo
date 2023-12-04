{{
    config( materialized='table',
            liquid_clustered_by='customer_key',
            tags='dimension'
          )

}}

SELECT
    customer_id AS customer_id,
    customer_name AS customer_name,
    nation_id AS country_id,
    address AS customer_address,
    phone_number AS phone_number,
    account_balance AS account_balance,
    MD5(customer_id || '_' || customer_name) AS customer_key,
    CURRENT_DATE AS dwh_inserted_at,
    CURRENT_DATE AS dwh_updated_at
FROM
    {{ source('bronze_layer', 'raw_customers') }}
