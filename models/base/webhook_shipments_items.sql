select 
_sdc_source_key_orderid as order_id, 
lineitemkey as shopify_line_item_id,
upper(sku) as sku, 
quantity,
weight__value as weight_oz,
round(weight__value::decimal(16,2) / 16,1) as weight_lbs
from shipstation.webhook_shipments__shipmentitems 