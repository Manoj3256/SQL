# Write your MySQL query statement below
with temp as(
    select *,row_number() over (order by id) as ran
    from Stadium
    where people >99
),
ranMinus as(
    select *,id-ran as ranM
    from temp
)
select id,visit_date,people
from ranMinus
where ranM in(
    select ranM
    from ranMinus
    group by ranM
    having count(*)>2)
order by visit_date