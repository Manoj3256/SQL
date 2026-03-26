# Write your MySQL query statement below
select b.book_id,b.title,b.author,b.genre,b.pages,max(session_rating)-min(session_rating) as rating_spread,round(sum(case when session_rating!=3 then 1 else 0 end)/count(*),2) as polarization_score
from books b
join reading_sessions r
on b.book_id=r.book_id
group by book_id
having count(session_id)>4 and sum(case when session_rating>3 then 1 else 0 end)>0 and sum(case when session_rating<3 then 1 else 0 end)>0 and polarization_score>=0.6
order by polarization_score desc,title desc