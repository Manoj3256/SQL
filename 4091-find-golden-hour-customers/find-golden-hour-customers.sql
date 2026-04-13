# Write your MySQL query statement below
select customer_id,count(*) total_orders,
    round(count(case when hour(order_timestamp) between 11 and 13 or hour(order_timestamp) between 18 and 20 then 1 end)*100/count(*),0) peak_hour_percentage,
    round(avg(order_rating),2) average_rating
from restaurant_orders
group by customer_id
having count(*)>2 and avg(order_rating)>=4 and 
    count(case when hour(order_timestamp) between 11 and 13 or hour(order_timestamp) between 18 and 20 then 1 end)/count(*)*100>=60  and count(order_rating) * 100.0 / count(*) >= 50
order by average_rating desc,customer_id desc
