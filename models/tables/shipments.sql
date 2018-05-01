{{
config({
    "materialized" : "table",
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
join {{ref('shipment_aggregates')}} sa on sa.order_id = s.order_id