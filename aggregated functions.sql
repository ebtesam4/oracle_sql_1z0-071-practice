--min and max for multiple rows and it can also work with varchar,dates not only for numbers
select max(list_price),min(list_price)from products

select max(order_date),min(order_date)from sales.orders

select sum(list_price),round(avg(list_price))from products
--here it will count and ignore null values
select count ( distinct brand_id)from products
--here to count also the null values
select count(nvl(brand_id,0))from products

--group by ,having clause
select brand_id,sum(list_price)
from products
group by brand_id
having sum(list_price)>7000
order by 2 desc


select order_id ,count(order_id)
from sales.orders
group by order_id
order by 1;