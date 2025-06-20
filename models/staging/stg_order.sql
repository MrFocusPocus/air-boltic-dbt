with

source as (

    select * from {{ source('air_boltic_data', 'raw_orders') }}

),

renamed as (

    select

        ----------  ids
        order_id,
        customer_id,
        trip_id,

        ---------- numerics
        price_eur,

        ---------- text
        seat_no as seat_number,
        status as order_status,

    from source

)

select * from renamed
