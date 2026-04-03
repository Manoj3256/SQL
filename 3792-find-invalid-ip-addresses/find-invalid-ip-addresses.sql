# Write your MySQL query statement below
with parts as (
    select ip,
        substring_index(ip,'.',1) as part1,
        substring_index(substring_index(ip,'.',2),'.',-1) as part2,
        substring_index(substring_index(ip,'.',3),'.',-1) as part3,
        substring_index(substring_index(ip,'.',4),'.',-1) as part4
from logs
)
select ip,
    sum(CASE when length(ip)-length((replace(ip,'.','')))!=3 then 1
    when cast(part1 as unsigned)>255 or cast(part2 as unsigned)>255 or cast(part2 as unsigned)>255 or cast(part3 as unsigned)>255 or cast(part4 as unsigned)>255 then 1 
    when part1 like '0%' or part2 like '0%' or part3 like '0%' or part4 like '0%' then 1 else 0 end) invalid_count
from parts
group by ip
having invalid_count!=0
order by invalid_count desc,ip desc
