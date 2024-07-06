with selected as (
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
        is_discontinued
    from {{ ref('stg_products') }}
),

transformed as (
    select
        *,
        row_number() over (order by product_id) as product_sk
    from selected
)

select * from transformed
