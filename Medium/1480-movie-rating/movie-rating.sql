# Write your MySQL query statement below
(select name as results
from MovieRating m
join Users u
on u.user_id=m.user_id
group by name
order by count(m.rating) desc,name
limit 1)
union all(
select m.title as results
from MovieRating r
join Movies m
on m.movie_id=r.movie_id
join Users u
on r.user_id=u.user_id
where month(created_at)=2 and year(created_at)=2020
group by m.movie_id
order by avg(r.rating)desc ,m.title
limit 1);