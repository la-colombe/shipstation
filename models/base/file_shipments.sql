select 
NULL as order_id, 
NULL as shipment_id,
order_number, 
'1' || split_part(order_number, '-',1) as shopify_order_number,
ship_to_country as ship_to_country,
NULL as ship_to_city,
ship_to_state as ship_to_state,
NULL as weight_oz,
NULL as weight_lbs,
max(carrier) as carrier,
max(service) as service,
max(ship_date) as ship_date,
sum(shipping_cost) as shipping_cost
from file_uploads.shipstation_shipments
group by 1,2,3,4,5,6,7,8,9