use sales_forecasting;

select * from orders limit 5;

ALTER TABLE orders
ADD COLUMN ship_date_dt DATE;



UPDATE orders
SET ship_date_dt = STR_TO_DATE(TRIM(ship_date), '%d/%m/%y')
WHERE ship_date IS NOT NULL
  AND ship_date <> ''
  AND ship_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{2}$';
  
SELECT ship_date, ship_date_dt
FROM orders
LIMIT 10;

ALTER TABLE orders DROP COLUMN ship_date_dt;
--Checking cloumns--
SELECT *
FROM orders
LIMIT 10;
--Total rows---
SELECT COUNT(*) AS total_rows
FROM orders;

--Total Sales--
SELECT 
ROUND(SUM(sales), 2) AS total_sales
FROM orders;
--Total Orders--
SELECT 
COUNT(DISTINCT order_id) AS total_orders
FROM orders;

--Average Order Value---
SELECT 
ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM orders;

--Sales by Region--
SELECT 
region,
ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;


--Sales by category and sub category--
SELECT 
category,
sub_category,
ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY category, sub_category
ORDER BY total_sales DESC;


--Top 10 customers by sales--
SELECT 
customer_name,
ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

--Segment-wise sales--
SELECT 
segment,
ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;


--City-level Sales(Top 10)---
SELECT 
city,
ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;


--Shipping mode analysis--
SELECT 
ship_mode,
COUNT(DISTINCT order_id) AS total_orders,
ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY ship_mode
ORDER BY total_sales DESC;






--Classify Sales size---
SELECT 
order_id,
sales,
CASE
WHEN sales < 100 THEN 'Low'
WHEN sales BETWEEN 100 AND 500 THEN 'Medium'
ELSE 'High'
END AS sales_category
FROM orders
LIMIT 10;
