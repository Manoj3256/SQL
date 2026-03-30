with sea as (
    select 
        case 
            when month(sale_date) in (12,1,2) then 'Winter'
            when month(sale_date) in (3,4,5) then 'Spring'
            when month(sale_date) in (6,7,8) then 'Summer'
            when month(sale_date) in (9,10,11) then 'Fall'
        end as season,
        p.category,
        sum(s.quantity) AS total_quantity,
        sum(s.quantity * s.price) AS total_revenue
    from products p
    join sales s on p.product_id = s.product_id
    group by season, p.category
),
ran as (
    select *,rank() over(partition by season order by total_quantity desc,total_revenue desc) r
    from sea
)
select season, category, total_quantity, total_revenue
from ran
where r = 1
order by season;
