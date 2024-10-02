
--here it will bring the data from the two tables + eliminating the duplicate values " by default the output ordered in acending order "
select employee_id empno , job_id jobno from employees
union 
select employee_id empno1 , job_id jobno1 from employees

-- it will bring all the values including the duplicate values
select employee_id empno , job_id jobno from employees
union all
select employee_id empno1 , job_id jobno1 from employees

--the output will be only the shared values
select employee_id , job_id from employees
intersect
select employee_id,job_id from job_history

--here it will present the employee who haven't changed there job "only the records that exist in the table one but not exist in table two"

select employee_id , job_id from employees
minus 
select employee_id,job_id from job_history
