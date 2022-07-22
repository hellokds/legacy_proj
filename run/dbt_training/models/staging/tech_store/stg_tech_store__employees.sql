
  create or replace  view ANALYTICS.staging.stg_tech_store__employees
  
   as (
    with

employees as (

    select * from raw.tech_store.employee

),

final as (

    select
        id as employee_id,
        fname as first_name,
        lname as last_name,
        concat(first_name, ' ', last_name) as full_name,
        hiredate as hired_at,
        nvl(enddate, '9999-01-01') as terminated_at,
        iff(enddate is null, true, false) as is_active

    from employees

)

select * from final
  );
