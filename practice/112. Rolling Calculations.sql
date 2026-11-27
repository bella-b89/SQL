-- Assignment: Rolling Caculations
-- Email from Mandy
-- We have one final request for you
-- Can you help us generate a report that shows the total sales for each month,
-- as well as the cumulative sum of sales and the six-month moving average of sales?

-- let's organize it
SELECT year(order_date) AS yr,
		MONTH(order_date) AS mnth,
		unit_price * units AS amount
FROM orders AS o
LEFT JOIN products AS p
	ON o.product_id = p.product_id;

-- 1. total sales for each month
WITH ts AS (SELECT year(order_date) AS yr,
					MONTH(order_date) AS mnth,
					unit_price * units AS amount
			FROM orders AS o
			LEFT JOIN products AS p
				ON o.product_id = p.product_id)
SELECT yr, mnth, 
		sum(amount)
FROM ts
GROUP BY yr, mnth;

-- 2. cumulative sum of sales

WITH ts AS (SELECT year(order_date) AS yr,
					MONTH(order_date) AS mnth,
					unit_price * units AS amount
			FROM orders AS o
			LEFT JOIN products AS p
				ON o.product_id = p.product_id),
	cs AS (SELECT yr, mnth, 
			sum(amount) AS total_sales	
			FROM ts
			GROUP BY yr, mnth)
SELECT 	yr, mnth,total_Sales,
		SUM(total_sales) over(ORDER BY yr, mnth) AS cumulative_sum,
		
FROM cs;

-- 3. Cumulative six-month moving average of sales

WITH ts AS (SELECT year(order_date) AS yr,
					MONTH(order_date) AS mnth,
					unit_price * units AS amount
			FROM orders AS o
			LEFT JOIN products AS p
				ON o.product_id = p.product_id),
	cs AS (SELECT yr, mnth, 
			sum(amount) AS total_sales	
			FROM ts
			GROUP BY yr, mnth)
SELECT 	yr, mnth,total_Sales,
		SUM(total_sales) over(ORDER BY yr, mnth) AS cumulative_sum,
		ROUND(avg(total_Sales) over(ORDER BY yr, mnth
						ROWS BETWEEN 5 PRECEDING AND CURRENT ROW),3) AS six_month_ma
FROM cs;
