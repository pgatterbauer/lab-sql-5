# Lab | SQL Queries 5

#In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. You have been using this database for a couple labs already, 
#but if you need to get the data again, refer to the official [installation link](https://dev.mysql.com/doc/sakila/en/sakila-installation.html).

#The database is structured as follows:
#![DB schema](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/database-sakila-schema.png)


### Instructions
   
   
#   *** start exercise ***


USE sakila;

#1. Drop column `picture` from `staff`.
ALTER TABLE staff
DROP COLUMN picture;

#2. A new person is hired to help Jon. Her name is TAMMY SANDERS, 
# and she is a customer. Update the database accordingly.

SELECT * FROM customer
WHERE first_name = 'TAMMY';

-- inserat values automatically
INSERT INTO staff 
VALUES(3,'Tammy','Sanders',79,'tammy.sanders@sakilacustomer.org',2,1,'Tammy','','2022-02-05 10:34:09');



SELECT * FROM staff;

#3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
# You can use current date for the `rental_date` column in the `rental` table.
#   **Hint**: Check the columns in the table rental and see what information you would 
# need to add there. You can query those pieces of information. For eg., 
#   you would notice that you need `customer_id` information as well. 
# To get that you can use the following query:

#    ```sql
#    select customer_id from sakila.customer
#    where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
#    ```
#    
#    Use similar method to get `inventory_id`, `film_id`, and `staff_id`, last_update = 2006-02-15 05:03:42

-- first: get all the values in the columns from rental
-- film_id = 1 , inventory_id = 1, staff_id = 1, last update = getdate()

SELECT MAX(rental_id) FROM rental;
SELECT * FROM film WHERE title = "Academy Dinosaur"; 

INSERT INTO rental 
VALUES(16050,'2005-05-31 00:46:31',1,130,'2005-06-15 00:46:31',1,'2006-02-15 05:03:42');


#4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

#   - Check if there are any non-active users
#   - Create a table _backup table_ as suggested
#   - Insert the non active users in the table _backup table_
#   - Delete the non active users from the table _customer_


SELECT * FROM customer;

#   - Check if there are any non-active users
SELECT DISTINCT customer.active FROM customer;

-- get data from inactive users
SELECT customer.active FROM customer
WHERE customer.active = 0;

-- count inactive users
SELECT count(customer.active) FROM customer
WHERE customer.active = 0; -- 15 rows


CREATE TABLE deleted_users (
  customer_id INT(11) DEFAULT NULL,
  email TEXT,
  create_date DATETIME
);

SELECT * FROM deleted_users;


#   - Insert the non active users in the table _backup table_
INSERT INTO deleted_users (customer_id, email, create_date)
SELECT customer_id, email, create_date
FROM customer
WHERE customer.active = 0;

SELECT * FROM deleted_users;
