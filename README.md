# DVD Rentals
This database represents the business processes of a DVD rental store.


## About the database 

The [database](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/) includes 15 tables, 1 trigger, 7 views, 8 functions, 1 domain, and 13 sequences. The tables are: 

`actor` – stores actors data including first name and last name. 

`film` – stores film data such as title, release year, length, rating, etc.

`film_actor` – stores the relationships between films and actors.

`category` – stores film’s categories data.

`film_category`- stores the relationships between films and categories.

`store` – contains the store data including manager staff and address.

`inventory` – stores inventory data.

`rental` – stores rental data.

`payment` – stores customer’s payments.

`staff` – stores staff data.

`customer` – stores customer data.

`address` – stores address data for staff and customers

`city` – stores city names.

`country` – stores country names.

## About the project 
Halloween is just over a week away and a DVD rental company would like to have more insights on films they rent to increase sales around the holiday. I explore the data and uncover insights using SQL. 

## Insights 

Most horror film have an MPAA rating of PG, PG-13, or R. Among the top five rented films, two are rated R, one PG-13, another PG, and the last is rated G while the top rented film is also rated G. To target younger audiences, we may want to include a few more G rated titles. The average rental duration for the top horror films is just under five days and so having a few extra copies of these films in inventory may be helpful. 

Currently, store #1 has 112 titles and store #2 has 136 horror titles and each store has one active staff member. It would be beneficial to hire at least another store associate for each location for the holiday. 

Customers can be marketed based on city, starting with cities whose name begins with A, B, or C. Currently, we have no customers in the system who have never rented a DVD from any of the stores. The are also no customers who are in the same household. This is important as we do not want to send duplicate marketing materials to people in the same household. 

