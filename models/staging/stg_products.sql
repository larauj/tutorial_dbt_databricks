with source as (
    select
        /* primary key */
        product_id,

        /* foreign keys */
        category_id,
        supplier_id,

        product_name,
        unit_price,
        units_in_stock,
        units_on_order,
        quantity_per_unit,
        reorder_level,
        case
            when discontinued = 0 then 'false'
            else 'true'
        end as is_discontinued
    from {{ source('northwind', 'products') }}
)

select * from source
