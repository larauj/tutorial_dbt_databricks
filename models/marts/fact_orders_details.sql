with
customers as (
    select * from {{ ref('dim_customers') }}
),

employees as (
    select * from {{ ref('dim_employees') }}
),

products as (
    select * from {{ ref('dim_products') }}
),

shippers as (
    select * from {{ ref('dim_shippers') }}
),

orders_with_sk as (
    select
        orders.order_id,
        employees.employee_sk as employee_fk,
        customers.customer_sk as customer_fk,
        shippers.shipper_sk as shipper_fk,
        orders.ship_region,
        orders.shipped_date,
        orders.ship_country,
        orders.ship_name,
        orders.order_date,
        orders.ship_postal_code,
        orders.ship_city,
        orders.ship_address,
        orders.required_date,
        orders.freight
    from {{ ref('stg_orders') }} as orders
    left join employees as employees
        on orders.employee_id = employees.employee_id
    left join customers as customers
        on orders.customer_id = customers.customer_id
    left join shippers as shippers
        on orders.shipper_id = shippers.shipper_id
),

order_detail_with_sk as (
    select
        order_detail.order_id,
        order_detail.product_id,
        products.product_sk as product_fk,
        order_detail.unit_price,
        order_detail.quantity,
        order_detail.discount
    from {{ ref('stg_orders_details') }} as order_detail
    left join products
        on order_detail.product_id = products.product_id
),

final as (
    select
        order_detail_with_sk.order_id,
        orders_with_sk.employee_fk,
        orders_with_sk.customer_fk,
        orders_with_sk.shipper_fk,
        orders_with_sk.ship_region,
        orders_with_sk.shipped_date,
        orders_with_sk.ship_country,
        orders_with_sk.ship_name,
        orders_with_sk.order_date,
        orders_with_sk.ship_postal_code,
        orders_with_sk.ship_city,
        orders_with_sk.ship_address,
        orders_with_sk.required_date,
        orders_with_sk.freight,
        order_detail_with_sk.product_fk,
        order_detail_with_sk.unit_price,
        order_detail_with_sk.quantity,
        order_detail_with_sk.discount
    from orders_with_sk
    left join order_detail_with_sk
        on orders_with_sk.order_id = order_detail_with_sk.order_id
)

select * from final
