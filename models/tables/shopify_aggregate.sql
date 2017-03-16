select
shopify_order_number,
count(shopify_order_number) as shipments,
sum(shipping_cost) as shipping_cost,
sum(total_weight_lbs) as total_weight_lbs
from {{ref('shipments')}}
group by 1