-- Creating Table

CREATE TABLE person(

	id INT,
	name VARCHAR(100),
	city VARCHAR(100)

);

-- Inserting data 

INSERT INTO person(id , name,city)
VALUES
(101,'Raju','Delhi'),
(102,'Sham','Mumbai'),
(103,'Paul','Chennai'),
(104,'Alex','Pune')

-- Read the data 

SELECT * FROM person 
SELECT name,city FROM person

-- Updating Table

UPDATE person
	SET city='London'
	-- WHERE id=2;
	where
	name = 'Paul'

SELECT * FROM person;

-- Deleting from tabel

SELECT * FROM person;

DELETE FROM person
where 
id=104;

SELECT *FROM person;

INSERT INTO person
-- VALUES(101,'Bob','New York')
VALUES(105,'Rohan') -- We got null to solve this we use constraints


-- ALTERING Table


-- ALTER Table add column

ALTER Table person
ADD COLUMN age INT DEFAULT 0;

-- Drop Column

ALTER TABLE person
DROP COLUMN age;

-- RENAME column

ALTER TABLE person
RENAME COLUMN age to ages

-- RENAME table name

ALTER TABLE persons
RENAME to person

-- Modifying table

ALTER TABLE person
ALTER COLUMN name
SET DATA TYPE VARCHAR(50);


ALTER TABLE person
ALTER COLUMN ages
SET DEFAULT 18

ALTER TABLE person
ALTER COLUMN ages
DROP DEFAULT 

-- CHECK CONSTRAINS

ALTER TABLE person
ADD COLUMN
	mob VARCHAR(15)
		CHECK (LENGTH(mob)>=10);

INSERT INTO person(mob)
VALUES(12345678) -- Shows error

-- DROP CONSTRAINS

ALTER TABLE person
DROP constraint person_mob_check

-- NAMED CONSTRAINTS
ALTER TABLE person
ADD CONSTRAINT mob_no_less_than_10
	CHECK (LENGTH(mob)>=10);
	

select * from person











