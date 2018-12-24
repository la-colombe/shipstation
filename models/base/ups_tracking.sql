select
  id as tracking_number,
  'UPS' as carrier,
  _sdc_received_at as updated_at,
  service__description as mail_class,
  to_timestamp(package__activity__date || package__activity__time, 'YYYYMMDDHH24MISS')::timestamp as most_recent_event,
  case package__activity__status__type
    when 'D' then 'Delivered'
    when 'I' then 'In-Transit'
    when 'X' then 'Exception'
    when 'M' then 'Not Yet Scanned'
  end as package_status,
  package__activity__status__description as full_package_status
from shipstation.ups_tracking