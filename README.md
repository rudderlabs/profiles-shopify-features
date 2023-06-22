# About

This is Profiles library project to create user features from Shopify event stream tables created using Rudderstack SDK


# Inputs
## Raw Tables
| name | table | path |
| ---- | ----- | ---- |
| rsIdentifies | IDENTIFIES | RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.IDENTIFIES |
| rsTracks | TRACKS | RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.TRACKS |
| rsPages | PAGES | RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.PAGES |
| rsOrderCreated | ORDER_CREATED | RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.ORDER_CREATED |
| rsOrderCancelled | ORDER_CANCELLED | RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.ORDER_CANCELLED |
| rsCartUpdate | CART_UPDATE | RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.CART_UPDATE |
| rsCartCreate | CART_CREATE | RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.CART_CREATE |
## SQL Models
| name |
| ---- |
| rsSessionTable |
| rsItemsPurchasedEverSku |
| rsItemsPurchasedEverCte |
| rsItemsPurchasedEver |
| rsOrderCreatedOrderCancelled |
| rsCartLineItems |
| rsLastCartStatus |
# Identity Stitching
## user identities
| name | exclusions | sourced_from |
| ---- | ---------- | ------------ |
| user_id |  | ["rsIdentifies:user_id","rsTracks:user_id","rsPages:user_id","rsOrderCreated:user_id","rsOrderCancelled:user_id"] |
| cart_token |  | [] |
| anonymous_id | unknown, NaN | ["rsIdentifies:anonymous_id","rsTracks:anonymous_id","rsPages:anonymous_id","rsOrderCreated:anonymous_id","rsOrderCancelled:anonymous_id","rsCartUpdate:anonymous_id","rsCartCreate:anonymous_id"] |
| email | test@company.com | ["rsIdentifies:lower(email)"] |
## session identities
| name | exclusions | sourced_from |
| ---- | ---------- | ------------ |
| session_id |  | ["rsPages:concat(coalesce(anonymous_id, 'null'), coalesce(to_char(context_session_id), 'null'))"] |
| session_main_id |  | [] |
# Features
## session features
| Feature | Computed From | Description |
| ------- | ------------- | ----------- |
| anonymous_id | rsPages |  |
| session_end_time | rsPages |  |
| session_length |  |  |
| session_start_time | rsPages |  |
| user_id | rsPages |  |
## user features
| Feature | Computed From | Description |
| ------- | ------------- | ----------- |
| active_days_in_past_365_days | rsSessionTable | out of 365 days, how many days have recorded an event till date including todays date |
| active_days_in_past_7_days | rsSessionTable | out of 7 days, how many days have recorded an event till date including today |
| avg_session_length_in_sec_365_days | rsSessionTable | Average session length (in seconds) of all the user sessions that started in last 365 days |
| avg_session_length_in_sec_last_week | rsSessionTable | Average session length (in seconds) of all the user sessions that started in last 7 days |
| avg_session_length_in_sec_overall | rsSessionTable | Average session length (in seconds) of all the user sessions till date. |
| avg_transaction_value | rsOrderCreated | Total price in each transaction/Total number of transactions. |
| avg_units_per_transaction | rsOrderCreated | It shows the average units purchased in each transaction. (Total units in each transaction/Total transactions). Includes only those transactions where the total price (from column current_total_price) is greater than zero. So, the feature exclude transactions with 100% off, replacement products etc that may result in the total_price being equal to zero. |
| campaign_sources | rsIdentifies |  |
| carts_in_past_1_days | rsCartUpdate | A cart id is created for events such as create_cart,update_cart. This coln specifies how many cart ids were created in the past 1 days |
| carts_in_past_365_days | rsCartUpdate | A cart id is created for events such as create_cart,update_cart. This coln specifies how many cart ids were created in the past 365 days |
| carts_in_past_7_days | rsCartUpdate | A cart id is created for events such as create_cart,update_cart. This coln specifies how many cart ids were created in the past 7 days |
| country | rsIdentifies |  |
| currency | rsIdentifies |  |
| days_since_account_creation | rsIdentifies |  |
| days_since_first_purchase |  | Number of days since the user purchased the first product |
| days_since_last_cart_add |  | Number of days since the user has added a product to cart |
| days_since_last_purchase |  | Number of days since the user purchased the latest product |
| days_since_last_seen |  |  |
| device_manufacturer | rsIdentifies |  |
| device_name | rsIdentifies |  |
| device_type | rsIdentifies |  |
| first_name | rsIdentifies |  |
| first_seen_date | rsSessionTable | The first date on which an event has been recorded by the user |
| gross_amt_spent_in_past | rsOrderCreatedOrderCancelled | Total value of products purchased till date. |
| has_credit_card | rsOrderCreated | If the user has a credit card. |
| has_mobile_app | rsIdentifies |  |
| highest_transaction_value | rsOrderCreated | Of all the transactions done by the user, this features contains the highest transaction value. |
| is_active_on_website | rsIdentifies |  |
| is_churned_7_days |  | it specifies if there is any activity observed in the last n days. It is dependent on days_since_last_seen |
| items_purchased_ever | rsItemsPurchasedEver | The list of unique products bought by the user. |
| last_cart_status | rsOrderCreatedOrderCancelled | Status of latest cart whether it is fulfilled or paid or abandoned |
| last_cart_value_in_dollars | rsCartLineItems | The value of products added in the latest cart. |
| last_name | rsIdentifies |  |
| last_seen_date | rsSessionTable | The latest date on which an event has been recorded by the user |
| last_transaction_value | rsOrderCreated | The total value of products that are part of the last transaction. |
| median_transaction_value | rsOrderCreated | Median value of total price of all the transactions |
| net_amt_spent_in_past | rsOrderCreatedOrderCancelled | Net amount i.e. sales-refund spent by the user to date. |
| net_amt_spent_in_past_1_days | rsOrderCreatedOrderCancelled | Net amount i.e. sales-refund spent by the user in last 1 day. |
| net_amt_spent_in_past_365_days | rsOrderCreatedOrderCancelled | Net amount i.e. sales-refund spent by the user in last 365 days. |
| net_amt_spent_in_past_90_days | rsOrderCreatedOrderCancelled | Net amount i.e. sales-refund spent by the user in last 90 days. |
| products_added_in_past_1_days | rsCartLineItems | List of products added to cart by the user in last 1 days. (array with list of all product ids). It includes all purchased products plus current active cart. |
| products_added_in_past_365_days | rsCartLineItems | List of products added to cart by the user in last 365 days. (array with list of all product ids). It includes all purchased products plus current active cart. |
| products_added_in_past_7_days | rsCartLineItems | List of products added to cart by the user in last 7 days. (array with list of all product ids). It includes all purchased products plus current active cart. |
| refund_count | rsOrderCancelled | The total number of times an order has been cancelled by a user and has been refunded |
| state | rsIdentifies |  |
| total_carts | rsCartUpdate | Total carts created by the user till date. |
| total_products_added | rsCartLineItems | Total products added to cart till date. (array with list of all product ids). It includes all purchased products plus current active cart. |
| total_refund | rsOrderCancelled | Total refund for a particular user to date. |
| total_refund_in_past_1_days | rsOrderCancelled | Total refund for a particular user in last 1 day |
| total_refund_in_past_7_days | rsOrderCancelled | Total refund for a particular user in last 1 day |
| total_sessions_365_days | rsSessionTable | total number of sessions over last 365 days. |
| total_sessions_90_days | rsSessionTable | total number of sessions over last 90 days. |
| total_sessions_last_week | rsSessionTable | total number of sessions over last 7 days. |
| total_sessions_till_date | rsSessionTable | Total individual sessions created till date. |
| total_transactions | rsOrderCreated | Total number of transactions done by the user |
| transactions_in_past_1_days | rsOrderCreatedOrderCancelled | Number of transactions in last 1 day |
| transactions_in_past_365_days | rsOrderCreatedOrderCancelled | Number of transactions in last 365 day |
| transactions_in_past_90_days | rsOrderCreatedOrderCancelled | Number of transactions in last 90 day |
