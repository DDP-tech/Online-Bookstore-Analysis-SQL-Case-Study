-- Online Bookstore Data Analysis
-- Tools: PostgreSQL
-- Description:
-- Description:
-- This SQL script presents structured solutions for fundamental and advanced
-- data analysis tasks conducted on an online bookstore dataset, emphasizing
-- customer behavior, sales performance, and stock optimization.


-- Create database
CREATE DATABASE online_book_store;

-- Create Tables

DROP TABLE IF EXISTS books;
CREATE TABLE books (
Book_ID	SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,	
Price NUMERIC(10, 2),	
Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(150),
Email VARCHAR(200),	
Phone VARCHAR(15),
City VARCHAR(100),
Country VARCHAR(100)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
Order_ID SERIAL PRIMARY	KEY,
Customer_ID	INT REFERENCES customers(Customer_ID),
Book_ID	INT REFERENCES books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);


-- Import data into books table
COPY
books (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'E:\Programming Testing\PostgreSQL Learning\ST - SQL ALL PRACTICE FILES\All Excel Practice Files\Books.csv'
DELIMITER ','
CSV HEADER;

-- Import data into customers table
COPY
customers (Customer_ID, Name, Email, Phone, City, Country)
FROM 'E:\Programming Testing\PostgreSQL Learning\ST - SQL ALL PRACTICE FILES\All Excel Practice Files\Customers.csv'
DELIMITER ','
CSV HEADER;

-- Import data into orders table
COPY
orders (Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'E:\Programming Testing\PostgreSQL Learning\ST - SQL ALL PRACTICE FILES\All Excel Practice Files\Orders.csv'
DELIMITER ','
CSV HEADER;


-- Basic Queries

-- 1) Retrieve all books in the "Fiction" genre
SELECT book_id,
		title,
		author,
		published_year,
		price,
		CASE
			WHEN stock > 0 THEN 'In Stock'
			ELSE 'Out of Stock'
		END AS availability
FROM books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950
SELECT book_id,
		title,
		author,
		genre,
		published_year,
		price,
		CASE
			WHEN stock > 0 THEN 'In Stock'
			ELSE 'Out of Stock'
		END AS availability
FROM books
WHERE published_year > 1950;

-- Using ORDER BY
SELECT book_id,
		title,
		author,
		genre,
		published_year,
		price,
		CASE
			WHEN stock > 0 THEN 'In Stock'
			ELSE 'Out of Stock'
		END AS availability
FROM books
WHERE published_year > 1950
ORDER BY published_year ASC;

-- 3) List all customers from the Canada
SELECT customer_id,
		name,
		email,
		phone,
		city
FROM customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023
SELECT order_id,
		customer_id,
		book_id,
		order_date,
		quantity,
		total_amount
FROM orders
WHERE order_date >= DATE '2023-11-01'
  AND order_date <  DATE '2023-12-01';

-- 5) Retrieve the total stock of books available
SELECT SUM(stock) AS total_books_stock
FROM books;

-- 6) Find the details of the most expensive book
SELECT book_id,
		title,
		author,
		genre,
		published_year,
		price,
		CASE
			WHEN stock > 0 THEN 'In Stock'
			ELSE 'Out of Stock'
		END AS availability
FROM books
ORDER BY price DESC
LIMIT 1;

-- Using MAX()
SELECT book_id,
		title,
		author,
		genre,
		published_year,
		price,
		CASE
			WHEN stock > 0 THEN 'In Stock'
			ELSE 'Out of Stock'
		END AS availability
FROM books
WHERE price = (
	SELECT MAX(price)
	FROM books
);

-- 7) Show all customers who ordered more than 1 quantity of a book
SELECT DISTINCT cus.customer_id,
		cus.name,
		cus.email,
		cus.phone,
		cus.city,
		cus.country
FROM customers cus
JOIN orders ord
ON cus.customer_id = ord.customer_id
WHERE quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20
SELECT order_id,
		customer_id,
		book_id,
		order_date,
		quantity,
		total_amount
FROM orders
WHERE total_amount > 20;

-- 9) List all genres available in the Books table
SELECT DISTINCT genre
FROM books;

-- 10) Find the book with the lowest stock
SELECT book_id,
		title,
		author,
		genre,
		published_year,
		price,
		stock
FROM books
ORDER BY stock ASC
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;


-- Advance Queries

-- 1) Retrieve the total number of books sold for each genre
SELECT bok.genre,
       COALESCE(SUM(ord.quantity), 0) AS books_sold
FROM books bok
LEFT JOIN orders ord
ON bok.book_id = ord.book_id
GROUP BY bok.genre
ORDER BY books_sold DESC;

-- 2) Find the average price of books in the "Fantasy" genre
SELECT COALESCE(ROUND(AVG(price), 2), 0) AS average_price
FROM books
WHERE genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders
SELECT cus.customer_id,
		cus.name,
		cus.email,
		cus.phone,
		cus.city,
		cus.country,
		COUNT(ord.order_id) AS number_of_orders
FROM customers cus
JOIN orders ord
ON cus.customer_id = ord.customer_id
GROUP BY cus.customer_id,
		 cus.name,
		 cus.email,
		 cus.phone,
		 cus.city,
		 cus.country
HAVING COUNT(ord.order_id) >= 2
ORDER BY number_of_orders DESC;

-- 4) Find the most frequently ordered book
SELECT bok.book_id,
		bok.title,
		bok.author,
		bok.genre,
		bok.published_year,
		bok.price,
		bok.stock,
		COUNT(ord.order_id) AS number_of_orders
FROM books bok
LEFT JOIN orders ord
ON bok.book_id = ord.book_id
GROUP BY bok.book_id,
		 bok.title,
		 bok.author,
		 bok.genre,
		 bok.published_year,
		 bok.price,
		 bok.stock
ORDER BY number_of_orders DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre
SELECT book_id,
		title,
		author,
		published_year,
		price,
		CASE
			WHEN stock > 0 THEN 'In Stock'
			ELSE 'Out of Stock'
		END AS availability
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author
SELECT bok.author,
		COALESCE(SUM(ord.quantity), 0) AS quantity_sold
FROM books bok
LEFT JOIN orders ord
ON bok.book_id = ord.book_id
GROUP BY bok.author
ORDER BY quantity_sold DESC;

-- 7) List the cities where customers who spent over $30 are located
SELECT DISTINCT cus.city,
		SUM(ord.total_amount) AS amount_spent
FROM customers cus
JOIN orders ord
ON cus.customer_id = ord.customer_id
GROUP BY cus.customer_id,
		 cus.city
HAVING SUM(ord.total_amount) > 30
ORDER BY amount_spent DESC,
		 cus.city;

-- Using CTE
WITH customer_spending AS (
	SELECT customer_id,
			SUM(total_amount) AS amount_spent
	FROM orders
	GROUP BY customer_id
)
SELECT DISTINCT cus.city,
		cusp.amount_spent
FROM customers cus
JOIN customer_spending cusp
ON cus.customer_id = cusp.customer_id
WHERE cusp.amount_spent > 30
ORDER BY cusp.amount_spent DESC,
		 cus.city;

-- 8) Find the customer who spent the most on orders
SELECT cus.customer_id,
		cus.name,
		cus.email,
		cus.phone,
		cus.city,
		cus.country,
		SUM(ord.total_amount) AS amount_spent
FROM customers cus
JOIN orders ord
ON cus.customer_id = ord.customer_id
GROUP BY cus.customer_id,
		cus.name,
		cus.email,
		cus.phone,
		cus.city,
		cus.country
ORDER BY amount_spent DESC,
		 cus.customer_id ASC
LIMIT 1;

-- Using DENSE_RANK()
SELECT *
FROM (
	SELECT cus.customer_id,
			cus.name,
			cus.email,
			cus.phone,
			cus.city,
			cus.country,
			SUM(ord.total_amount) AS amount_spent,
			DENSE_RANK() OVER (ORDER BY SUM(ord.total_amount) DESC) AS rnk
	FROM customers cus
	JOIN orders ord
	ON cus.customer_id = ord.customer_id
	GROUP BY cus.customer_id,
			 cus.name,
			 cus.email,
			 cus.phone,
			 cus.city,
			 cus.country
) ranked
WHERE rnk = 1;

-- 9) Calculate the stock remaining after fulfilling all orders
SELECT bok.book_id,
		bok.title,
		bok.author,
		bok.genre,
		bok.published_year,
		bok.price,
		GREATEST (
			bok.stock - COALESCE(SUM(ord.quantity), 0), 
			0 
		) AS available_stocks
FROM books bok
LEFT JOIN orders ord
ON bok.book_id = ord.book_id
GROUP BY bok.book_id,
		 bok.title,
		 bok.author,
		 bok.genre,
		 bok.published_year,
		 bok.price,
		 bok.stock
ORDER BY available_stocks DESC,
		 bok.book_id;
