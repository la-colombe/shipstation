{{
config({
    "materialized" : "table",
    "sort" : "ship_date",
    "post-hook" : [
    	"grant select on table {{this}} to group non_gl_read_only"
    	]
    })
}}

select 
order_id, 
shipment_id,
order_number, 
shopify_order_number,
case carrier
    when 'ups' then 'UPS'
    when 'stamps_com' then 'USPS'
    else carrier
end as carrier,
service,
tracking_number,
ship_date,
shipping_cost,
ship_to_country,
ship_to_city,
ship_to_state,
warehouse_id,
case warehouse_id
	when 14561 then 'Tioga'
	when 127295 then 'Michigan'
	when 139016 then 'RLS Warehouse'
	when 163472 then 'Frogtown'
    when 849266 then 'Wheatsheaf'
	else warehouse_id::char(8)
end ship_from_warehouse,
voided,
weight_oz,
weight_lbs,
shipping_cost / weight_lbs as shipping_cost_per_lb
from {{ref('shipstation_shipments')}} s