--character functions like(UPPER,lower,Initcap) called case-conversion functions
select first_name,UPPER(first_name),lower(first_name),Initcap(first_name)
from sales.customers
--we can use these functions select, where and order by clause.
select UPPER(first_name),email,city
from customers
where upper(first_name)=upper('DEBRA')

select lower(first_name)||' '||lower(last_name)
from customers
order by lower(first_name),lower(last_name)

--character functions (concat,substr,length)
select concat(first_name,last_name)
from customers

--we use substr function to extract string from a given string
select first_name,substr(first_name,1,4)
from customers

--length function used to count the character of a given string
select first_name,length(first_name)
from customers
order by length(first_name)

--the instr function used to search in the given string and retern the position of it
select first_name,instr(first_name,'am',1,1)
from customers

--function(lpad) adds carachter to the right of the expression  and vice versa for the (rpad)
select first_name,rpad(first_name ,8,'*'),lpad(first_name,8,'#')
from customers

--function (replace) to replace string with another string
select last_name,replace(last_name,'am','**'),replace(last_name,'da','$$$$')from customers

--the trim() function removes the space character OR other specified characters from the start or end of a string
select trim( leading 'a' from 'amina') v from dual
select trim(trailing 'm' from 'maram')v from dual
select trim (both 'm' from'maram') v from dual
select trim('a'from 'amina')v from dual --the dufault will work like both
select trim( '    ebtesam mousa    ') v from dual -- here the default will remove the spaces only


--number functions(round,trunc,mod)
--we use (mod)function to see if the number even or odd by dividing the number by 2
select mod(100,2) v from dual
select mod(15,2) v from dual

-- The truncate() function truncates a number to the specified number of decimal places.
select trunc(10.576) v from dual -- here by default it will remove the decimal numbers.
select trunc (11.543,2)v from dual
select trunc(11.67,1)v from dual

-- The round() function rounds a number to a specified number of decimal places.
select round(10.57) v from dual
select round(10.57,1)v from dual
select round(10.596,2)v from dual

--here to see how many days between the day of order and the required day
select first_name,(required_date-order_date),round(required_date-order_date)
from customers c join orders o
on c.customer_id=o.customer_id

--here to show the date+hours and minutes.
select to_char(required_date,'dd-mm-yy hh:mm:ss'),to_char(required_date+5/24,'dd-mm-yy hh:mm:ss') from orders

--months_between/add_month/next_day/last_day 
select months_between(required_date,order_date),add_months(order_date,5),next_day(order_date,'sunday')
from orders
--here to see the last_day of the month of shipped_date 
select shipped_date,last_day(shipped_date)from orders

--date functions(round,trunc)
select order_date,round(order_date,'month'),trunc(order_date,'month'),round(order_date,'year'),trunc(order_date,'year')from orders


--here if we want to split the name by using(substr)function
select 'ebtesam mousa fayez' ,substr('ebtesam mousa fayez',1,instr('ebtesam mousa fayez',' ',1,1)-1) first_name,
substr('ebtesam mousa fayez',instr('ebtesam mousa fayez',' ',1,1)+1,instr('ebtesam mousa fayez',' ',1,2)- instr('ebtesam mousa fayez',' ',1,1)) middel_name, 
substr ('ebtesam mousa fayez',instr('ebtesam mousa fayez',' ',1,2)+1) last_name