select
shopify_order_number,
count(shopify_order_number) as shipments,
sum(shipping_cost) as line_item_shipping_cost,
sum(total_weight_lbs) as total_weight_lbs
from {{ref('shipments_items')}}
group by 1