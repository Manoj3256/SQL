# Write your MySQL query statement below
with first as (
    select 
        employee_id,
        date_sub(meeting_date, interval weekday(meeting_date) day)  week_start,
        sum(duration_hours) total_hours
    from meetings
    group by employee_id, week_start
    having total_hours>20 
)
select f.employee_id,e.employee_name,e.department,count(total_hours) meeting_heavy_weeks
from first f
left join employees e
on f.employee_id=e.employee_id
group by employee_id
having count(*)>1
order by meeting_heavy_weeks desc,employee_name