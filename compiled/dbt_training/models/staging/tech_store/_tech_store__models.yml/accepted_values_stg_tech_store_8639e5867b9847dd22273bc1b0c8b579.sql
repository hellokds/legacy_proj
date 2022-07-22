
    
    

with all_values as (

    select
        category as value_field,
        count(*) as n_records

    from ANALYTICS.staging.stg_tech_store__products
    group by category

)

select *
from all_values
where value_field not in (
    'Audio','Computers','Accessories','Software','Video'
)


