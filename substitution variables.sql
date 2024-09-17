--using substitution variable in select clause ,where clause,order by clause
select first_name ,email,&column from sales.customers;

select product_name,list_price
from products
where &condision

select product_name,model_year,list_price
from products
order by &column

--using DEFINE to create a variable and assign a value to it ,it will be only in the current session
define customer_id=100
select customer_id ,first_name,email,city
from sales.customers
where customer_id=&customer_id

--here to cancel the variable
undefine customer_id;

--using accept/prompt to define variable that will take the value from user and keep it for the current session

accept customer_id prompt 'could you please enter customer_id'
select customer_id,first_name,city
from sales.customers
where customer_id=&customer_id

-- using double ampersand works the same way the 'define' works
select product_name,list_price 
from products
where model_year=&&model_year
undefine model_year

-- we use set verify to display the text of a command before and after it replaces substitution variables with value
set verify on
select customer_id,first_name,email
from sales.customers
where customer_id=&customer_id
undefine customer_id
