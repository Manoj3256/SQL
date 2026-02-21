# Write your MySQL query statement below
select id,
CASE
    when p_id is NuLL then "Root"
    WHEN id not in (
        select p_id 
        from Tree
        where p_id is not null)
        then "Leaf"
    else "Inner"
END as type
from Tree
