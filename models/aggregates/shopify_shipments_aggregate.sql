select
shopify_order_number,
count(shopify_order_number) as shipments,
sum(shipping_cost) as shipping_cost,
sum(weight_lbs) as package_weight
from {{ref('shipments')}}
group by 1