


create or replace view RUDDERSTACK_TEST_DB.DATA_APPS_SIMULATED_SHOPIFY.CART_LINE_ITEMS(brand,discounted_price,gift_card,grams,id,key,line_price,original_line_price,original_price,price,product_id,properties,quantity,sku,taxable,title,total_discount,_VARIANT_,products,anonymous_id,timestamp,token) as
 

select to_char(t.value['brand']) as brand,
t.value['discounted_price']::real as discounted_price,
to_char(t.value['gift_card']) as gift_card,
t.value['grams']::real as grams,
to_char(t.value['id']) as id,
to_char(t.value['key']) as key,
t.value['line_price']::real as line_price,
t.value['original_line_price']::real as original_line_price,
t.value['original_price']::real as original_price,
t.value['price']::real as price,
to_char(t.value['product_id']) as product_id,
to_char(t.value['properties']) as properties,
t.value['quantity']::real as quantity,
to_char(t.value['sku']) as sku,
to_char(t.value['taxable']) as taxable,
to_char(t.value['title']) as title,
t.value['total_discount']::real as total_discount,
to_char(t.value['variant']) as _VARIANT_, 
products,anonymous_id,token
from (select * from cart_update ), table(flatten(parse_json(products))) t where products is not null group by token