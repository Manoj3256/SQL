# Write your MySQL query statement below
with cte1 as(
    select departmentId,max(salary) as max_salary
    from Employee
    group by departmentId
)
select d.name as Department,e.name as Employee,a.max_salary as Salary
from Employee e
join cte1 a
on a.departmentId=e.departmentId and a.max_salary =e.salary
join Department d 
on d.id=e.departmentId;