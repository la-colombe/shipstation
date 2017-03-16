select 
order_id, 
shipment_id,
ordernumber as order_number, 
shopify_order_number,
carrier,
service,
ship_date,
shipping_cost,
ship_to_country,
ship_to_city,
ship_to_state,
weight_oz,
weight_lbs,
total_quantity,
total_weight_oz, 
total_weight_lbs
from {{ref('webhook_shipments')}} s
join {{ref('webhook_shipments_aggregates')}} sa on sa.order_id = s.order_id

UNION

select 
order_id, 
shipment_id,
ordernumber as order_number, 
shopify_order_number,
carrier,
service,
ship_date,
shipping_cost,
ship_to_country,
ship_to_city,
ship_to_state,
weight_oz,
weight_lbs,
total_quantity,
total_weight_oz, 
total_weight_lbs
from {{ref('file_shipments')}} s
join {{ref('file_shipments_aggregates')}} sa on sa.order_number = s.order_number