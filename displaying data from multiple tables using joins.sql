
--An Equi Join in SQL is a type of join that combines rows from two or more tables based on a common column or set of columns, using the equality .
select first_name,product_name,quantity from customers c ,orders o,order_items oi,production.products p
where c.customer_id=o.customer_id and o.order_id=oi.order_id and oi.product_id=p.product_id

--here i want to see each customer how many brands they bought
select first_name,count(brand_id) from  customers c ,orders o,order_items oi,production.products p
where c.customer_id=o.customer_id and o.order_id=oi.order_id and oi.product_id=p.product_id
group by first_name

-- here each customer and the amount of money he spent
select c.first_name,c.email,sum(p.list_price) from customers c,orders o ,order_items oi ,production.products p
where c.customer_id=o.customer_id and o.order_id=oi.order_id and oi.product_id=p.product_id
group by c.first_name,c.email

/*example of non equi join (we create table called prices that categorize the prices of the products either low price,meduim price ,high price
but it doesn't has a primary and foreing key it debends on join condition)*/

select product_name , list_price, price_category
from production.products p,production.prices pr
where list_price between pr.lowest_price and pr.highest_price


--here in order to present all the data from the main table even if there is a null value in the forign key column we use (+) to the side of the other table
/*in table brands we have 9 brands while in table products we have 8 brands we want to display all the brand information so here the main table is brands and also the information of the table products*/

select p.product_name ,b.brand_id,b.brand_name
from production.brands b,production.products p
where b.brand_id=p.brand_id(+)
order by 2 desc -- so here all the brand information appered


--example of cartesian product
select product_name,brand_name
from production.products,production.brands

--joining tables in 1999 syntax

select select product_name,brand_name
from production.products cross join production.brands --here the same previous example but insted of comma we used cross join

--example of netural join
select product_name,brand_name,brand_id
from production.products natural join production.brands -- here the in the shared column (brand_id) we shouldn't but previx

--example of join using clause
select customer_id,first_name,email,order_id
from customers join orders
using(customer_id)--here again we can't use previx in the shared column this work like equi join old syntax

--example of using join on clause
select product_id,product_name,brand_name,category_name
from production.products p join production.brands b
on p.brand_id=b.brand_id
join production.categories c
on p.category_id=c.category_id

--example of left outer join
select product_name,brand_name
from production.products p left join production.brands b
on p.brand_id=b.brand_id -- here it will bring all the data of the main table"products" even if there is missing data in the foreing key column


select product_name,brand_name
from production.products p right join production.brands b
on p.brand_id=b.brand_id -- here it will bring all the data of the main table"brands" even if there is missing data in the foreing key column

select product_name,brand_name
from production.products p full outer join production.brands b
on p.brand_id=b.brand_id -- here it will bring all the data of the table"products" even if there is missing data in the foreing key column also the same thing with table brands
