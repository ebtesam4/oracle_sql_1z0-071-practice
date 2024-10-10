--example of creating constraints at column-level
create table the_staffs(
employee_id number constraint emp_pk primary key,
first_name varchar2(20) not null,
last_name varchar2(20) not null,
email varchar2(30) constraint email_un unique not null,
city varchar2(20) constraint city_ck check(city in ('NY','CA')),
store_id number constraint store_fk references stores(store_id)
)

--example of creating table at table-level its the best practice because you can make composite primary key and it force you to name the constraint.

create table the_staffs1(
staff_id number ,
first_name varchar2(20) not null,
last_name varchar2(20) not null,
email varchar2(30), 
city varchar2(20) ,
store_id number,
constraint staff_pk1 primary key(staff_id),
constraint email_un1 unique (email),
constraint city_ck1 check (city in ('NY','CA')),
constraint store_fk1 foreign key(store_id)references stores(store_id)
)

--example of on delete cascade/on delete set null
create table the_brand(
brand_id number,
brand_name varchar2(20),

constraint brand_id_pk primary key(brand_id)
)

insert into the_brand values(1,'Haro');
insert into the_brand values(2,'Trek');

select*from products
--here we use 'on delete cascade' because if we delete master table the childe recorde in the other table will also be deleted.
create table the_products(
product_id number ,
product_name varchar2(30),
price number,
brand_id number,

constraint product_id_pk primary key(product_id),
constraint brand_id_fk foreign key(brand_id)references the_brand(brand_id) on delete cascade
)

insert into the_products values(1,'Ritchey Timberwolf - 2016',3000,1);
insert into the_products values(2,'Trek 820 - 2016',5000,1);
insert into the_products values(3,'Surly Wednesd- 2016',2000,2);
insert into the_products values(4,'Heller Shagamaw- 2016',6000,2);

delete from the_brand where brand_id=2--it will only delete the foreign key column with brand_id=2



--here if we want to delete the master table and want to set null on the child records

create table the_products2(
product_id number ,
product_name varchar2(30),
price number,
brand_id number,

constraint product_id2_pk primary key(product_id),
constraint brand_id2_fk foreign key(brand_id)references the_brand(brand_id) on delete set null
)

insert into the_products2 values(1,'Ritchey Timberwolf - 2016',3000,1);
insert into the_products2 values(2,'Trek 820 - 2016',5000,1);
insert into the_products2 values(3,'Surly Wednesd- 2016',2000,2);
insert into the_products2 values(4,'Heller Shagamaw- 2016',6000,2);

delete from the_brand where brand_id=2--it will set null on the foreign key column



--creating tables as subqueries

create table the_products3
as 
select*from products --here it will copy all the data with the same column name of the subquery

create table the_products4 (product_no,pname,the_price)
as
select product_id,product_name,list_price from products--here we create table with different column name of the subquery

--examples of alter table add column/modify column/drop column/set unused
alter table the_brand
add made_in varchar2(40) default 'KSA' not null -- we use default value because we can not add column not null with table doesn't empty

alter table the_brand
modify made_in varchar2(50) default 'KSA'-- modify the size of the data type

alter table the_brand
modify made_in char(5)default 'KSA'--modify the data type.

alter table the_brand 
drop column made_in --to remove the column from the table
--using unused option it will work like deleting that column but not phisicaly removed it is useful when that column has large value and it take time if we want to delete it
alter table the_brand
set unused (made_in)

alter table the_brand
drop unused column --to drop the unused columns

alter table the_brand
add made_in varchar2(40) default 'KSA' not null 

alter table the_brand
set unused (made_in)online -- means it allow other user to perform DML operation in the table and does not locked it while column set unused.

--some time we need to prevent other using from doing any thing to the table for maintenance purpose so we use READ ONLY option.

alter table the_brand read only;

alter table the_brand read write;  --to revert it back to a writable state.

--example of droping a table
drop table the_products --here we dropped the table but we can revert it back by flashbak statment and we can find it in the recycle bin.

SELECT * FROM USER_RECYCLEBIN WHERE ORIGINAL_NAME = 'THE_PRODUCTS'; --we use this view to see the detail of droped table in the recyclebin.

drop table the_brand purge --here it means we droped the table from entire database and we cannot rever it back even with flashback statment.

--rename columns
alter table the_staffs
rename column first_name to fname.

--rename table
rename the_staffs to staff

