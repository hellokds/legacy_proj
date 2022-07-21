with

transactions as (

    select * from {{ source('payment_app', 'transactions') }}

),

final as (

    select
        id as transaction_id,
        date as created_at,
        payload

    from transactions

)

select * from final