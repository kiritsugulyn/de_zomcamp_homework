# Question 1:
select * from myproject.my_nyc_tripdata.ext_green_taxi

# Question 2:
Update the WHERE clause to pickup_datetime >= CURRENT_DATE - INTERVAL '{{ var("days_back", env_var("DAYS_BACK", "30")) }}' DAY

# Question 3:
dbt run --select models/staging/+

# Question 4:
When using core, it materializes in the dataset defined in DBT_BIGQUERY_TARGET_DATASET
When using stg, it materializes in the dataset defined in DBT_BIGQUERY_STAGING_DATASET, or defaults to DBT_BIGQUERY_TARGET_DATASET
When using staging, it materializes in the dataset defined in DBT_BIGQUERY_STAGING_DATASET, or defaults to DBT_BIGQUERY_TARGET_DATASET

# Question 5:
select a.service_type as service_type, a.pickup_year_quarter as year_quarter, (a.sum_total_amount - b.sum_total_amount) / b.sum_total_amount * 100 as yoy_growth
from `ny_taxi_data.fct_taxi_trips_quarterly_revenue` a
join `ny_taxi_data.fct_taxi_trips_quarterly_revenue` b on a.pickup_quarter = b.pickup_quarter and a.service_type = b.service_type and a.pickup_year = b.pickup_year + 1
where a.pickup_year = 2020
order by yoy_growth desc

green: {best: 2020/Q1, worst: 2020/Q2}, yellow: {best: 2020/Q1, worst: 2020/Q2}

# Question 6:
select *
from `ny_taxi_data.fct_taxi_trips_monthly_fare_p95`
where pickup_year = 2020 and pickup_month = 4

green: {p97: 55.0, p95: 45.0, p90: 26.5}, yellow: {p97: 31.5, p95: 25.5, p90: 19.0}

# Question 7:
with fhv_p90 as (
  select *, rank() over(partition by pickup_year, pickup_month, pickup_zone order by p90 desc) as rank
  from ny_taxi_data.fct_fhv_monthly_zone_traveltime_p90
  where pickup_year = 2019 and pickup_month = 11
)
select *
from fhv_p90
where pickup_zone in ('Newark Airport', 'SoHo', 'Yorkville East') and rank = 2

LaGuardia Airport, Chinatown, Garment District

