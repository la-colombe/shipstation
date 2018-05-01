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
si.order_id, 
si.shopify_line_item_id,
s.order_number, 
s.shopify_order_number,
s.ship_date,
sku, 
quantity,
carrier,
service,
si.weight_oz::decimal(16,2),
si.weight_lbs::decimal(16,2),
(shipping_cost::decimal(16,2) / total_quantity) * quantity as line_item_shipping_cost
from {{ref('webhook_shipment_items')}} si
join {{ref('shipments')}} s on s.order_id = si.order_id