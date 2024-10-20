--example of creating simple views

create view view_1
as
select first_name,email,city
from customers

select*from view_1 --to query from the view

--the column's heading of the view will be the same name of the table and there is tow way to change the name
create view view_2
as
select first_name fname ,email mail,city the_city
from customers-- here is the first way

select*from view_2

create view view_3 (fname,mail,city)
as
select first_name,email,city
from customers --here is the seconde way

--example of creating complex views
create or replace view view_4
as
select c.first_name, 
    count(o.order_id) AS ord_number
from 
    customers c 
left outer join orders o ON c.customer_id = o.customer_id
group by  c.first_name
order by  ord_number ASC;

select*from view_4

--example of creating view with read only/check option

create view view_5
as
select first_name,phone,email,city
from
customers
with read only --thats mean DML operation is not allowd

select*from user_constraints
where table_name='view_5' --oracle will give the view a constraint with a given name with constraint type 'O'

create or replace view view_6
as 
select customer_id,first_name,last_name,email,street,city,state,zip_code
from customers
where state='NY'
with check option

insert into view_6 values(1502,'huda','mohammedd','aaae@gmail.com','817 Adamsf St','Pittsforde','TX',14534)