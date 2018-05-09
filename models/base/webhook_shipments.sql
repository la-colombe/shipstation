select 
orderid as order_id, 
shipmentid as shipment_id,
ordernumber as order_number, 
'1' || split_part(ordernumber, '-',1) as shopify_order_number,
carriercode as carrier,
servicecode as service,
shipdate as ship_date,
shipmentcost as shipping_cost,
shipto__country as ship_to_country,
shipto__city as ship_to_city,
shipto__state as ship_to_state,
weight__value as weight_oz,
round(weight__value::decimal(16,2) / 16,1) as weight_lbs
from shipstation.webhook_shipments 
where not voided