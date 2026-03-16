# Write your MySQL query statement below
select p.product_name,sum(o.unit) as unit
from Orders o
join Products p
on p.product_id=o.product_id
where month(order_date)=2 and year(order_date)=2020
group by product_name
having sum(o.unit)>99;