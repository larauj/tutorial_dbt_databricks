with source as (
    select
        /* primary key */
        shipper_id,

        company_name,
        phone
    from {{ source('northwind', 'shippers') }}
)

select * from source
