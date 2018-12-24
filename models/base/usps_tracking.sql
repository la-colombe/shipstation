select
  id as tracking_number,
  'USPS' as carrier,
  _sdc_received_at as updated_at,
  class as mail_class,
  to_timestamp(
      split_part(tracksummary__eventdate, ' ',1) || ' '
      || lpad(replace(split_part(tracksummary__eventdate, ' ',2),',',''),2,'00') || ' '
      || split_part(tracksummary__eventdate, ' ',3) || ' '
      || lpad(split_part(tracksummary__eventtime,':',1),2,'00')  || ':'
      || left(split_part(tracksummary__eventtime,':',2),2) || ' '
      || split_part(tracksummary__eventtime,' ',2), 'Month DD YYYY HH:MI am')::timestamp as most_recent_event,
  case
    when statuscategory in ('Delivered','Delivered to Agent','Delivery Attempt','Available for Pickup') then 'Delivered'
    when statuscategory in ('In Transit','Out for Delivery') then 'In-Transit'
    when statuscategory in ('Alert') then 'Exception'
    when statuscategory in ('Pre-Shipment') then 'Not Yet Scanned'
    else 'Other'
  end as package_status,
  statuscategory as full_package_status
from shipstation.usps_tracking