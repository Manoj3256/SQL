with ranked as (
    select 
        e.employee_id,e.name,p.rating,p.review_date,
        lag(p.rating, 1) over (partition by e.employee_id order by p.review_date) prev1,
        lag(p.rating, 2) over (partition by e.employee_id order by p.review_date) prev2,
        row_number() over (partition by e.employee_id order by p.review_date desc) rn
    from employees e
    join performance_reviews p
     on p.employee_id =e.employee_id
)
select employee_id,name,(rating-prev2) improvement_score
from ranked
where rn = 1 and prev1 is not null and prev2 is not null and rating > prev1 and prev1 > prev2
order by improvement_score desc, name;