select
lineitemkey as shopify_line_item_id,
_sdc_source_key_shipmentid as shipment_id,
upper(sku) as sku,
quantity,
weight__value::decimal(16,2) as weight_oz,
round(weight__value::decimal(16,2) / 16,1) as weight_lbs
from shipstation.shipments__shipmentitems