
  create or replace  view ANALYTICS.staging.stg_tech_store__orders
  
   as (
    with

orders as (

    select * from raw.tech_store.orders

),

final as (

    select
        id as order_id,
        productid as product_id,
        quantity,
        userid as employee_id,
        customerid as customer_id,
        datetime as created_at,
        convert_timezone('UTC', 'America/New_York', datetime) as created_at_est

    from orders

)

select * from final
  );
