create or replace view RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY_FEATURES.INCREMENTAL_FEATURES_VIEW(
	ANONYMOUS_ID,
	USER_ID,
	CART_TOKEN,
	TOKEN,
	EMAIL
	VALID_AT,
	TOTAL_REFUND,
	MAX_TIMESTAMP_TRACKS,
	MAX_TIMESTAMP_PAGES,
	MAX_TIMESTAMP_BW_TRACKS_PAGES,
	DAYS_SINCE_LAST_SEEN,
	HAS_CREDIT_CARD,
	REFUND_COUNT,
    highest_transaction_value
) as 
select * exclude main_id from 
(select 
case when b.other_id_type = 'anonymous_id' then b.other_id else null end as anonymous_id, 
case when b.other_id_type = 'user_id' then b.other_id else null end as user_id, 
case when b.other_id_type = 'cart_token' then b.other_id else null end as cart_token, 
a.* from 
(select * from shopify_user_features_incremental) a left join 
(select * from shopify_user_id_stitcher) b on a.main_id = b.main_id);