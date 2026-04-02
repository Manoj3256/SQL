# Write your MySQL query statement below
select e.employee_id,e.name,count(*) reports_count,round(avg(e2.age)) average_age
from Employees e
join Employees e2
on e.employee_id=e2.reports_to
group by e.employee_id 
order by employee_id