{{
    config( materialized='table',
            liquid_clustered_by='date_key',
            tags='dimension'
          )

}}

SELECT
    calendar_date AS date_full,
    REPLACE(calendar_date, '-', '') AS date_key,
    YEAR(calendar_date) AS year,
    QUARTER(calendar_date) AS quarter,
    MONTH(calendar_date) AS month,
    WEEKOFYEAR(calendar_date) AS week,
    DAY(calendar_date) AS day,
    WEEKDAY(calendar_date) AS day_of_week,
    DATE_FORMAT(calendar_date, 'E') AS day_name,
    DATE_FORMAT(calendar_date, 'MMMM') AS month_name,
    CASE
        WHEN DAYOFWEEK(calendar_date) IN (1, 7)
            THEN 0
        ELSE 1
    END AS is_weekday,
    CASE
        WHEN YEAR(calendar_date) % 4 = 0
            THEN 1
        ELSE 0
    END AS is_leapyear
FROM (
    SELECT
        EXPLODE(
            SEQUENCE(DATE '1992-01-01', DATE '2000-12-31', INTERVAL 1 DAY)
        ) AS calendar_date
) AS dates
