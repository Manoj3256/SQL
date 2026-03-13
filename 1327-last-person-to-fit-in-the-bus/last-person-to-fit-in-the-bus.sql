# Write your MySQL query statement below
select person_name
from (
    select 
        person_id,person_name,
        sum(weight) over (order by turn) as cumm
    from Queue
) t
where cumm<1001
order by cumm desc
limit 1;