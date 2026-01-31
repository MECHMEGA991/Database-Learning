CREATE DATABASE college;

use college;

CREATE TABLE students
( roll_no INT PRIMARY KEY,
name VARCHAR(50),
marks INT ,
grade VARCHAR(1),
city  VARCHAR(50)
);

drop table students;
INSERT INTO students(roll_no , name , marks , grade , city)
values
(101 , "Abhinav" ,78 , "C" , "Pune" ),
(102 , "Rakesh" ,93 , "A" , "Delhi" ),
(103 , "Cheatan" ,85 , "B" , "Delhi" ),
(104 , "Dhruv" ,96 , "A" , "Mumbai" ),
(105 , "Adam" ,20 , "D" , "Pune" ),
(106 , "Abhimanyu Rathore" ,55 , "C" , "Rajashtan" );

SELECT * FROM students where marks BETWEEN 80 AND 99 ;
SELECT * FROM students where city IN ("Delhi" , "Mumbai");
SELECT * FROM students where city NOT IN ("Delhi" , "Mumbai");
SELECT * FROM students where marks >50 LIMIT 3;
SELECT * FROM
students 
ORDER BY marks DESC
LIMIT 3; -- Top 3 highest marks

-- Aggregate Function
SELECT count(name) FROM students ;
SELECT max(marks) FROM students;
SELECT min(marks) FROM students;
SELECT sum(marks) FROM students;
SELECT avg(marks) FROM students;

-- Group by clause
-- count no. of students in each city

SELECT city , count(name) 
FROM students 
GROUP BY city ;

-- avg marks of students group by city

SELECT city , avg(marks)
FROM students
GROUP BY city;

-- write the query to find avg marks in each city in ascending order

SELECT city  , avg(marks)
FROM students
GROUP BY city
ORDER BY city ASC
limit 3;

CREATE TABLE payment
(
customer_id int primary key,
customer varchar(50),
mode  varchar(50) ,
city varchar(50)
);
drop table payment;
INSERT INTO 
payment(customer_id , customer , mode , city)

VALUES
(101 , "Olivia" , "Net banking " , "Poland"),
(102 , "Ramesh" , "credit card " , "Delhi"),
(103 , "Rohan" , "Debit card " , "Uttrakhand"),
(104 , "Bob" , "Debit card " , "Mumbai"),
(105 , "Alish" , "credit card " , "Boston"),
(106 , "Rahul" , "Net banking " , "Tamil nadhu"),
(107 , "Abishek" , "credit card " , "Kerala"),
(108, "Rajni" , "Net banking " , "Telengana");

SELECT * FROM payment;

-- Total payment according to payment method

SELECT mode , count(mode)
from payment 
group by mode;

SELECT * FROM students;
-- Having clause 
-- same as where clause( condtion on rows) but used to apply condition on group by 

-- Count number of students in each city where max marks cross 90
-- ALL THE CLAUSE USE THIS SEQUENCE
SELECT city , count(name)
FROM students
GROUP BY city
having max(marks)>90
ORDER by city DESC;
 
 -- TABLE RELATED QUERY
-- UPDATE to update existing rows
-- safe mode off code -> 
SET SQL_SAFE_UPDATES=0;
SET SQL_SAFE_UPDATES=1;

UPDATE students
set grade = "O"
WHERE grade="A";

update students 
SET grade = CASE
WHEN grade = "A" THEN "O"
WHEN grade = "B" THEN "P"		
          END
where grade IN ("A" ,"P");

SELECT * FROM students;

update students
SET marks = marks+1;

SELECT *FROM students;

-- delete use very carefully it cant be reteive
-- DELETE FROM students
-- where marks<33;

-- FOREIGN KEY
 
 -- Parent table
 CREATE TABLE dept
 ( id INT PRIMARY KEY,
   name VARCHAR(50) 
   );
 
 INSERT INTO 
 dept(id, name )
 VALUES
 (101,"Science"),
 (102, "English"),
 (103,"Hindi");
 
 -- Child table
  CREATE TABLE teacher
 ( id INT PRIMARY KEY,
   name VARCHAR(50) ,
   dep_id INT ,
   FOREIGN KEY (dep_id) references dept(id)
   ON UPDATE CASCADE
   ON DELETE CASCADE
   );
   
   drop table teacher;
   drop table dept;
 
 INSERT INTO 
 teacher(id, name , dep_id)
 VALUES
 (101,"Adam",101),
 (102, "Bob",102),
 (103,"Rashmika",103),
 (104,"Gungun",101);
 
 UPDATE dept
 set id = 104
 where id = 102;
 
 select * from dept;
 select * from teacher;

delete from dept
where id = 103;

INSERT INTO students(roll_no , name , marks , grade , city)
values
(101 , "Abhinav" ,78 , "C" , "Pune" ),
(102 , "Rakesh" ,93 , "A" , "Delhi" ),
(103 , "Cheatan" ,85 , "B" , "Delhi" ),
(104 , "Dhruv" ,96 , "A" , "Mumbai" ),
(105 , "Adam" ,20 , "D" , "Pune" ),
(106 , "Abhimanyu Rathore" ,55 , "C" , "Rajashtan" );

truncate table students;
-- alter ( to change the schema )

select * from students;

-- add column
alter table students
add column age INT NOT NULL DEFAULT 10;

-- modify column type
alter table students
modify column age varchar(10) ;

-- change name 
alter table students 
change age stu_age varchar(10);

-- drop column name 
alter table students
drop column stu_age;

-- rename column name
alter table students 
rename column stu_age TO age;

-- TRUNCATE (to delete table data)

truncate table students ;

-- practice que

select * from students;

alter table students
change name full_name varchar(50) ;

delete from students 
where marks < 80;

alter table students 
drop column grade;

-- joins in sql
-- join is used to combine rows from two or more tables , based on a related column between them 

-- Inner join 

 -- Parent table
 CREATE TABLE dept
 ( id INT PRIMARY KEY,
   name VARCHAR(50) 
   );
 
 INSERT INTO 
 dept(id, name )
 VALUES
 (101,"Science"),
 (102, "English"),
 (103,"Hindi");
 
 -- Child table
  CREATE TABLE teacher
 ( id INT PRIMARY KEY,
   name VARCHAR(50) ,
   dep_id INT ,
   FOREIGN KEY (dep_id) references dept(id)
   ON UPDATE CASCADE
   ON DELETE CASCADE
   );
   
   drop table teacher;
   drop table dept;
 
 INSERT INTO 
 teacher(id, name , dep_id)
 VALUES
 (101,"Adam",102),
 (102, "Bob",103),
 (103,"Rashmika",103),
 (104,"Gungun",102);
 
 
 
 select * from dept;
 select * from teacher;
 
 -- alias alter name
select *
from dept as d
inner join teacher as t
on d.id = t.id;

-- Left join

select * 
from dept
Left join teacher 
on dept.id =  teacher.id;

-- right join

select * 
from dept
right join teacher 
on dept.id =  teacher.id;

-- full join
select * from dept
left join teacher
on dept.id = teacher.id
UNION
select * from dept
right join teacher
on dept.id = teacher.id;

create table student2
( id int primary key,
name varchar(50) 
);

insert into 
student2(id , name)
values
(101, "Adam"),
(102, "Bob"),
(103, "Casey");

create table course
( id int primary key,
course varchar(50) 
);

drop table course;
insert into 
course(id , course)
values
(102, "english"),
(105, "math"),
(103, "science"),
(107, "computer science");

-- left exclusive join

-- 101
select * 
from student2 as s2
left join course as c
on s2.id = c.id
where c.id is null;

-- 105 , 107
select *
from student2 as s
right join course as b
on s.id = b.id
where s.id is null;

-- 102 , 103
select * 
from student2 as s2
left join course as c
on s2.id = c.id
where c.id is not null;

-- self join
-- its a regular join but the table is joined with table

create table employee 
(id Int primary key,
name Varchar(50) ,
manager_id int 
);

insert into 
employee (id , name , manager_id)
values
(101 , "adam" , 103),
(102 , "Rahul" , 104),
(103 , "Casey" , null),
(104 , "Priyank" , 103);

select b.name , a.name as manage_name
from employee as a
join employee as b
on a.id = b.manager_id;

-- union 
-- give all unique value


-- union all
-- gives all duplicate value

-- select name from table a 
-- union , union all
-- selct name from table b 

-- subquery -> nested query , inner query


CREATE TABLE students
( roll_no INT PRIMARY KEY,
name VARCHAR(50),
marks INT ,
grade VARCHAR(1),
city  VARCHAR(50)
);

drop table students;
INSERT INTO students(roll_no , name , marks , grade , city)
values
(101 , "Abhinav" ,78 , "C" , "Pune" ),
(102 , "Rakesh" ,93 , "A" , "Delhi" ),
(103 , "Cheatan" ,85 , "B" , "Delhi" ),
(104 , "Dhruv" ,96 , "A" , "Mumbai" ),
(105 , "Adam" ,20 , "D" , "Pune" ),
(106 , "Abhimanyu Rathore" ,55 , "C" , "Rajashtan" );

-- Find the avg marks
-- then find the names of students with marks > avg
-- dynamic subquery

select avg(marks) 
from students;


select name , marks
from students
where marks > (select avg(marks) from students);

-- find the names of all students whose roll no. even

select name, roll_no
from students
where roll_no % 2 = 0 ;

-- write subquery from where
select name , roll_no
from students 
where roll_no in (Select roll_no from students where roll_no % 2 = 0);

-- with using FROM
-- find max marks from students of delhi

select max(marks)
from (select *from students where city in ("Delhi") )as temp;

-- with select 
SELECT(select max(marks) from students) as max_marks , name from students;

-- Mysql views 
-- virtual table 

DROP VIEW IF EXISTS view1;
create view view1 as
select roll_no , name , marks
from students;

select * from view1
where marks >80;





 
 
 
 
 

