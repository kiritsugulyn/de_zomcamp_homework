{{
    config(
        materialized='table'
    )
}}

with trip_data as (
    select * from {{ ref('fact_trips') }}
)
    
select service_type, pickup_year, pickup_quarter, min(pickup_year_quarter) as pickup_year_quarter, sum(total_amount) as sum_total_amount
from {{ ref('fact_trips') }}
group by 1,2,3