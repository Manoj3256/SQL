select t.patient_id, p.patient_name, p.age,
    datediff(
        min(case when t.result='Negative' 
            and t.test_date > (
                select min(t2.test_date) 
                from covid_tests t2 
                where t2.patient_id = t.patient_id 
                and t2.result = 'Positive'
            ) 
        then t.test_date end),
        min(case when t.result='Positive' then t.test_date end)
    ) as recovery_time
from covid_tests t
join patients p on p.patient_id = t.patient_id
where t.patient_id in (
    select patient_id
    from covid_tests
    group by patient_id
    having sum(case when result='Positive' then 1 else 0 end) > 0
       and sum(case when result='Negative' then 1 else 0 end) > 0
)
group by t.patient_id, p.patient_name, p.age
having recovery_time > 0
order by recovery_time, p.patient_name;