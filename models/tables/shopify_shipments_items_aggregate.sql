select
shopify_line_item_id,
count(shopify_line_item_id) as shipments,
sum(line_item_shipping_cost) as line_item_shipping_cost,
sum(weight_lbs) as total_weight_lbs,
max(carrier) as carrier,
max(service) as service
from {{ref('shipments_items')}}
group by 1