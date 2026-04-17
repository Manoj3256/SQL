# Write your MySQL query statement below
select l.book_id,l.title,l.author,l.genre,l.publication_year,count(case when return_date is null then 1 end) current_borrowers
from borrowing_records b
join library_books l
on l.book_id=b.book_id
group by l.book_id,total_copies
having l.total_copies-count(case when return_date is null then 1 end)=0
order by count(case when return_date is null then 1 end) desc,title