with selected as (
    select
        /* primary key */
        employee_id,

        last_name,
        first_name,
        title,
        title_of_courtesy,
        birth_date,
        hire_date,
        address,
        city,
        region,
        postal_code,
        country,
        home_phone,
        extension,
        photo,
        notes,
        reports_to,
        photo_path
    from {{ ref('stg_employees') }}
),

transformed as (
    select
        *,
        row_number() over (order by employee_id) as employee_sk
    from selected
)

select * from transformed
