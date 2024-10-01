--example of single-row subqueries

select *from production.products
where brand_id=(select brand_id from production.brands where brand_name='Haro')


select first_name,email,phone,o.order_date
from customers c join orders o on c.customer_id=o.customer_id
where o.order_date =(select max(order_date)from orders) -- here we want to know the customer information who orderd recently

--example of multiple-rows subqueries
select product_name ,brand_id from production.products 
where brand_id in(select brand_id from production.brands where brand_name in ('Haro','Trek'))

select *from order_items
where order_id in(select order_id from order_items where list_price>1000)
