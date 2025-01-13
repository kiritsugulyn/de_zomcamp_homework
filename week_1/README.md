# Question 1

Command:
docker --help
docker build --help
docker run --help

Result:
rmi         Remove one or more images

----------------------------------------------------------------------------------------------------
# Question 2 

Command:
docker run -it --entrypoint="bash" python:3.12.8
pip --version

Result:
pip 24.3.1 from /usr/local/lib/python3.12/site-packages/pip (python 3.12)

----------------------------------------------------------------------------------------------------
# Question 3

SQL Query:
SELECT COUNT(*) FROM public.green_taxi_data
WHERE DATE(lpep_pickup_datetime) = '2019-10-18' and DATE(lpep_dropoff_datetime) = '2019-10-18'

Result:
17417

----------------------------------------------------------------------------------------------------
# Question 4

SQL Query:
SELECT DATE(lpep_pickup_datetime) pickup_date, MAX(trip_distance) max_trip_distance FROM public.green_taxi_data
GROUP BY pickup_date
ORDER BY max_trip_distance DESC
LIMIT 1

Result:
"pickup_date"	"max_trip_distance"
"2019-10-31"	515.89

----------------------------------------------------------------------------------------------------
# Question 5

SQL Query:
SELECT MIN(b."Zone")
FROM public.green_taxi_data a
JOIN public.zones b ON a."PULocationID" = b."LocationID"
WHERE DATE(lpep_pickup_datetime) = '2019-10-18'
GROUP BY a."PULocationID"
HAVING SUM(a.total_amount) > 13000

Result:
"East Harlem North"
"East Harlem South"
"Morningside Heights"

----------------------------------------------------------------------------------------------------
# Question 6

SQL Query:
SELECT c."Zone"
FROM public.green_taxi_data a
JOIN public.zones b ON a."PULocationID" = b."LocationID"
JOIN public.zones c ON a."DOLocationID" = c."LocationID"
WHERE b."Zone" = 'East Harlem North'
AND a.tip_amount = (
	SELECT MAX(public.green_taxi_data.tip_amount)
	FROM public.green_taxi_data
	JOIN public.zones ON public.green_taxi_data."PULocationID" = public.zones."LocationID"
	WHERE public.zones."Zone" = 'East Harlem North' 
)

Result:
"East New York"

----------------------------------------------------------------------------------------------------
# Question 7

Commands:
terraform init
terraform plan
terraform apply
terraform destroy

Result:
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.demo_dataset will be created
  + resource "google_bigquery_dataset" "demo_dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "kiritsugulyn_demo_dataset"
      + default_collation          = (known after apply)
      + delete_contents_on_destroy = false
      + effective_labels           = (known after apply)
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + is_case_insensitive        = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "asia-southeast1"
      + max_time_travel_hours      = (known after apply)
      + project                    = "versatile-being-445714-t8"
      + self_link                  = (known after apply)
      + storage_billing_model      = (known after apply)
      + terraform_labels           = (known after apply)

      + access (known after apply)
    }

  # google_storage_bucket.demo-bucket will be created
  + resource "google_storage_bucket" "demo-bucket" {
      + effective_labels            = (known after apply)
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "ASIA-SOUTHEAST1"
      + name                        = "kiritsugulyn_demo_bucket"
      + project                     = (known after apply)
      + public_access_prevention    = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + terraform_labels            = (known after apply)
      + uniform_bucket_level_access = (known after apply)
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type          = "AbortIncompleteMultipartUpload"
                # (1 unchanged attribute hidden)
            }
          + condition {
              + age                    = 1
              + matches_prefix         = []
              + matches_storage_class  = []
              + matches_suffix         = []
              + with_state             = (known after apply)
                # (3 unchanged attributes hidden)
            }
        }

      + versioning (known after apply)

      + website (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.demo_dataset: Creating...
google_storage_bucket.demo-bucket: Creating...
google_bigquery_dataset.demo_dataset: Creation complete after 2s [id=projects/versatile-being-445714-t8/datasets/kiritsugulyn_demo_dataset]
google_storage_bucket.demo-bucket: Creation complete after 3s [id=kiritsugulyn_demo_bucket]
