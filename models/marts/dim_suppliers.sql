with selected as (
    select
        /* primary key */
        supplier_id,

        company_name,
        contact_name,
        contact_title,
        address,
        city,
        region,
        postal_code,
        country,
        phone,
        fax,
        homepage
    from {{ ref('stg_suppliers') }}
),

transformed as (
    select
        *,
        row_number() over (order by supplier_id) as supplier_sk
    from selected
)

select * from transformed
