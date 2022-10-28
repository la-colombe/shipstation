--Old Tap

select
	si.lineitemkey as shopify_line_item_id,
	si._sdc_source_key_shipmentid as shipment_id,
	upper(si.sku) as sku,
	si.quantity,
	si.weight__value::decimal(16,2) as weight_oz,
	round(si.weight__value::decimal(16,2) / 16,1) as weight_lbs
from shipstation.shipments__shipmentitems si
join shipstation.shipments s on si._sdc_source_key_shipmentid = s.shipmentid
where s.createdate::date < '2022-09-20'

union all

--Meltano Tap
select
	si.lineitemkey as shopify_line_item_id,
	si._sdc_source_key_shipmentid as shipment_id,
	upper(si.sku) as sku,
	si.quantity,
	si.weight__value::decimal(16,2) as weight_oz,
	round(si.weight__value::decimal(16,2) / 16,1) as weight_lbs
from shipstation.shipments__shipmentitems si
join shipstation.shipments s on si._sdc_source_key_shipmentid = s.shipmentid
where s.createdate::date >= '2022-09-20'