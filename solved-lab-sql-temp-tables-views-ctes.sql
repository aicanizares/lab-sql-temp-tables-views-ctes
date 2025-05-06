# In this exercise, you will create a customer summary report that summarizes key information about customers in the Sakila database, including their rental history and payment details. The report will be generated using a combination of views, CTEs, and temporary tables

# Step 1: Create a View
# First, create a view that summarizes rental information for each customer. The view should include the customer's ID, name, email address, and total number of rentals (rental_count).
USE sakila;


CREATE VIEW rental_information_summary AS
SELECT customer_id, first_name, last_name, email, COUNT(rental_id) AS rental_count
FROM customer
INNER JOIN rental
USING (customer_id)
GROUP BY customer_id
ORDER BY customer_id ASC;

SELECT *
FROM rental_information_summary;

# Step 2: Create a Temporary Table
# Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). The Temporary Table should use the rental summary view created in Step 1 to join with the payment table and calculate the total amount paid by each customer.

CREATE TEMPORARY TABLE total_paid AS
SELECT customer_id, first_name, last_name, email, COUNT(rental_id) AS rental_count, SUM(amount) as total_amount_paid
FROM rental_information_summary
INNER JOIN payment
USING (customer_id)
GROUP BY customer_id
ORDER BY customer_id ASC;

# Step 3: Create a CTE and the Customer Summary Report
# WITH customer_summary_report AS (
#    SELECT statement
# )
# SELECT * FROM cte_name;

SELECT first_name, last_name, email, COUNT(rental_id) AS rental_count, SUM(amount) as total_amount_paid
FROM rental_information_summary
INNER JOIN total_paid
USING (customer_id)
GROUP BY customer_id
ORDER BY customer_id ASC;


