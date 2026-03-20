# Write your MySQL query statement below
select t.request_at as Day,round(sum(t.status!='completed')/count(*),2) as 'Cancellation Rate'
from Trips t
join Users c
on c.users_id=t.client_id 
join Users d
on d.users_id=t.driver_id
where c.banned!='Yes' and d.banned!='Yes' and t.request_at between "2013-10-01" and "2013-10-03"
group by Day