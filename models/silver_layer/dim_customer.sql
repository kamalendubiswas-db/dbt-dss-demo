{{
    config( materialized='table',
            tag=['silver_layer','dimension'],
          )

}}

SELECT
  MD5(customer_id || '_' || customer_name)  AS  customer_key,
  customer_id                               AS  customer_id,
  customer_name                             AS  customer_name,
  nation_id                                 AS  country_id,
  address                                   AS  customer_address,
  phone_number                              AS  phone_number,
  account_balance                           AS  account_balance,
  CURRENT_DATE                              AS  dwh_inserted_at,
  CURRENT_DATE                              AS  dwh_updated_at
FROM
    {{ source('bronze_layer', 'customers') }}