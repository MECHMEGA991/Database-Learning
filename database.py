import sqlite3

# conn=sqlite3.connect(':memory:') # It is temporary database

conn=sqlite3.connect('customer.db')

# Create cursor
c = conn.cursor()

# Create table

c.execute(""" CREATE TABLE IF NOT EXISTS customer(

		first_name text,
		last_name  text,
		email  	   text


		)""")

# Datatype in sqlite
# NULL
# Integer
# Real 
# Text
# Blob - image,video

#Insert Many customer details once

# many_customer =[
# 					('ALice','Brown','alice7@gmail.com'),
# 					('Steph','Hawkins','steph54@gmail.com'),
# 					('Dan','Pers','dan11@gamil.com'),
# 				]

# c.execute("""INSERT INTO customer(first_name, last_name, email) 
# 	Values ('Rohan','mehta','rohan05@gmail.com')""")

# c.executemany("INSERT INTO customer Values(?,?,?)",many_customer)

# Query The database and Fectch

# c.execute("SELECT * FROM customer")
# print(c.fetchone())
# print(c.fetchone()[0]) # U can access specific 
# print(c.fetchmany(3))

# print(c.fetchall()[0]) # It will fetch first tuple

# using loop

# items=c.fetchall()

# for i in items:
# 	print(i)


# for i in items:
# 	print(i[0]+" "+ i[1] +"\t\t"+ i[2])

# Primary Id

# c.execute("SELECT rowid, * FROM customer")
# items=c.fetchall()

# for i in items:
# 	print(i)

# WHERE Clause

# c.execute("SELECT * FROM customer where email LIKE '%@gmail.com'")
# c.execute("SELECT * FROM customer where first_name LIKE '%alice'")
# c.execute("SELECT * FROM customer where last_name LIKE '%snow'")

# c.execute("SELECT * FROM customer where email LIKE '%alice7@gmail.com'")
# items=c.fetchall()
# for i in items:
# 	print(i)



print("command executed succesfully")


# UPDATE Records

# c.execute("""
# 		UPDATE customer SET first_name ='Tarak'
# 			where last_name ='mehta'
# 	""")

# Instead of this we use rowid


# c.execute("""
# 		UPDATE customer SET first_name ='Tarak'
# 			where rowid=3
# 	""")


# conn.commit()
# c.execute("SELECT rowid, * FROM customer")
# # c.execute("SELECT * FROM customer")
# item=c.fetchall()
# for i in item:
# 	print(i)


# DELETE Records

# c.execute("DELETE from customer WHERE rowid=7")

# conn.commit

# c.execute("SELECT rowid , * FROM customer")

# item=c.fetchall()

# for i in item:
# 	print(i)

# ORDER BY -by default ASC

# c.execute("SELECT rowid, * FROM customer order by rowid DESC")
# c.execute("SELECT rowid, * FROM customer order by first_name ASC")

# item=c.fetchall()
# for i in item:
# 	print(i)

# AND / OR

# c.execute("SELECT rowid,* FROM customer where last_name like 'Bro%' and rowid=5 ")
# c.execute("SELECT rowid,* FROM customer where last_name like 'Bro%' or rowid=5 ")

# item =c.fetchall()
# for i in item:
# 	print(i)

# LIMITING Result

# c.execute("SELECT rowid,* FROM customer limit 1 offset 1")
# c.execute("SELECT rowid,* FROM customer order by rowid ASC limit 1 offset 1") # SECOND highest by using offset

# item =c.fetchall()
# for i in item :
# 	print(i)

# DROP TABLE

# c.execute("DROP TABLE customer")
# conn.commit


# Commit our command

conn.commit()

# Close connection

conn.close()






# Create table

# c.execute(""" CREATE TABLE IF NOT EXISTS customers(

# 		name text,
# 		roll_no integer,
# 		status text
# 		)
# 		""")

# # Using Many to get value
# many_customers=[

# 			('Rahul kumar' , 24 , 'Pass' ),
# 			('Ramesh Rathore' , 28 , 'Pass'),
# 			('Alice Sharma' , 30, 'Fail'),
# 			('Jhon Snow' , 35 , 'Pass'),
# 			('Bob Drawn' , 40 ,'Fail'),
# 			('Sanik Green ', 45 ,'Fail'),
# 				]