# Write your MySQL query statement below
delete a
from Person a
join Person b
where a.email=b.email and a.id>b.id