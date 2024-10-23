--example of using subquiry as source table

select first_name ,co.count
from customers c,(select customer_id,count(order_id) as count from orders group by customer_id) co
where c.customer_id=co.customer_id

--example of quiry each customer name with its last order date using subquiry as source table
select first_name , date_orderd
from customers c,(select o.customer_id ,max(order_date) as date_orderd from orders o group by o.customer_id) o
where c.customer_id=o.customer_id

--pairwise/nonpairwise comparision subquery

select*from products
where (category_id,model_year)in(select category_id,model_year from products where brand_id=9)
and brand_id!=9 --this is called pairwise subquerr two column shoud match exactly the two column in the subquery

--this is example on nonpairwise subquery
select*from products
where category_id in (select category_id from products where brand_id=9)
and model_year in(select model_year from products where brand_id=9)
and brand_id!=9 

--example of scalar/correlated subquery
select product_name ,p.model_year,list_price,(select max(list_price)from products ps where p.model_year=ps.model_year) year_max_price
from products p --here we want to compaire each product's price by the max price of any product in its year

/*select*from order_items
select*from products*/

--with clause
--here we want each customer and the total price he paid for the year 2017,with clause is good for complicated query
with total_order
as
(
select  o.customer_id,first_name,count(order_id) order_no from customers c join orders o 
on c.customer_id=o.customer_id
where to_char(order_date,'yyyy')='2017' --and first_name='Chantell'
group by first_name,o.customer_id
order by order_no DESC)
,total_price
as(
select o.customer_id, count(oi.order_id),sum(quantity*list_price*discount) as total from order_items oi join orders o
on oi.order_id=o.order_id
group by o.customer_id

)

select first_name,total
from total_order tos , total_price tp
where tos.customer_id=tp.customer_id





