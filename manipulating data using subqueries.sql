--inserting/updating/deleting using subquery as a target

update
(
select product_name ,list_price from products
where product_id=3

)
set list_price=1000

delete
(

select*from orders where order_id =2000
)


insert into
(
select product_id ,product_name,brand_id,category_id,model_year,list_price from products
where product_id=10
)
values (322,'Trek Checkpoint SL 6 - 2020',9,7,2020,5000)

--here it means that the name of the product that will be inserted contain the word 'Terk'
insert into
(
select product_id ,product_name,brand_id,category_id,model_year,list_price from products
where product_name like 'Trek%'
with check option 
)
values (323,'Trek Checkpoint SL 6 - 2023',9,7,2023,9000)


--correlated update / correlated delete
create table pro_1 as
select*from products 

update pro_1
set list_price=0

select*from pro_1

update pro_1 pr
set list_price=(select list_price from products p where pr.product_id=p.product_id)
where exists(select*from products p where p.product_id=pr.product_id) --this is to make sure that the records witch exist in the table pro_1 and dosn't exist in the table products dosn't affected

select*from pro_1

delete from pro_1 pr
where exists(select*from products p where p.product_id=pr.product_id) --also here to ensur only the shared records will be deleted

