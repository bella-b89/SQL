-- Return the prior year's happiness score
select country, happiness_score,
		LAG(happiness_score) OVER(partition by country order by year ) as prior_happiness_score
from  happiness_scores;

-- Return the difference between yearly scores

with prior_year as (
	select country,
		   happiness_score,
		   LAG(happiness_score) OVER(partition by country order by year ) as prior_happiness_score
	from  happiness_scores
) 
select country,
	   happiness_score,
	   prior_happiness_score,
	   (happiness_score - prior_happiness_score) as difference_score
from prior_year;

-- Assignments 4: Lead & Lag

-- View the columns of interest
select 
	customer_id,
	order_id,
	product_id,
	units
from orders;

-- For each customer, return the total units within each other
select 
	customer_id,
	order_id,
	SUM(units) as total_units
from orders
group by customer_id,
	     order_id
order by customer_id;

-- Add on the transaction id to keep track of the order of the orders
select 
	customer_id,
	order_id,
	MIN(transaction_id) as min_tid,
	SUM(units) as total_units
from orders
group by customer_id,
	     order_id,
	     transaction_id
order by customer_id,
		 min_tid;

-- Turn the query into a CTE and view the columns of interest
with my_cte as (
		select 
			customer_id,
			order_id,
			MIN(transaction_id) as min_tid,
			SUM(units) as total_units
		from orders
		group by customer_id,
			     order_id,
			     transaction_id
		order by customer_id,
				 min_tid)
 select customer_id, 
 		order_id,
 		total_units
 from my_cte;

-- Create a prior units columm
with my_cte as (
		select 
			customer_id,
			order_id,
			MIN(transaction_id) as min_tid,
			SUM(units) as total_units
		from orders
		group by customer_id,
			     order_id,
			     transaction_id
		order by customer_id,
				 min_tid)
 select customer_id, 
 		order_id,
 		total_units,
 		LAG(total_units) OVER(partition by customer_id order by min_tid) as prior
 from my_cte;

-- For each customer, find the change in units per order over time
-- Final Query
with my_cte as (
		select 
			customer_id,
			order_id,
			MIN(transaction_id) as min_tid,
			SUM(units) as total_units
		from orders
		group by customer_id,
			     order_id,
			     transaction_id
		order by customer_id,
				 min_tid),
	prior_cte as (
		select	*,
				total_units - lag(total_units) OVER(partition by customer_id order by min_tid) as prior_units
		from my_cte)
select *
from prior_cte;
