# Write your MySQL query statement below
with first as (
    select customer_id,
        (sum(case when transaction_type!='purchase' then 1 else 0 end)/count(*))*100 refund_rate,
        datediff(max(transaction_date),min(transaction_date)) active
    from customer_transactions
    group by customer_id
    having count(transaction_id)>2 
)
select customer_id
from first
where refund_rate<20 and active>29
order by customer_id
