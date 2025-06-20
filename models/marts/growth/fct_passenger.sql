with order as (
    select
        order_id,
        passenger_id,
        trip_id,
        price_eur,
        order_status
    from {{ ref('stg_order') }}
),

trip as (
    select
        trip_id,
        origin_city,
        destination_city,
        airplane_id,
        start_timestamp,
        end_timestamp
    from {{ ref('stg_trip') }}
),

base as (
    select
        o.passenger_id,
        t.start_timestamp::date as aggregation_date,
        datediff('minute', t.start_timestamp, t.end_timestamp) as flight_duration_minutes,
        o.order_id,
        t.trip_id,
        o.price_eur,
        o.order_status
    from trip t
    left join order o
        on t.trip_id = o.trip_id
)

select
    b.passenger_id,
    datetrunc('month', b.aggregation_date) as aggregation_date,
    'MONTHLY' as aggregation_level,
    sum(case when b.order_status = 'BOOKED' then 1 else 0 end) as booked_trip_count,
    sum(case when b.order_status = 'BOOKED' then b.price_eur else 0 end) as booked_spend_eur,
    sum(case when b.order_status = 'FINISHED' then 1 else 0 end) as finished_trip_count,
    sum(case when b.order_status = 'FINISHED' then b.price_eur else 0 end) as finished_spend_eur,
    sum(case when b.order_status = 'CANCELLED' then 1 else 0 end) as cancelled_trip_count,
    sum(case when b.order_status = 'CANCELLED' then b.price_eur else 0 end) as cancelled_spend_eur,
    avg(b.flight_duration_minutes) as mean_flight_duration
    
from base b
group by
    b.passenger_id,
    datetrunc('month', b.aggregation_date),
    aggregation_level
