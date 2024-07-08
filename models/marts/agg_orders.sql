with fact_orders as (
    select
        order_date,
        product_fk,
        amount
    from {{ ref('fact_orders_details') }}
),

aggregated as (
    select
        order_date,
        product_fk,
        sum(amount) as total_amount
    from fact_orders
    group by
        order_date,
        product_fk

)

select *
from aggregated
