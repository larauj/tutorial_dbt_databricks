with source as (
    select
        /* primary key */
        order_id,

        /* foreign keys */
        product_id,

        unit_price,
        quantity,
        discount
    from {{ source('northwind', 'order_details') }}
)

select * from source
