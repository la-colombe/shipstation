--Original Tap

select
	orderid as order_id,
	shipmentid as shipment_id,
	ordernumber as order_number,
	'1' || split_part(ordernumber, '-',1) as shopify_order_number,
	carriercode as carrier,
	servicecode as service,
	trackingnumber as tracking_number,
	shipdate::date as ship_date,
	createdate::date as create_date,
	shipmentcost::decimal(16,2) as shipping_cost,
	shipto__country as ship_to_country,
	shipto__city as ship_to_city,
	shipto__state as ship_to_state,
	warehouseid as warehouse_id,
	voided,
	case weight__value
		when 0 then null
		else weight__value::decimal(16,2) 
	end as weight_oz,
	round(weight_oz / 16,3) as weight_lbs
from shipstation.shipments
where createdate::date < '2022-09-20'

union all 

--Meltano Tap

select
	orderid as order_id,
	shipmentid as shipment_id,
	ordernumber as order_number,
	'1' || split_part(ordernumber, '-',1) as shopify_order_number,
	carriercode as carrier,
	servicecode as service,
	trackingnumber as tracking_number,
	shipdate::date as ship_date,
	createdate::date as create_date,
	shipmentcost::decimal(16,2) as shipping_cost,
	shipto__country as ship_to_country,
	shipto__city as ship_to_city,
	shipto__state as ship_to_state,
	warehouseid as warehouse_id,
	voided,
	case weight__value
		when 0 then null
		else weight__value::decimal(16,2) 
	end as weight_oz,
	round(weight_oz / 16,3) as weight_lbs
from meltano_shipstation.shipments
where createdate::date >= '2022-09-20'

