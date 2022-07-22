

      create or replace transient table ANALYTICS.marts.customers  as
      (with

 __dbt__cte__int_customers_and_locations_joined as (
with

customers as (

    select * from ANALYTICS.staging.stg_tech_store__customers

),

cities as (

    select * from ANALYTICS.staging.stg_tech_store__cities

),

states as (

    select * from ANALYTICS.staging.stg_tech_store__states

),

zip_codes as (

    select * from ANALYTICS.staging.stg_tech_store__zip_codes

),

customers_and_locations_joined as (

    select
        customers.customer_id,
        cities.city_name,
        states.state_name,
        zip_codes.zip_code

    from customers

    left join cities
        on customers.city_id = cities.city_id

    left join states
        on cities.state_id = states.state_id

    left join zip_codes
        on cities.zip_code_id = zip_codes.zip_code_id

)

select * from customers_and_locations_joined
),  __dbt__cte__int_order_amounts_aggregated_by_customer as (
with

customers as (

    select * from ANALYTICS.staging.stg_tech_store__customers

),

orders as (

    select * from ANALYTICS.marts.orders

),

total_revenue_and_units_by_customer as (

    select 
        customers.customer_id,
        sum(orders.amount_in_usd) as total_revenue_in_usd,
        sum(orders.quantity) as total_quantity
    
    from orders

    left join customers
        on orders.customer_id = customers.customer_id

    group by 1

)

select * from total_revenue_and_units_by_customer
),customers as (

    select * from ANALYTICS.staging.stg_tech_store__customers

),

customers_and_locations_joined as (

    select * from __dbt__cte__int_customers_and_locations_joined

),

employees as (

    select * from ANALYTICS.staging.stg_tech_store__employees

),

order_amounts_by_customer as (

    select * from __dbt__cte__int_order_amounts_aggregated_by_customer

),

final as (

    select
        customers.customer_id,
        customers.customer_name,
        customers_and_locations_joined.city_name,
        customers_and_locations_joined.state_name,
        customers_and_locations_joined.zip_code,
        nvl(employees.full_name, 'None') as main_employee,
        employees.is_active as main_employee_is_active,
        nvl(order_amounts_by_customer.total_revenue_in_usd, 0) 
            as total_revenue_in_usd,
        nvl(order_amounts_by_customer.total_quantity, 0) as total_quantity,
        customers.created_at,
        customers.created_at_est,
        customers.updated_at,
        customers.updated_at_est,
        customers.is_active

    from customers

    left join customers_and_locations_joined
        on customers.customer_id = customers_and_locations_joined.customer_id
    
    left join employees
        on customers.main_employee_id = employees.employee_id

    left join order_amounts_by_customer
        on customers.customer_id = order_amounts_by_customer.customer_id

)

select * from final
      );
    