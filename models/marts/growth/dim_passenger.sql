select
    pa.passenger_id,
    pa.customer_name,
    pa.customer_group_id,
    pa.email,
    pa.customer_phone_number,
    pa.customer_group_type
    pa.customer_group_name,
    pa.customer_group_registry_number

from
    {{ ref('int_consolidate_passenger_data') }} AS pa