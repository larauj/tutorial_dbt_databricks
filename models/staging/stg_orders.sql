with source as (
    select
        /* primary key */
        order_id,

        /* foreign keys */
        employee_id,
        customer_id,

        ship_region,
        shipped_date,
        ship_country,
        ship_name,
        order_date,
        ship_postal_code,
        ship_city,
        ship_via as shipper_id,
        ship_address,
        required_date::timestamp as required_date,
        freight
    from {{ source('northwind', 'orders') }}
)

select * from source
