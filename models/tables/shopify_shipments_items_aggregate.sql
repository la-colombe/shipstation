select
shopify_line_item_id,
count(shopify_line_item_id) as shipments,
sum(line_item_shipping_cost) as line_item_shipping_cost,
sum(weight_lbs) as total_weight_lbs,
max(carrier) as carrier,
max(service) as service,
min(ship_date) as first_ship_date,
max(ship_from_warehouse) as ship_from_warehouse
from {{ref('shipment_items')}}
group by 1