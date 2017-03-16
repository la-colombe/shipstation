select 
si.order_id, 
si.shopify_line_item_id,
s.order_number, 
s.shopify_order_number,
sku, 
quantity,
si.weight_oz,
si.weight_lbs,
(shipping_cost / total_quantity) * quantity as line_item_shipping_cost
from {{ref('webhook_shipments_items')}} si
join {{ref('shipments')}} s on s.order_id = si.order_id

UNION

select 
si.order_id, 
si.shopify_line_item_id,
si.order_number, 
si.shopify_order_number,
sku, 
quantity,
si.weight_oz,
si.weight_lbs,
(shipping_cost / total_quantity) * quantity as line_item_shipping_cost
from {{ref('file_shipments_items')}} si
join {{ref('shipments')}} s on s.order_number = si.order_number