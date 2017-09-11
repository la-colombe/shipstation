{{
config({
    "materialized" : "table",
    "unique_key" : "shipment_id",
    "sort" : "ship_date",
    "post-hook" : [
    	"grant select on table {{this}} to group non_gl_read_only"
    	]
    })
}}

select 
s.order_id, 
shipment_id,
order_number, 
shopify_order_number,
carrier,
service,
ship_date::date,
shipping_cost,
ship_to_country,
ship_to_city,
ship_to_state,
weight_oz::decimal(16,2),
weight_lbs::decimal(16,2),
total_quantity,
total_weight_oz, 
total_weight_lbs
from {{ref('webhook_shipments')}} s
join {{ref('webhook_shipments_aggregates')}} sa on sa.order_id = s.order_id

UNION

select 
order_id::bigint, 
shipment_id::bigint,
s.order_number, 
shopify_order_number,
carrier,
service,
ship_date::date,
shipping_cost,
ship_to_country,
ship_to_city,
ship_to_state,
weight_oz::decimal(16,2),
weight_lbs::decimal(16,2),
total_quantity,
total_weight_oz, 
total_weight_lbs
from {{ref('file_shipments')}} s
join {{ref('file_shipments_aggregates')}} sa on sa.order_number = s.order_number
where s.order_number not in (select order_number from {{ref('webhook_shipments')}})