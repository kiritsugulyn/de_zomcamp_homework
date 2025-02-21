{{
    config(
        materialized='table'
    )
}}

with tripdata as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    tripdata.dispatching_base_num as dispatching_base_num,
    tripdata.pickup_datetime as pickup_datetime,
    tripdata.dropoff_datetime as dropoff_datetime,
    tripdata.pickup_locationid as pickup_locationid,
    tripdata.dropoff_locationid as dropoff_locationid,
    tripdata.sr_Flag as sr_Flag,
    tripdata.affiliated_base_num as affiliated_base_num,

    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 

    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  

    extract(year from tripdata.pickup_datetime) as pickup_year,
    extract(quarter from tripdata.pickup_datetime) as pickup_quarter,
    extract(month from tripdata.pickup_datetime) as pickup_month,
    concat(extract(year from tripdata.pickup_datetime), "Q", extract(quarter from tripdata.pickup_datetime)) as pickup_year_quarter,
from tripdata
inner join dim_zones as pickup_zone
on tripdata.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on tripdata.dropoff_locationid = dropoff_zone.locationid