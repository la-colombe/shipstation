{{
config({
    "materialized" : "table",
    "sort" : "most_recent_event",
    "post-hook" : [
      "grant select on table {{this}} to group non_gl_read_only"
      ]
    })
}}

select
  tracking_number,
  carrier,
  updated_at,
  mail_class,
  most_recent_event,
  package_status,
  full_package_status
from {{ref('ups_tracking')}}

union all

select
  tracking_number,
  carrier,
  updated_at,
  mail_class,
  most_recent_event,
  package_status,
  full_package_status
from {{ref('usps_tracking')}}