import Sqlite3.database2 as database2


# ADD_ONE data into the database2

# database2.add_one("Aarushi srivastav",50,"Pass")


# Add many record using list

list=[
		("Randa Rodes",60,"Fail"),
		("Washington",65,"Pass"),
	]

# database2.add_many(list)



# Delete the data from the database2

# database2.delete_one('8')


# Lookup using where clause

database2.status_lookup("Fail")


# Show all the Database

# database2.show_all()

