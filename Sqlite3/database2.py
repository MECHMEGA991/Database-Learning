import sqlite3

# Function to show all records

def show_all():
    conn = sqlite3.connect('customers.db')
    c = conn.cursor()

    # Select all records
    c.execute("SELECT rowid,* FROM customers")
    items = c.fetchall()

    for i in items:
        print(i)


    conn.commit()

    conn.close()

def add_one(name,roll,status):

    conn = sqlite3.connect('customers.db')
    c = conn.cursor()

    c.execute("INSERT INTO customers values(?,?,?)", (name,roll,status))

    conn.commit()
    conn.close()


# Add many records in the list

def add_many(list):

    conn=sqlite3.connect('customers.db')

    c=conn.cursor()

    c.executemany("INSERT INTO customers VALUES (?,?,?)",list)

    conn.commit()
    conn.close()

# Delete record from database

def delete_one(id):
    
    conn=sqlite3.connect('customers.db')
    c=conn.cursor()

    c.execute("DELETE FROM customers where rowid = ?",(id,))  #we use (id,) to make it tuple with one element

    conn.commit()
    conn.close()


# Check the Status who Pass and Fail

def status_lookup(status):

    conn=sqlite3.connect('customers.db')

    c=conn.cursor()

    c.execute("SELECT rowid,* FROM customers WHERE status = (?)",(status,))

    result=c.fetchall()

    for i in result:
        print(i)

    # conn.commit()
    conn.close()
