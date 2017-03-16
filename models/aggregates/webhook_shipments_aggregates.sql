select order_id,
sum(quantity) as total_quantity,
sum(weight_oz) as total_weight_oz, 
sum(weight_lbs) as total_weight_lbs
from {{ref('webhook_shipments_items')}}
group by 1