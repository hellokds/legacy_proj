
  create or replace  view ANALYTICS.staging.stg_tech_store__zip_codes
  
   as (
    with

zip_codes as (

    select * from raw.tech_store.zip

),

final as (

    select
        id as zip_code_id,
        code as zip_code

    from zip_codes

)

select * from final
  );
