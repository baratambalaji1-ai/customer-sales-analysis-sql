CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1,'Rahul','Mumbai'),
(2,'Priya','Delhi'),
(3,'Amit','Hyderabad'),
(4,'Sneha','Chennai');

INSERT INTO orders VALUES
(101,1,'2025-01-10',5000),
(102,1,'2025-02-15',7000),
(103,2,'2025-01-20',2000),
(104,3,'2025-03-01',10000),
(105,3,'2025-03-15',8000),
(106,3,'2025-04-01',6000),
(107,4,'2025-02-10',1500);


-- BASIC AGGREGATION (SUM, COUNT)
-- Concept: JOIN + GROUP BY + SUM

-- Find Total Spending Per Customer
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Find Total Orders Per Customer

SELECT 
    c.customer_id,
    c.customer_name,
    count(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- MULTIPLE AGGREGATIONS TOGETHER

-- Combine Frequency + Total Spending
-- Concept: SUM + COUNT together
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS total_spent,
    COUNT(order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- SEGMENTATION (CASE STATEMENT)
--  Spending Based Segmentation
-- Concept: CASE + GROUP BY

-- Segmentation Based Only on Spending
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS total_spent,
    CASE
		when  SUM(o.amount) >= 15000 then 'High Value'
        when  SUM(o.amount) between 5000 and 14999 then 'Medium Value'
        else 'Low value'
	end as spending_segment
    FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- LEFT JOIN
-- Show All Customers (Even Without Orders)
-- Concept: LEFT JOIN

select  c.customer_id , customer_name  ,sum(o.amount)  as total_spending ,count(o.order_id) as total_orders
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.customer_id,c.customer_name;

-- Show Only Customers Who Never Ordered
 select customer_name 
 from customers c 
 left join orders o 
 on c.customer_id = o.customer_id
 where order_id is null;
 
 -- HAVING (Filtering Aggregated Data)
 
 -- Find customers who placed MORE THAN 2 orders.
 select  c.customer_id , customer_name   ,count(o.order_id)  as total_orders 
 from customers c 
 join orders o 
 on c.customer_id = o.customer_id 
 group by c.customer_id,c.customer_name
 having total_orders > 1;
   
--  High Spending + High Frequency
-- Concept: HAVING with multiple conditions  

select c.customer_id, customer_name , sum(o.amount) as total_spent, COUNT(o.order_id) AS total_orders
from customers c
join  orders o 
on c.customer_id = o.customer_id
group by c.customer_id, customer_name
having total_spent > 10000
and  total_orders > 2;


-- SORTING & LIMIT (Top N Analysis)
-- Top 2 Highest Spenders
-- Concept: ORDER BY + LIMIT

select c.customer_id, customer_name , sum(o.amount) as total_spent, COUNT(o.order_id) AS total_orders
from customers c 
left join orders o 
on c.customer_id = o.customer_id
group by c.customer_id, customer_name
order by total_spent desc
limit 2;

-- Top 2 Customers By Order Count
select c.customer_id, customer_name , sum(o.amount) as total_spent, COUNT(o.order_id) AS total_orders
from customers c 
left join orders o 
on c.customer_id = o.customer_id
group by c.customer_id, customer_name
order by total_orders desc
limit 2;

-- Average Order Value
-- Concept: SUM / COUNT

-- What is the average order value for each customer?
select c.customer_id, customer_name , sum(o.amount) as total_spent, COUNT(o.order_id) AS total_orders, SUM(o.amount)/COUNT(o.order_id) AS avg_order_value
from customers c 
 join orders o 
on c.customer_id = o.customer_id
group by c.customer_id, customer_name;

-- MAX / MIN Aggregation
-- Concept: MAX()
-- Largest Single Order Per Customer
SELECT 
    c.customer_name,
    MAX(o.amount) AS largest_order
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;




 
 
        
