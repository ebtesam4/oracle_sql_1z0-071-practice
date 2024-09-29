--using date in to_char function 
select*from orders

select first_name,to_char(order_date,'DY-MONTH-YYYY')
FROM customers c join orders o on c.customer_id=o.customer_id

--here by to_char function we can show the time of the current date
select first_name,to_char(SYSDATE,'DY-MONTH-YEAR HH24:MI:SS PM')
FROM customers c join orders o on c.customer_id=o.customer_id


 select first_name,to_char(SYSDATE,'DD.MM.YY HH:MI:SS AM')
FROM customers c join orders o on c.customer_id=o.customer_id


 select first_name,to_char(order_date,'DDSPTH "OF" MM YY HH:MI:SS AM')
FROM customers c join orders o on c.customer_id=o.customer_id

select * from orders
where to_char(required_date,'yyyy')='2018'

select * from orders
where to_char(order_date,'YY')='16'


--using to_char with numbers, we use it convert the number to the string representation we want
select to_char(1553.56) from dual --here it will be the same
select to_char(1273.567,'99,999.99')from dual --each 9 represent number and here the number will be rounded
select to_char(12856.67,'999G999D9')from dual--the G it will work like the ',' and D it will work like the decimal point '.'
select to_char(182739.99,'999,99.99')from dual--here it gives error because the format number less than the number we want to conver it.
select to_char(-8,'9mi')from dual --here to shift the negative sign to the right of the number
select to_char(-98,'99PR')from dual--to paranthesiz the negative number
select to_char(12387.99,'fm999,999.99')from dual--to remove the unnessery zeros or spaces

--to_date function
select*from orders
where order_date =to_date('03-JAN-17','DD-MON-YY')
--the same
select*from orders
where to_char(order_date,'DD-MON-YY')='03-JAN-17'

--here it will gives me 1988 because rr in format if the value between 50-99 it will gives 19xx and if the value between 0-49 it will give me 20xx
select to_date('12-11-88','dd-mm-rr')from dual --here the result 12-NOV-88
select to_char(to_date('12-11-88','dd-mm-rr'),'yyyy')from dual--here to show the year in format yyyy '1988'

select to_date('17-09-33','dd-mm-yy')from dual--here the result 17-SEP-33
select to_char(to_date('17-09-33','dd-mm-yy'),'yyyy')from dual--here to show the year in format yyyy '2033'


select round(months_between(sysdate,order_date)) from orders
select next_day(sysdate,'SUNDAY')from dual

--when we want to deal with null values in a query by substituting them with a default value
select first_name,phone ,nvl(phone,0)from customers
--nvl2 if the first value is not null then seconde value ,and if it null it will gives third value
select first_name,phone ,nvl2(phone,phone,0)from customers

--the coalesce gives the first non value
select first_name,phone ,email,city, coalesce(phone,email,city)from customers


--the case cunction works like the if-else statment in programming
select*from customers

select first_name,email,state,
case when state='NY' THEN 'NEW YORK'
WHEN state='CA' then 'calefornia'
end "city full nam"from customers


select first_name,email,phone,
case when phone is null THEN q'/hasn't phone number/'
when phone is not null then 'has phone number'
end "phone condistion"from customers

--decode function work like case function but in a simple syntax
select first_name,email,state,
decode(state,'NY','NEWYORK',
             'CY','CALIFORNIA')
             "city full name" FROM customers
             