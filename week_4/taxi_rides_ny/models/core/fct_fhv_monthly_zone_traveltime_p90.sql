{{
    config(
        materialized='table'
    )
}}

with tripdata as (
    select *,
        TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, second) as trip_duration,
    from {{ ref('dim_fhv_trips') }}
)

select t.*
from (
    select 
        pickup_year, 
        pickup_month, 
        pickup_locationid,
        pickup_zone,
        dropoff_locationid,
        dropoff_zone,
        percentile_cont(trip_duration, 0.9) over (partition by pickup_year, pickup_month, pickup_locationid, dropoff_locationid)  as p90,
        row_number() over (partition by pickup_year, pickup_month, pickup_locationid, dropoff_locationid) as rn
    from tripdata
) t
where t.rn = 1
