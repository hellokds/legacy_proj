select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    select *
    from ANALYTICS.marts.customers
    where 
      case 
        when date_part(month, created_at_est) between 3 and 10 -- Daylight Savings
          then created_at_est != dateadd(hour, -4, created_at)
        else created_at_est != dateadd(hour, -5, created_at)
      end

      
    ) dbt_internal_test