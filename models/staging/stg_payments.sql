with raw as (


select * from {{source('snowflake_source','raw_payments')}}

),

final as(
    select id as payment_id,
    order_id,
    payment_method as payment_mode,
    amount/100 as sales_amount
    from raw
)

select * from final