with

source as (

    select * from {{ source('air_boltic_data', 'raw_customer_group') }}

),

renamed as (

    select

        ----------  ids
        id as customer_group_id,

        ---------- text
        type as customer_group_type,
        name as customer_group_name,
        registry_number AS customer_group_registry_number

    from source

)

select * from renamed
