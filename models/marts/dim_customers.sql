with selected as (
    select
        /* primary key */
        customer_id,
        company_name,
        contact_name,
        contact_title,
        address,
        city,
        region,
        postal_code,
        country,
        phone,
        fax
    from {{ ref('stg_customers') }}
),

transformed as (
    select
        *,
        row_number() over (order by customer_id) as customer_sk
        -- best pratice: we can create a surrogate key via
        -- db_utils function generate_surrogate_key
    from selected
)

select * from transformed
