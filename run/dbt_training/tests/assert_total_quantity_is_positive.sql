select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      -- You cant order a negative amount of products.
-- This test will return records where that is not true (and cause a failure)
select
    customer_id,
    total_quantity

from ANALYTICS.marts.customers

where total_quantity < 0
      
    ) dbt_internal_test