select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

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



      
    ) dbt_internal_test