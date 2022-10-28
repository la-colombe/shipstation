{{
config({
    "materialized" : "table",
    "sort" : "modified_at",
    "post-hook" : [
      "grant select on table {{this}} to group non_gl_read_only"
      ]
    })
}}

--Old tap

select
  --IDs
  orderkey as order_key,
  orderid as order_id,
  ordernumber as order_number,
  '1' || split_part(ordernumber,'-',1) as shopify_order_number,
  advancedoptions__customfield3 as shopify_fulfillment_id,
  case advancedoptions__warehouseid
    when 14561 then 'Tioga'
    when 127295 then 'Michigan'
    when 139016 then 'RLS Warehouse'
    when 163472 then 'Frogtown'
    else advancedoptions__warehouseid::char(8)
  end as ship_from_warehouse,
  --Status
  orderstatus as order_status,
  shipto__addressverified as address_verification_status,
  --Timestamps
  createdate::timestamp as created_at,
  modifydate::timestamp as modified_at
from shipstation.orders
where createdate::date < '2022-09-20'

union all 

--Meltano tap

select
  --IDs
  orderkey as order_key,
  orderid as order_id,
  ordernumber as order_number,
  '1' || split_part(ordernumber,'-',1) as shopify_order_number,
  advancedoptions__customfield3 as shopify_fulfillment_id,
  case advancedoptions__warehouseid
    when 14561 then 'Tioga'
    when 127295 then 'Michigan'
    when 139016 then 'RLS Warehouse'
    when 163472 then 'Frogtown'
    else advancedoptions__warehouseid::char(8)
  end as ship_from_warehouse,
  --Status
  orderstatus as order_status,
  shipto__addressverified as address_verification_status,
  --Timestamps
  createdate::timestamp as created_at,
  modifydate::timestamp as modified_at
from meltano_shipstation.orders
where createdate::date >= '2022-09-20'