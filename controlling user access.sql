--here only DBA responsible for grantting priveliges to the users
--we need to connect as sys then move to pluggable database which is  orclpdb
show con_name;

alter session set container=orclpdb

--to see all the schemas belong to the orclpdb
select*from all_users

--to see all the available system priveliges.

select*from system_privilege_map

--to create user

create user demo identified by demo1234;

--grant some privs to the user demo

grant create session,create table to demo

grant unlimited tablespace to demo --to create unlimited table space

grant create synonym,create view,create sequence to demo


--these are some object_privs 
grant select on production.products to demo 
grant select on production.categories to demo
grant select on production.brands to demo

--we grant only list_price column to be updated
grant update (list_price) on production.products to demo

grant delete on production.categories to demo

--here it means we give all the prives like select,update,delete on table stocks to the user demo
grant all on production.stocks to demo;

grant select,insert,update on production.prices to demo

grant select on sales.orders to public --this mean that any user cann acces to the table orders 

--Each user can know their own privileges like this
select*from session_privs

grant select on sales.customers to demo with grant option --it mean the user demo can pass this privs to any user

grant create public synonym to sales

--we need to create role to put on it some sys_privs and give it to the users
create role manager

--we will pass these sys_privs to the role manager

grant create session,create table,create view ,create sequence to manager;

create user ebtesam identified by 1234

grant create session to ebtesam

grant unlimited tablespace to ebtesam

grant manager to ebtesam

revoke select on sales.customers from demo --this meam that all the granted users from user demo will lose this privs also

--if we want to drop user
drop user ebtesam cascade --all his objects will removed