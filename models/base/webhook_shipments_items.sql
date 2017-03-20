select 
lineitemkey as shopify_line_item_id,
_sdc_source_key_orderid as order_id, 
upper(sku) as sku, 
SUM(quantity),
SUM(weight__value) as weight_oz,
round(SUM(weight__value)::decimal(16,2) / 16,1) as weight_lbs
from shipstation.webhook_shipments__shipmentitems 
group by 1,2,3