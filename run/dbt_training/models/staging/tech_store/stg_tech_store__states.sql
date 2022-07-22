
  create or replace  view ANALYTICS.staging.stg_tech_store__states
  
   as (
    with

states as (

    select * from raw.tech_store.state

),

final as (

    select
        id as state_id,
        name as state_name,
        code as state_code

    from states

)

select * from final
  );
