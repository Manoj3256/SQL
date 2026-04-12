# Write your MySQL query statement below
with expense as (
    select i.store_id,s.store_name,s.location,quantity,product_name most_exp_product,price,
    row_number() over(partition by store_id order by price desc) rn
    from inventory i
    join stores s
    on s.store_id=i.store_id
    where i.store_id in (
        select store_id
        from inventory 
        group by store_id
        having count(*)>2
    )
),
cheap as(
    select store_id,quantity,product_name cheapest_product,price,
    row_number() over(partition by store_id order by price) rn
    from inventory 
    where store_id in (
        select store_id
        from inventory 
        group by store_id
        having count(*)>2
    )
)
select e.store_id,e.store_name,e.location,e.most_exp_product,c.cheapest_product,round(c.quantity/e.quantity,2) imbalance_ratio
from expense e
join cheap c
on c.store_id=e.store_id and c.rn=1
where e.rn=1 and e.quantity<c.quantity
order by imbalance_ratio desc,store_name