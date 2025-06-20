with

source as (

    select * from {{ source('air_boltic_data', 'raw_customer') }}

),

renamed as (

    select

        ----------  ids
        customer_id,

        ---------- text
        name as customer_name,
        customer_group_id,
        email as customer_email,
        phone_number as customer_phone_number

    from source

)

select * from renamed
