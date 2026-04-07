with firsthalf as (
    select d.driver_id, d.driver_name,
           avg(distance_km / fuel_consumed) as first_half_avg  
    from trips t
    join drivers d on d.driver_id = t.driver_id
    where month(trip_date) between 1 and 6
    group by d.driver_id, d.driver_name
),
secondhalf as (
    select d.driver_id,
        avg(distance_km / fuel_consumed) as second_half_avg  
    from trips t
    join drivers d on d.driver_id = t.driver_id
    where month(trip_date) between 7 and 12
    group by d.driver_id
)
select f.driver_id, f.driver_name,
    round(f.first_half_avg,2) as first_half_avg,
    round(s.second_half_avg,2) as second_half_avg,
    round(s.second_half_avg-f.first_half_avg, 2) efficiency_improvement
from firsthalf f
inner join secondhalf s
on f.driver_id = s.driver_id
where round(s.second_half_avg-f.first_half_avg, 2)>0
order by efficiency_improvement desc, driver_name;