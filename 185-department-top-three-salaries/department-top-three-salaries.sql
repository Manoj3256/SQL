# Write your MySQL query statement below
select Department,Employee,Salary
from (
    select d.name as Department,e.name as Employee,e.salary as Salary,dense_rank() over(partition by d.id order by e.salary desc) as ranks
    from Department d
    join Employee e
    on e.departmentId=d.id) r
where ranks<4
