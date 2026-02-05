-- Creating Employee data table

CREATE TABLE employee(

	emp_id INT PRIMARY KEY,
	fname  VARCHAR(100) NOT NULL,
	lname  VARCHAR(100) NOT NULL,
	email  VARCHAR(100) NOT NULL UNIQUE,
	dept   VARCHAR(50),
	salary DECIMAL(10,2) DEFAULT 30000.00,
	hire_date DATE NOT NULL DEFAULT C

)

-- STORED Routine
-- An SQL statement or a set of SQL statement that can 
-- be stored on database server which can be call no. of times

-- Types of Stored Routine
-- STORED Procedure
-- User defined Functions

-- STORED Procedure
-- Set of SQL statements and procedural logic that can
-- perform operations such as inserting, updating, deleting,
-- and querying data

UPDATE employee
	SET salary=97000
Where emp_id = 4;


CREATE OR REPLACE PROCEDURE update_emp_salary(
p_emp_id INT,
p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE employee
  SET salary = p_new_salary
  where emp_id = p_emp_id;
END;
$$;

CALL update_emp_salary(3,97000)

select * from employee

CREATE OR REPLACE PROCEDURE add_employee(

p_fname VARCHAR,
p_lname VARCHAR,
p_email VARCHAR,
p_dept VARCHAR,
p_salary NUMERIC

)
LANGUAGE plpgsql
AS $$
BEGIN 
  INSERT into employee(fname , lname , email, dept ,salary)
  VALUES (p_fname, p_lname, p_email, p_dept, p_salary);
END;
$$;

CALL add_employee('Anurag', 'Mathur', 'anurag.mathur@example.com', 'HR',30000)

-- USER DEFINED function

-- custom function created by the user to perform specific operations and return a value

-- find name of the emplouyees in each department having max salary

select e.emp_id, e.fname, e.salary from employee e
where e.dept = 'HR'
AND e.salary =(
select max(emp.salary)
from employee emp
where emp.dept ='HR'
)

CREATE OR REPLACE FUNCTION dept_max_salary(dept_name VARCHAR)
RETURNS TABLE(emp_id INT , fname VARCHAR, salry NUMERIC)
AS $$
BEGIN 
  RETURN QUERY
  select 
   e.emp_id, e.fname, e.salary
  from 
   employee e
  where 
   e.dept = dept_name
   AND e.salary=(
	select MAX(emp.salary)
	from employee emp
	where emp.dept = dept_name
   );
End
$$LANGUAGE plpgsql;

select * from dept_max_salary('Marketing')

-- WINDOWS FUNCTIONS

-- window function also known as analytic functions allow
-- you to perform calculations across a set of rows related
-- to the current row.

-- DEFINED by an OVER() clause

select fname,salary,
sum(salary) over(order by salary)
from employee

-- -> ROW_NUMBER()
-- -> RANK()
-- -> DENSE_RANK()
-- -> LAG()
-- -> LEAD()

-- Row_number()
select 
	ROW_NUMBER() OVER(partition by dept)
	fname,dept,salary
	from employee

-- Rank() :- Gives same rank for ties --> Skips the next rank number 
select 
	RANK() OVER(order by salary desc),
	fname,salary
	from employee

-- DENSE_RANK() : Gives same rank for ties --> Does NOT skip rank numbers
select 
	DENSE_RANK() OVER(order by salary desc),
	fname,salary
	from employee

-- LAG() :- look backward (previous row)

select 
	fname,salary,
	LAG(salary) OVER()
	from employee;

-- LEAD() :- look forward (next row)

select 
	fname,salary,
	LEAD(salary) OVER()
	from employee;


-- IN real life it can help to show difference btw salary

select 
	fname,salary,
	(LEAD(salary) OVER(order by salary desc) - salary) AS salary_diff 
	from employee

select * from employee

-- CTE(Common Table Expression) is a temporary result set
-- that you can define within a query to simplify complex SQL
-- statements

-- use case 

-- --> We want to calculate the average salary per 
-- departent and then find all employees whose salary is
-- above the average salary of their department

-- Normal way using subquery
select fname,dept,salary from employee e
where e.salary > (select AVG(salary)
from employee 
where dept = e.dept);

WITH avg_salary AS(

select dept,AVG(salary) as avg_Sal from employee
GROUP BY dept
)
select 
e.emp_id , e.fname, e.dept, e.salary,a.avg_sal
from employee e
JOIN 
	avg_salary a
ON e.dept = a.dept
where e.salary>a.avg_sal;

-- USE cases - 2
-- --> we want find the highest paid employee in each
-- department

select fname,dept,salary 
from employee e
where salary = (select MAX(salary)
from employee
where dept = e.dept
);

WITH max_sal as (
select dept,MAX(salary) as max_salary from employee   GROUP BY dept
)
select e.fname, e.dept , m.max_salary
from employee e
JOIN max_sal m
ON m.dept = e.dept
where e.salary = m.max_salary;

-- -> Once CTE has been created it can only be used once. It will not be persisted

-- TRIGGERS
--> Triggers are special procedures in a database
-- that automatically execute prdefined actions in response
-- to certain events in a specified table or view

-- Use case
-- Create a Trigger so that if we insert/update negative salary
-- in a table, it will be triggerd and set it to 0

select * from employee
call update_emp_salary(1,-52000);

CREATE or REPLACE FUNCTION check_salary()
RETURNS TRIGGER AS $$
BEGIN 
	IF NEW.salary < 0 THEN
		NEW.salary =0;
	END IF ;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_update_salary
BEFORE UPDATE ON employee
FOR EACH ROW
EXECUTE FUNCTION check_salary();

CALL update_emp_salary(2,-25000)