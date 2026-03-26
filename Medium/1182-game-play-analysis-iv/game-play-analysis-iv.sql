# Write your MySQL query statement below
with ran as (
    select player_id,event_date,
    min(event_date) over (partition by player_id) as prev_date
    from Activity
)
select round(count(distinct case when event_date=date_add(prev_date,interval 1 day) then player_id end)/count(distinct player_id),2) as fraction
from ran;