with customers as (
    select * from {{ref('stg_customers')}}
),
orders as (
    select * from {{ref('stg_orders')}}
),
payments as (
    select * from {{ref('stg_payments')}}
),
customer_level_details as (
    select c.first_name,c.last_name,c.customer_id,min(o.order_date) as first_order,
    max(o.order_date) as most_recent_order
    from customers c
    left join orders o
    on c.customer_id = o.customer_id
    group by c.first_name,c.last_name,c.customer_id
),

payment_details as (
    select o.customer_id,sum(p.sales_amount) as amount
    from payments p
    left join orders o
    on p.order_id = o.order_id
    group by o.customer_id
),

final as (
    select cl.customer_id,cl.first_name,cl.last_name,cl.first_order,cl.most_recent_order,pd.amount 
    from customer_level_details cl
    inner join payment_details pd
    on cl.customer_id = pd.customer_id
    
)

select * from final
order by customer_id

