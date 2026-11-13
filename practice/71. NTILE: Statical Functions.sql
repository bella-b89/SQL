-- Add a percentile to each row of data
select region, country, happiness_score,
	   NTILE(4) OVER(partition by region order by happiness_score DESC) as hs_percentile
from happiness_scores
where year = 2023
order by region, happiness_score DESC;

-- For each region, return the top 25% of countries, in terms of happiness score
with happiness_socre_percentile as (
		select region, country, happiness_score,
			   NTILE(4) OVER(partition by region order by happiness_score DESC) as hs_percentile
		from happiness_scores
		where year = 2023
		order by region, happiness_score desc)
select *
from happiness_socre_percentile
where hs_percentile = 1;

-- Assingment: Statical Functions

-- S1. View the data needed from the orders table
select customer_id, product_id, units
from orders;

-- S2. View the data needed from the products table
select product_id, unit_price
from products;

-- S3. Combine the two tables and view the columns of interest
SELECT o.customer_id, o.product_id, o.units,
	   p.product_id, p.unit_price
from orders as o
left join products as p
	on o.product_id = p.product_id

-- S4. Calulate the total spending by each customer and sort the results from highest to lowest
SELECT o.customer_id,
		SUM(o.units *p.unit_price) as total_spend
from orders as o
left join products as p
	on o.product_id = p.product_id
group by o.customer_id
order by total_spend desc;

-- S5. Turn the query into a CTE and apply the percentile calculation
with total_spend as (SELECT o.customer_id,
		SUM(o.units *p.unit_price) as total_spend
		from orders as o
		left join products as p
			on o.product_id = p.product_id
		group by o.customer_id
		order by total_spend desc)
select customer_id, total_spend,
		NTILE(100) OVER(order by total_spend DESC) as spend_percentile
from total_spend;

-- S6. Return the top 1% of customers in terms of spending
with total_spend as (SELECT o.customer_id,
		SUM(o.units *p.unit_price) as total_spend
		from orders as o
		left join products as p
			on o.product_id = p.product_id
		group by o.customer_id
		order by total_spend desc),
	sp as (select customer_id, total_spend,
		NTILE(100) OVER(order by total_spend DESC) as spend_percentile
		from total_spend)
select *
from sp
where spend_percentile = 1;
