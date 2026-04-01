# Write your MySQL query statement below
with first as (select
    a.user_id,
    a.product_id AS product_1,
    b.product_id AS product_2,
    a.quantity
FROM ProductPurchases a
CROSS JOIN ProductPurchases b
WHERE a.user_id = b.user_id
  AND a.product_id < b.product_id
)
select f.product_1 product1_id,f.product_2 product2_id,c.category product1_category,d.category product2_category,count(*) customer_count
from first f
join ProductInfo c
on f.product_1=c.product_id
join ProductInfo d
on f.product_2=d.product_id
group by product1_id,product2_id
having count(*)>2
order by customer_count desc,product1_id,product2_id