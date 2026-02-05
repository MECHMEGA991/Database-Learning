-- Creating a one-to-many and many-to-many relationship
--in a shopping stor context using four tables:

-- > customers
-- > orders
-- > products
-- > order_items

-- Include a price column in the products table and display
-- the relationship between customers and their orders
-- along with the details of the products in each order.

-- Creating Table

CREATE TABLE customers(

		cus_id SERIAL PRIMARY KEY,
		cus_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders(

		ord_id SERIAL PRIMARY KEY,
		ord_date DATE NOT NULL,
		cus_id INTEGER NOT NULL,
		FOREIGN KEY (cus_id) REFERENCES customers(cus_id)

);

CREATE TABLE products (

		p_id SERIAL PRIMARY KEY,
		p_name VARCHAR(100) NOT NULL,
		price NUMERIC NOT NULL

);

CREATE TABLE order_items (

		item_id SERIAL PRIMARY KEY,
		ord_id 	INTEGER NOT NULL,
		p_id 	INTEGER NOT NULL,
		quantity   INTEGER NOT NULL,
		FOREIGN KEY (ord_id) REFERENCES orders(ord_id),
		FOREIGN KEY (p_id) REFERENCES products(p_id)
);

-- Inserting the data 

INSERT INTO customers(cus_name)
VALUES ('Raju'), ('Sham'), ('Paul'), ('Alex');

INSERT INTO orders(ord_date,cus_id)
VALUES ('2024-01-01', 1),
	   ('2024-02-01', 2),
	   ('2024-03-01', 3),
	   ('2024-04-04', 2);

INSERT INTO products (p_name,price)
VALUES ('Laptop',55000.00),
	   ('Mouse',500.00),
	   ('Keyboard',800.00),
	   ('Cable',250.00);

INSERT INTO order_items(ord_id,p_id,quantity)
VALUES (1,1,1), -- Raju ordered 1 Laptop
	   (1,4,2), -- Raju ordered 2 Cables
	   (2,1,1),
	   (3,2,1),
	   (3,4,5),
	   (4,3,1);

-- Connecting table

select * from order_items;

select c.cus_name , p.p_name, p.price, oi.quantity , o.ord_date from order_items as oi
JOIN products as p
ON oi.p_id = p.p_id
JOIN orders as o
ON oi.ord_id = o.ord_id
JOIN customers as c
ON c.cus_id = o.cus_id;

-- Enhance Table

CREATE VIEW billing_info as

select c.cus_name, o.ord_date  , p.p_name, p.price, oi.quantity 
		,(oi.quantity * p.price) as total_price
from order_items as oi

JOIN products as p
ON oi.p_id = p.p_id

JOIN orders as o
ON oi.ord_id = o.ord_id

JOIN customers as c
ON c.cus_id = o.cus_id;

select * from billing_info





	   

	 