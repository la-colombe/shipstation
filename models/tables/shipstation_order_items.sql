{{
config({
    "materialized" : "table",
    "sort" : "modified_at",
    "post-hook" : [
      "grant select on table {{this}} to group non_gl_read_only"
      ]
    })
}}

select
--IDs
_sdc_source_key_orderid as order_id,
orderitemid as order_item_id,
productid as product_id,
lineitemkey as line_item_key,
--product descriptions
name,
sku,
quantity,
unitprice as unit_price,
warehouselocation as warehouse_location,
--timestamps
createdate::date as created_at,
modifydate::date as modified_at
from shipstation.orders__items