with raw as (


select * from {{source('snowflake_source','raw_customers')}}

),

final as(
    select id as customer_id,
    first_name,
    last_name
    from raw
)

select * from final