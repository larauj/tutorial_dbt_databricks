with
validation as (
    select sum(quantity) as sum_quantity
    from {{ ref('fact_orders_details') }}
    where order_date between '1998-03-01' and '1998-03-31'
),

expected as (
    select sum(quantity) as sum_expected
    from {{ ref('stg_orders_details') }}
    where order_date between '1998-03-01' and '1998-03-31'
)

select * from validation
where sum_quantity != (select * from expected)
