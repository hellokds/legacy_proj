
  create or replace  view ANALYTICS.staging.stg_tech_store__products
  
   as (
    with

products as (

    select * from raw.tech_store.product

),

final as (

    select
        id as product_id,
        name as product_name,
        category,
        price,
        currency

    from products

)

select * from final
  );
