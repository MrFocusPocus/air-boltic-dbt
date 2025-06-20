with

stg_customer as (
    select * from {{ ref('stg_customer') }}
),

stg_customer_group as (
    select * from {{ ref('stg_customer_group') }}
)

select
    c.customer_id as passenger_id,
    c.customer_name as passenger_name,
    c.customer_group_id,
    c.customer_email,
    c.customer_phone_number,
    cg.customer_group_type,
    cg.customer_group_name,
    cg.customer_group_registry_number

from
    stg_customer c
    join stg_customer_group cg
        on c.customer_group_id = cg.customer_group_id
