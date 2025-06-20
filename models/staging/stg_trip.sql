with

source as (

    select * from {{ source('air_boltic_data', 'raw_orders') }}

),

renamed as (

    select

        ----------  ids
        trip_id,
        airplane_id,

        ---------- numerics
        origin_city,
        destination_city,

        ---------- timestamps
        start_timestamp,
        end_timestamp

    from source

)

select * from renamed
