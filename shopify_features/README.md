# PB

## How to Use

After installing PB and configuring your connections profile, you need to change inputs.yaml with names of your source tables. Once that is done, please mention their names as edge_sources in profiles.yaml and define specs for creating ID stitcher / feature table. 

Use this command to validate that your project shall be able to access the warehouse specified in connections profile and create material objects there.

```shell script
pb validate access
```

You can use this command to generate SQL, which will also tell you in case there are syntax errors in your model YAML file.

```shell script
pb compile
```

If there are no errors, use this command to create the output table on the warehouse.

```shell script
pb run
```

## SQL queries for data analysis.

Let's assume that the materialized table created by PB was named MATERIAL_USER_STITCHING_26f16d24_29 , inside schema RUDDER_360 of database RUDDER_EVENTS_PRODUCTION. The materialized table name will change with each run, the view USER_STITCHING will point to the most recently created one.

Total number of records:
```sql
select count(*) from RUDDER_EVENTS_PRODUCTION.RUDDER_360.USER_STITCHING;
```

Total number of distinct records (main_id):
```sql
select count(distinct main_id) from RUDDER_EVENTS_PRODUCTION.RUDDER_360.USER_STITCHING;
```

Max mappings to a single canonical ID:
```sql
select main_id, count(other_id) as "CNT"
from RUDDER_EVENTS_PRODUCTION.RUDDER_360.USER_STITCHING
group by main_id
order by CNT DESC;
```

Say there was a canonical ID '0013d4fa-fdf7-5736-85d1-063378251398' that had more than 1000 mappings. So to check more on other ID types and their count:
```sql
select count (distinct other_id) as "OTHER_ID_COUNT", other_id_type from RUDDER_EVENTS_PRODUCTION.RUDDER_360.USER_STITCHING
where main_id = '0013d4fa-fdf7-5736-85d1-063378251398'
group by other_id_type;
```

## Know More
See <a href="https://rudderlabs.github.io/pywht">public docs</a> for more information on using PB.


There are a few views in the ```views/``` directory. They are supposed to be created in the warehouse before the project is run. Each sql file in the views directory correspond to one view. Run them in the same schema where your input tables exist.

1. Install Profiles tool, from the link above
2. Setup connection to your warehouse, following the instructions from the documentation
3. cd to this directory where the git repo is cloned
4. Do ```pb run```
Following features get created in the table ```shopify_user_features``` in the schema specified in pb connection (in step 2 above)

## Working features
- days_since_last_seen
- is_churned_1_days
- is_churned_7_days
- days_since_last_cart_add
- total_refund
- refund_count
- days_since_last_purchase
- days_since_first_purchase
- has_credit_card
- avg_units_per_transaction
- avg_transaction_value
- highest_transaction_value
- median_transaction_value
- total_transactions
- total_refund_in_past_1_days
- total_refund_in_past_7_days
- email_id
- days_since_account_creation
- has_mobile_app
- state
- country
- first_name
- last_name
- currency
- device_type
 - device_name
 - campaign_sources
 - is_active_on_website
- device_manufacturer
 - active_days_in_past_1_days
- active_days_in_past_7_days
- active_days_in_past_365_days
 - total_sessions_till_date
 - total_sessions_last_week
- avg_session_length_overall
 - avg_session_length_last_week
  - first_seen_date
- last_seen_date
- carts_in_past_1_days
- carts_in_past_7_days
- carts_in_past_365_days
 - total_carts
 - last_transaction_value
- total_products_added
- products_added_in_past_1_days
- products_added_in_past_365_days
- last_cart_value_in_dollars (does not consider if products are removed)


