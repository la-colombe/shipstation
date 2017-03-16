select 
NULL as order_id, 
NULL as shopify_line_item_id,
order_number, 
'1' || split_part(order_number, '-',1) as shopify_order_number,
upper(sku) as sku, 
quantity,
weight as weight_oz,
round(weight::decimal(16,2) / 16,1) as weight_lbs
from file_uploads.shipstation_shipments__items 