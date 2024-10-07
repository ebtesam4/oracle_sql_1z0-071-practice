-- first we will execute this statment to know all the important constraint on the data
desc staffs 

--there are various types of insert statment

insert into staffs (staff_id,first_name,last_name,email,phone,active,store_id,manager_id)
values(11,'ebtesam','mousa','aamm1@gmail.com','(966)556398492',1,2,5)
commit --to save the changes in the database

--another way to insert without puting the column names but  all values of the columns should be inserted and in the same order
insert into staffs 
values(12,'maha','mousa','auerf@gmail.com','(966)5563878492',1,1,5)
commit

--we can insert the values with any order we want but the values that we insert should be the same column'order
insert into staffs (staff_id,first_name,last_name,phone,email,store_id,active,manager_id)
values(13,'huda','mousa','nskhd@gmail.com','(966)556398459',2,1,1)
commit
--we can ignore the null column by didn't mention it in the insert statment
insert into staffs (staff_id,first_name,last_name,email,phone,active,store_id)
values(14,'eman','mousa','jhjk@gmail.com','(966)556348892',1,3)--here we didn't mention the manager column because it is null
commit

--update statment 

update products
set list_price=400
where product_id=1 --the best practice in where clause to use the primary key so you guarantee to update the required record

update products
set model_year=2019
where product_id=2
commit

--delete statment
delete from products
where product_id=100 --the where clause is optional but if we didn't use it ,it will remove all the data

delete from products
where product_id in (select product_id from products where model_year=2016)--here it will return more than one value to be deleted thats why we used "in" operator

--using commit and rollback
--we can execute group of logicaly related DML operation and use COMMIT at the end.
update products
set model_year=2019
where product_id=10

delete from products
where product_id=20 

commit --here it will commit and save the update and the delete statment

--the commit will be executed implicitly when we execute DDL 
update brands
set brand_name='Toshipa'
where brand_id=1

create table the_products
as select*from products --here it will commit the update statment implicitly even we didn't use the commit explicitly

update products
set list_price=1000
where product_id=30

delete from products
where product_id=40

rollback;-- rollback statment it will discard all the previus DML statment if we didn't commit it;



--savepoint
update products
set list_price=2000
where product_id=3

savepoint A;

update products
set list_price=2500
where product_id=3
savepoint B;

update products
set list_price=3000
where product_id=3
savepoint C;

ROLLBACK to savepoint B; --here it rollback to savapoint B and we can later rollback to savepoint A but we can't rollback C

--FOR UPDATE CLAUSE 

select*from products
where product_id=1
for update; --here it means that i locked this record so the other session can't do any modification on this row

commit; --we can release this rows by execute commit or rollback;


select*from products
where product_id=4
for update now wait;--this means if there is session doing some DML on this record the cusrrent session it will give me error ensted of hanging the session

select*from products
where product_id=4
for update now wait 10; -- This means that if another session is performing DML on the same row and doesn't commit within 10 seconds, an error message will appear.
