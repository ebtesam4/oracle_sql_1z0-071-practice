--example of using 'default' in the insert and update statment

create table pro_default(
product_id number primary key,
product_name varchar2(31),
model_year number default 2019

)

--here it will implicitly it will take the default value of the column when table created
insert into pro_default(product_id,product_name)values(1,'Trek 820')

--we can mention default exciplictly
insert into pro_default values(2,'Trek 980',default)

insert into pro_default values(3,'Trek 2000',2018)

--we can update the previous insert statment using default
update pro_default 
set model_year=default
where product_id=3

select*from pro_default



--example of insert statment using select statment

insert into pro_default (product_id,product_name,model_year)
select product_id,product_name,model_year
from products
where model_year= 2017
union all
select product_id,product_name,model_year
from products
where model_year= 2016




create table pro_price(
product_id number primary key,
product_name varchar2(60),
list_price number 

)

--this is conditional insert first it will examin each row returned by subquery if the first condition met it will skip the seconde condition and move to seconde row

insert first
when model_year =2016 then
into pro_default (product_id,product_name,model_year)values (product_id,product_name,model_year)
when list_price>1000 then
into pro_price (product_id,product_name,list_price)values (product_id,product_name,list_price)
select product_id,product_name,model_year,list_price from products

--there will be no recorde shared
select product_id,product_name from pro_default
intersect
select product_id,product_name from pro_price

--we will delete the data in order to know the different between insert first,insert all
delete from pro_default;
delete from pro_price;

insert all
when model_year =2016 then
into pro_default (product_id,product_name,model_year)values (product_id,product_name,model_year)
when list_price >1000 then
into pro_price (product_id,product_name,list_price)values (product_id,product_name,list_price)
select product_id,product_name,model_year ,list_price from products

--here there will be shared recorde because each row returned by subquery will examined by the tow condistion
select product_id,product_name from pro_default
intersect
select product_id,product_name from pro_price


--matrix report using piviot

select model_year,brand_id,count(1) as number_of_products
from products
where model_year in(2016,2017,2018,2019)
group by model_year,brand_id
order by number_of_products--here it will show the result as a tabular way


select*from
(
select model_year,brand_id from products
where model_year in(2016,2017,2018,2019)
)
pivot
(
count(1)for model_year in(2016,2017,2018,2019)
)

order by 1 --here it will show the result as matrix

--merge statment
--we want to merge same recorde in table1 to table 2
create table the_product(
id number,
product_name varchar2(30)
)
select*from products
insert into the_product values(1,'Trek Checkpoint SL 6 - 2020')
insert into the_product values(2,'Heller Shagamaw Frame - 2016')
insert into the_product values(3,'Surly Ice Cream Truck - 2016')


create table the_product1(
id number,
product_name varchar2(30)
)

insert into the_product1 values(1,'zzzzz')
insert into the_product1 values(2,'yyyyy')


merge into the_product1 pro1
using(select*from the_product) pro
on(pro1.id=pro.id)
when matched then
update
set pro1.product_name= pro.product_name
when not matched then
insert values (pro.id,pro.product_name)

select*from the_product1


--Flashback means that we can restore the table again after it has been removed from the database, as long as we didn't use PURGE

create table pro_flash
as 
select*from products

drop table pro_flash

select*from pro_flash --it will gives me error table do not exist

select*from recyclebin
where original_name='PRO_FLASH' -- the details information about the dropped table

flashback table pro_flash to before drop

select*from pro_flash --here table resored again


--if we want to update column and want to see the previous value of the column

update pro_flash 
set list_price=500
where product_id=1

select*from pro_flash where product_id=1

update pro_flash 
set list_price=700
where product_id=1

select list_price from pro_flash
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
where product_id=1 --to see the old values of the column lis_price



