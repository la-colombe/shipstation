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
si.shipment_id,
si.shopify_line_item_id,
s.order_number, 
s.shopify_order_number,
s.ship_date,
s.warehouse_id,
s.ship_from_warehouse,
sku, 
quantity,
carrier,
service,
si.weight_oz,
si.weight_lbs,
shipping_cost_per_lb * si.weight_lbs as line_item_shipping_cost
from {{ref('shipstation_shipment_items')}} si
join {{ref('shipments')}} s on s.shipment_id = si.shipment_id