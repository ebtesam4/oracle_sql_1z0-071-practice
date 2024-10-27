--example of the interval(year to month\day to second)

select interval '34-10' year to month from dual --the result will  show me 34 years and 10 month

select interval '645-11' year(3) to month from dual --here if the digits of the year more than 2 we should put the size after the word year

 --here oracle will deal with hours like 'year to month'
select interval '700' month from dual 
--the same thing here with day to second we should specify the size after the word day ,also we should define the day,hour,minute,second
select interval '343 04:20:50' day(3) to second from dual 

select interval '200000' second from dual --here oracle will deal with hours or second like 'day to hour'

select interval '80' day from dual

--if we want to add interval to a date
select hire_date + interval '3-8' year to month from employees

select sysdate+ interval '05 20:34:09' day to second from dual

--insted of the previous sentence we can use (to_yminterval\to_dsinterval)
select sysdate,sysdate+to_yminterval('05-00')from dual

select sysdate,sysdate+to_dsinterval('40 13:50:23')from dual 

--the previous sentence didn't show the exact hour ,minute and second we can show it like this:

select to_char(sysdate,'dd-mm-yy hh:mm:ss'),to_char(sysdate+to_dsinterval('40 13:50:23'),'dd-mm-yy hh:mm:ss')from dual

--we can extract year,month,day from given date
select hire_date from employees
where extract(year from hire_date)=2007

select sysdate,extract(year from sysdate),extract(month from sysdate),extract(day from sysdate)from dual.

--examples of timestamp/timestamp with time zone
create table time_zone_examples(
date1 date,
date2 timestamp,
date3 timestamp with time zone
)
--The DATE function works like TIMESTAMP, but TIMESTAMP includes fractional seconds.
insert into  time_zone_examples values(sysdate,current_timestamp,current_timestamp)

select sessiontimezone from dual --returen the time zone for the current user session

select current_timestamp from dual --return  the timestamp (with time zone)for the user session

select localtimestamp from dual --return the timestamp for the user session

alter session set time_zone='asia/riyadh' --to alter the current zone for the user to another zone

--examples of different between timestamp with time zone\timestamp with local time zone

create table customer_order(
id number,
name varchar2(30),
item varchar2(30),
order_date timestamp with time zone,
deleviry_period number,
deleviry_date timestamp with local time zone
)

--this mean that timestamp with time zone will be according the database date but timestamp with local time zone according to the user session
insert into customer_order values(1,'ebtesam','ipad',current_timestamp,7,current_timestamp+7)

select*from customer_order

--built in function from_tz/to_timestamp/tz_offset

select from_tz(timestamp '2024-11-06 09:49:56','asia/riyadh')from dual --here it compine the information between timestamp and time zone

select tz_offset('asia/riyadh')from dual --it will gives me the offset according to the Greenwich

select to_timestamp('06-11-24 09:49:56','dd-mm-yy hh:mi:ss')from dual --it convert a given data in charachtar to a timestamp