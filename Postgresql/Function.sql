-- Creating Employee data table

CREATE TABLE employee (

	emp_id SERIAL PRIMARY KEY,
	fname  VARCHAR(100) NOT NULL,
	lname  VARCHAR(100) NOT NULL,
	email  VARCHAR(100) NOT NULL UNIQUE,
	dept   VARCHAR(50),
	salary DECIMAL(10,2) DEFAULT 30000.00,
	hire_date DATE NOT NULL DEFAULT CURRENT_DATE
	
);

-- DROP TABLE employee

employeedb=# SELECT setval('employee_emp_id_seq',1);  In this we set value 1 to lightup SERIAL constraints 
 setval   
--------
      1
(1 row)


employeedb=# SELECT currval('employee_emp_id_seq'); It shows the current value of emp_id
 currval
---------
       1
(1 row)

INSERT INTO employee (emp_id,fname , lname, email, dept,salary,hire_date)
VALUES
(1 , 'Raj', 'Sharma', 'raj.sharma@example.com','IT',50000.00,'2020-01-15');
('Priya','Singh','priya.singh@example.com','HR'); -- By default id, salary and data 

('Arjun','Verma','arjun.verma@example.com','IT')

('Sachin','Verma','arjun.verma@example.com','IT') -- shows error becoz email should be unique

(4,'Suman','Patel','suman.patel@example.com','Finance',60000.00,'2018-07-30')
(5,'Kavita','Rao','kavita.rao@example.com','HR',47000.00,'2020-11-10'),
(6,'Amit','Gupta','amit.gupta@example.com','Marketing',52000.00,'2020-09-25'),
(7,'Neha','Desai','neha.desai@example.com','IT',48000.00,'2019-05-18'),
(8,'Rahul','Kumar','rahul.kumar@example.com','IT',53000.00,'2021-02-14'),
(9,'Anjali','Mehta','anjali.mehta@example.com','Finance',61000.00,'2018-12-03'),
(10,'Vijay','Nair','vijay.nair@example.com','Marketing',50000.00,'2020-04-19');

-- Data Refining

-- Clauses
-- -- Where
-- -- Distinct
-- -- Order By
-- -- Limit
-- -- Like

select * from employee
where emp_id=2
where dept = 'Finance'
where salary > 50000
where dept = 'HR' or dept ='Finance'
where dept = 'Finance' and salary >= 50000.00

-- IN operator
select * from employee 
-- where dept IN('IT','HR','Finance')
where dept NOT IN('IT','HR','Finance')

-- BETWEEN operator

select * from employee
where salary BETWEEN 40000 and 65000

-- DISTINCT (Unique value)

select DISTINCT dept from employee

-- Order BY

Select * from employee
-- ORDER BY fname;
ORDER BY emp_id DESC;

-- LIMIT 

select * from employee
LIMIT 3;

-- LIKE

select * from employee
-- where fname LIKE 'A%';
-- where fname LIKE '%i%';
-- where fname LIKE '_m%'  -- second character
where dept LIKE '__'    -- Two character dept name 


-- Aggregate Function
-- -- COUNT
-- -- SUM
-- -- AVG
-- -- MIN
-- -- MAX

-- COUNT
select COUNT(emp_id) from employee

-- SUM
select SUM(salary) from employee

-- AVG
select AVG(salary) from employee

-- MIN
select MIN(salary) from employee

-- MAX
select MAX(salary) from employee

-- GROUP BY

-- select dept,COUNT(emp_id) from employee GROUP BY dept;
select dept,SUM(salary) from employee
GROUP BY dept;

select dept,MAX(salary) from employee
GROUP BY dept;

-- STRING FUNCTION

-- -- CONCAT, CONCAT_WS
-- -- SUBSTR
-- -- LEFT,RIGHT
-- -- LENGTH
-- -- UPPER,LOWER
-- -- TRIM,LTRIM,RTRIM
-- -- REPLACE
-- -- POSITION
-- -- STRING_AGG

-- CONCAT

select CONCAT('Hellow','world');
select CONCAT(fname,lname) AS FULLNAME from employee;

-- CONCAT_WS with seperator

select CONCAT_WS(' ',fname,lname,salary) as fullname from employee;

-- SUBSTRING

select SUBSTRING('Hey Buddy',1,3);

-- REPLACE

select REPLACE('Hey Buddy', 'Hey' ,'Heloo');
select REPLACE(dept,'IT','TECH') from employee

-- REVERSE 

select REVERSE('Hello');
select REVERSE(fname) from employee;

-- LENGTH

select LENGTH('Mechmega');
select LENGTH(fname) from employee;
select * from employee
where LENGTH(fname) > 5;

-- UPPER LOWER

select UPPER(fname) from employee
select LOWER(fname) from employee

-- LEFT, RIGHT, TRIM, POSITION

select LEFT('Hello',2);
select RIGHT('Hello',2);

select LENGTH('  spaces  '); -- 10
select LENGTH(TRIM('  spaces  ')); -- 6

select POSITION('om' in 'Thomas');

-- Practice exercise

-- 1. 1:Raj:Sharma:IT
select CONCAT_WS(':',emp_id,fname,lname,dept) from employee
where emp_id=1;

-- 2. 1:Raj Sharma:IT
select CONCAT_WS(':',emp_id,CONCAT_WS(' ',fname,lname),dept) from employee
where emp_id=1;

-- 3. 4:Suman:FINANCE
select CONCAT_WS(':',emp_id,fname,UPPER(dept)) from employee
where emp_id=4;

-- 4. I1 Raju
--	  H2 Priya

select CONCAT(LEFT(dept,1),emp_id),fname from employee
limit 2

-- 5. Find different type of departments in database ?

select DISTINCT dept from employee;

-- 6. Display records with High-low Salary

select * from employee
ORDER BY salary DESC;

-- 7. How to see only top 3 records from a table ?

select * from employee
limit 3;

-- 8. Show records where first name start with letter 'A'

select * from employee
where fname LIKE 'A%';

-- 9. show records where length of the lname is 4 character

select * from employee
where LENGTH(lname) = 4;

-- 10. Find total no. of employees in database

select COUNT(emp_id) as Total from employee

-- 11. Find no. of employees in each department

select dept,COUNT(emp_id) from employee
GROUP BY dept;

-- Find lowest salary paying

select * from employee 
ORDER BY salary ASC
limit 1

-- BUT this method dont find all the lowest salary so we use subquery

select * from employee
where 
salary =(select MIN(salary) from employee)

-- Find highest salary paying Tricky question

-- select MAX(salary) from employee; not ask max salart who get max salary 
-- using subquery

select * from employee
where
salary=(select MAX(salary) from employee);

-- Find total salary paying in Loan department ?

select dept,SUM(salary) from employee
where dept = 'Finance'
GROUP BY dept;


-- Average salary paying in each deparment 

select dept, AVG(salary) from employee
GROUP BY dept;


select * from employee


-- CASE EXPRESSION

select fname,salary,
CASE 
	when salary>=50000 THEN 'HIGH'
	ELSE 'LOW'
END AS sal_cat
FROM employee

select fname,salary,
CASE 
	WHEN salary>=50000 THEN 'HIGH'
	WHEN salary BETWEEN 45000 and 50000 THEN 'MID'
	ELSE 'LOW'
END AS sal_cat
from employee

-- BONUS

select fname ,salary ,
CASE 
	WHEN salary > 0 THEN (salary*0.1)
END as bonus
from employee

-- COUNT

select
CASE 
	WHEN salary>=50000 THEN 'HIGH'
	WHEN salary BETWEEN 45000 and 50000 THEN 'MID'
	ELSE 'LOW'
END AS sal_cat,COUNT(emp_id)
from employee
GROUP BY sal_cat;

select * from employee

-- Types of Relationships

--- One to One	  raju and his details
--- One to Many   raju doing different tasks
--- Many to Many  books and authors 

Foreign Key

ek table mei kisi or ka primary key foreign key khalati hai







