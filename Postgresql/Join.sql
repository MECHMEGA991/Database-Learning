CREATE TABLE customers(
		cus_id SERIAL PRIMARY KEY,
		cus_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders(

		ord_id SERIAL PRIMARY KEY,
		ord_date DATE NOT NULL,
		price NUMERIC NOT NULL,
		cus_id INTEGER NOT NULL,
		FOREIGN KEY(cus_id) REFERENCES
		customers(cus_id)
);

-- drop table orders
-- DROP table customers

INSERT INTO customers(cus_name)
VALUES ('Raju'),('Sham'),('Paul'),('Alex');


INSERT INTO orders(ord_date,cus_id,price)
VALUES ('2024,01,01',1,250.00),
	   ('2024-01-15',1,300.00),
	   ('2024-02-01',2,150.00),
	   ('2024-03-01',3,450.00),
	   ('2024-04-04',2,550.00);

-- Join operation is used to combine rows from two or 
-- or more tables based on a related column btw them

-- Types of Joins 

--- Cross Join :-  Every row from one table is combined with every row from another table
--- Inner Join :-  Returns only the rows where there is a match btw specified columns in both the left(or first) and right (or second) tables
--- Left  Join :-  Returns all the rows from the left(or first) table and the matching rows from the right(or second) table 
--- Right Join :-  Returns all the rows from the right(or second) table and the matching rows from the left (or first) table

-- It is not very useful
select * from customers
CROSS JOIN 
orders

-- Inner Join
-- Only related shows eg- Alex data not shown becz alex doesnt order anything 

select * from customers as c
INNER JOIN
orders as o
ON c.cus_id = o.cus_id;

-- Inner Joins using Group by

select c.cus_name , SUM(o.price) from customers as c
INNER JOIN 
orders as o
ON c.cus_id = o.cus_id
GROUP BY cus_name

-- Left join

select * from customers c
LEFT JOIN 
orders as o
ON c.cus_id = o.cus_id

-- Right Join

select * from customers c
RIGHT JOIN
orders o
ON c.cus_id = o.cus_id

-- MANY : MANY :- Student and courses

CREATE TABLE students(
		st_id SERIAL PRIMARY KEY,
		name VARCHAR(50) NOT NULL
);

CREATE TABLE courses(
		c_id SERIAL PRIMARY KEY,
		name VARCHAR(50) NOT NULL,
		fee NUMERIC NOT NULL
	
);

CREATE TABLE enrollment(
		en_id SERIAL PRIMARY KEY,
		s_id INT NOT NULL,
		c_id INT NOT NULL,
		en_date DATE NOT NULL,
		FOREIGN KEY (s_id) REFERENCES students(st_id),
		FOREIGN KEY (c_id)  REFERENCES courses(c_id)

);

Drop table enrollment;

INSERT INTO students(name)
VALUES ('Raju'),('Sham'),('Alex');

INSERT INTO courses(name ,fee)
VALUES ('Maths',500.00),
	   ('Physics',600.00),
	   ('Chemistry',700.00);

INSERT INTO enrollment(s_id,c_id,en_date)
VALUES (1,1,'2024-01-01'),  -- Raju enrolled in Maths
	   (1,2,'2024-01-15'),	-- Raju enrolled in Physics
	   (2,1,'2024-02-01'),  -- Sham enrolled in Maths
	   (2,3,'2024-02-15'),	-- Sham enrolled in Chemistry
	   (3,3,'2024-03-25');	-- Sham enrolled in Chemistry

select s.name,c.name,c.fee from enrollment e
JOIN students s 
ON e.s_id = s.st_id
JOIN courses c
ON e.c_id = c.c_id;

-- Practice Inner join also can write as JOIN
-- Total purchase by person
select s.name,SUM(c.fee) from enrollment e
JOIN students s 
ON e.s_id = s.st_id
JOIN courses c
ON e.c_id = c.c_id
GROUP BY s.name

-- Total course buy each students

select s.name, COUNT(c.c_id) as total
from enrollment e
JOIN students s
ON e.s_id = s.st_id
JOIN courses c
ON e.c_id = c.c_id
Group by s.name;

create view course_info as 

select s.name as student_name ,c.name as course_name,c.fee from enrollment e
JOIN students s 
ON e.s_id = s.st_id
JOIN courses c
ON e.c_id = c.c_id;

select * from course_info

-- HAVING CLAUSE
-- It is used in group by

select student_name,sum(fee) from 
course_info
GROUP BY Student_name
-- where sum(fee)>1000; -- It shows error 
HAVING sum(fee)>1000;   -- It will work

-- select student_name from 
-- (select student_name,sum(fee) as total_fee
-- from course_info
-- GROUP BY student_name
-- ) 
-- where total_fee>1000

-- ROLLUP

select COALESCE(student_name,'Total') AS student_name,sum(fee) as total
from course_info
GROUP BY ROLLUP(student_name)
order by total ASC;












