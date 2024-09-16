-- using where clause to filter or limiting data
select*from products 
where model_year>2016
order by brand_id

--filter data in where clause using to_char function
select customer_id,shipped_date from sales.orders 
where to_char(shipped_date,'mm')>'04'
order by 2;

--filter data in where clause using to_date function

select*from sales.orders
where shipped_date> to_date('01-JAN-17','DD-MON-YY')


-- using between and operator
select* from products
where list_price between 1000 and 3000

-- using in operator
select* from products
where model_year in (2017,2018,2019)

--using like operator

select*from sales.customers
where first_name like 'K%'

select*from sales.customers
where first_name like '%an%'

select*from sales.customers
where first_name like '%m'

select*from sales.customers
where first_name like '_d%'

select*from sales.customers
where first_name like '__r%'

--using is null / is not null/ not in/not like operator
select*from sales.customers 
where phone is null

select*from sales.customers
where phone is not null

select*from sales.customers
where customer_id not in (5 ,7 ,12)

select*from sales.customers
where first_name not like 'A%'
order by first_name desc

--using the not equal operator ,these quieres the same 

select*from products
where category_id<>6;

select*from products
where category_id!=6
 
 --using logical operator (AND,OR),the priority always wil be for 'NOT' then 'AND' then 'OR' 
 select product_name,model_year,list_price
 from products
 where ( model_year = 2018 OR model_year = 2019)
 AND list_price >2000
 
 select product_name,model_year,list_price
 from products
 where  model_year = 2018 OR (model_year = 2016
 AND list_price >2000)
 
--if we want the nulls appere first then we use like this
select *from sales.customers
order by phone nulls first

-- we can use alias in order by
select first_name f ,email city 
from sales.customers
order by f desc;

--if we want add 200 for all the list_price and we want to order by this expression
select product_name,list_price+200 from products
order by list_price+200

--we can order by to column
select first_name  ,email, city 
from sales.customers
order by 1,3

--using fetch clause

select first_name ,city 
from sales.customers
fetch first 10 rows only

select first_name ,city 
from sales.customers
fetch first 50 percent rows only

select first_name ,city 
from sales.customers
offset 20 rows fetch next 50 percent rows only




