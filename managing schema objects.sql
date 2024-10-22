-- example of adding constraint /dropping constraint

create table customers_1
as
select*from customers

create table ords
as
select*from orders
--this is method 1 to add constraint

alter table customers_1
modify customer_id primary key -- but its not recommended we need to give it a name

select*from user_constraints
where table_name='CUSTOMERS_1'--we will see that oracle server give it a name like sys_cn

alter table customers_1
drop constraint &con --here we did this because we want to give the constraint a name

--this is method 2 'recomended'

alter table customers_1
add constraint cust_pk primary key (customer_id)

create table ords
as
select*from orders

--adding foreign key constraint
alter table ords
add constraint cust_fk foreign key(customer_id)references customers_1(customer_id)


alter table ords
add constraint ord_pk primary key(order_id)

select*from user_constraints
where table_name in ('CUSTOMERS_1','ORDS')
and constraint_type in ('P','R')

--we can add not null constraint but in tow condition either the table is empty or the column has data
alter table customers_1
modify first_name not null

--example of dropping constraint

alter table customers_1
drop primary key cascade --here it will also drop the related constraint

--now we will recreate constraint again

alter table customers_1
add constraint cust_pk primary key (customer_id)

alter table ords
add constraint cust_fk foreign key(customer_id)references customers_1(customer_id)

--droping column primary key

alter table customers_1
drop column customer_id cascade constraint --here it will delete the column with its related constraint but the foreign key column in the child table will remain

--examples of rename column 
alter table customers_1
rename column first_name to fname

--examples of rename constraints

alter table ords
rename constraint ord_pk to order_pk


--example of enable/disable constraint , we will drop table customers_1,ords and recreate it again

drop table ords

drop table customers_1

create table customers_1
as
select*from customers

alter table customers_1
add constraint cust_pk primary key (customer_id)

create table ords
as
select*from orders

alter table ords
add constraint ord_pk primary key(order_id)

alter table ords
add constraint cust_fk foreign key(customer_id)references customers_1(customer_id)


--here we want to disable the constraint of the column order_id in table ords
alter table ords
disable constraint ord_pk -- here the index of the primary key will removed

alter table ords
enable constraint ord_pk -- here to enable it again

--to disable constraint in column primary key that has dependences

alter table customers_1
disable constraint cust_pk cascade --the related constraint also will be disabled 


select*from user_constraints
where table_name IN('CUSTOMERS_1','ORDS') --to check the status of the constraints

--deferrable deferred/immediate constraint

create table prod_1(
product_id number primary key,
product_name varchar2(30),
list_price number ,
tax number ,
constraint list_ck check(list_price>1000) deferrable initially deferred, --it means it will show the mistake until the commite
constraint tax_ck check(tax=0.15) deferrable initially immediate--it will show the mistake immediatly
)

--to swich from deferred to immdiate
set constraint list_ck immediate

--examples of creating temporary table
create global temporary table cart(
item_no number primary key,
quantity number
) on commit delete rows -- thats mean when we make commit the data will be removed

insert into cart values(1,5);
insert into cart values(2,3);

commit
select*from cart --the data have been removed


create global temporary table cart_1(
item_no number primary key,
quantity number
) on commit preserve rows --this mean the data will be kept if we make commit until we exit the session

insert into cart_1 values(1,2);
insert into cart_1 values(2,9);

select*from cart_1 --the data will remain until we exit the current session

--example of how we load data into table from external file using the utility oracle_loader

create or replace directory emp_directory
as 'C:\external' --but here we should have the previleg of create any directory from the admin

create table emp_1(
emp_no number,
emp_fname varchar2(20),
emp_lname varchar2(20)
)

organization external
( type oracle_loader
default directory emp_directory
access parameters(
records delimited by newline
fields terminated by ',')

location('emp.csv'))
reject limit unlimited;

-- example of using the utility oracle_datapump by creating dump file on the server and store its data from the select statment and read it into the external table
create table emp_2(
emp_no,
emp_fname,
emp_lname
)--here we didn't use any data type becouse it will match its data type from the select statment

organization external
(type oracle_datapump
default directory emp_directory
location('emps.dmp')

)
as
select customer_id,first_name,last_name
from customers

select*from emp_2
--seconde way is to read the data from the dump file

create table emp_3(
emp_no number,
emp_fname varchar2(20),
emp_lname varchar2(20)
) --here we should mention the data type becouse there is no select statment the data will be read from the dump file
organization external
( type oracle_datapump
default directory emp_directory
location('emps.dmp')

)
select*from emp_3

