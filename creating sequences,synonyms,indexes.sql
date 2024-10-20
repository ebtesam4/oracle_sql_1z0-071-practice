--examples of creating sequences

create sequence order_seq

create table order_1(
order_id number primary key,
order_name varchar2(30) constraint order_notnull not null
)

--here it will generate numbers automatically.
insert into order_1 values(order_seq.nextval,'toshiba')
insert into order_1 values(order_seq.nextval,'hoover')

select*from order_1

--to know the current value of the sequence

select order_seq.currval from dual

delete from order_1
--sequence with increment -5
create sequence ord_seq
increment by -5

insert into order_1 values(ord_seq.nextval,'toshiba')
insert into order_1 values(ord_seq.nextval,'hoover')
select*from order_1

update order_1
set order_id=ord_seq.nextval

--we can create table with default value of sequence
create sequence pro_seq11

create table product_11(
product_id1 number default pro_seq11.nextval primary key,
product_name varchar2(20)
)
insert into product_1(product_name) values('toshiba')--here no need to insert the id value
insert into product_1 (product_id1,product_name)values(pro_seq11.nextval,'hoover')
--here if we want to reference another column by its sequence in insertion statment using currval
create sequence order_22

create table order_13(
order_id number default order_22.nextval primary key,
order_name varchar2(30),
product_id1 number ,


constraint pro_fk11 foreign key(product_id1) references product_1 (product_id1)
)
insert into order_13(order_name,product_id1)values('hoover',pro_seq11.currval)
insert into order_13(order_name,product_id1)values('toshipa',pro_seq11.currval)

-- example of creating synonym
create synonym ord for order_13

--example of indexes 
create table pro_ind(
product_id number,
product_name varchar2(20),
list_price number,
model_year number,

constraint pro_id_pk primary key(product_id,product_name)
)--here orcale server will create unique indexs for primary key and it will be the same name


insert into pro_ind values(1,'toshiba',5000,2019)
insert into pro_ind values(2,'toshiba a3',7000,2017)
insert into pro_ind values(3,'terk',8000,2016)


select*from user_indexes
where table_name='PRO_IND' --to check the name of the indexes

select *from user_ind_columns
where table_name='PRO_IND' -- here to see in which column the index exist.


select product_name from pro_ind
where product_name='toshiba' --here the query will be faster because there is an index on the column

--example of creating indexes
create index list_ind on pro_ind(list_price)

--creating unique index and it will work like unique constraint
create unique index modl_ind on pro_ind(model_year)

--we can also create index on exepressions
create index product_name_ind on pro_ind(lower(product_name))

--In order to find the index based on the function, I will query from the dictionary table 'USER_INDEX_EXPRESSION'
SELECT * FROM USER_IND_EXPRESSIONS
WHERE table_name = 'PRO_IND';


--We can create an index with a different name while creating the table.

CREATE TABLE pro_ind1 (
    product_id NUMBER CONSTRAINT pro_id_pk1 PRIMARY KEY USING INDEX (CREATE INDEX pro_ind ON pro_ind1(product_id)),
    product_name VARCHAR2(20),
    list_price NUMBER,
    model_year NUMBER
);
select*from user_ind_columns
where table_name='PRO_IND1'


--we can create composite index

create index list_model_ind on pro_ind1 (list_price,model_year)

