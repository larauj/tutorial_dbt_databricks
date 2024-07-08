{% set countries = ["France", "USA", "Germany"] %}


with fact_orders as (
    select
        ship_country,
        amount
    from {{ ref('fact_orders_details') }}
),

aggregated as (
    select
        {% for country in countries %}
            sum(case
                when ship_country = '{{ country }}' then amount
                else 0
            end) as {{ country }}_amount,
        {% endfor %}
        sum(amount) as total_amount
    from fact_orders
)

select *
from aggregated
