-- Email From Mandy
-- Sugar Shack and The Other Factory just added two new products that don't have divisions assigned to them.
-- For simplicity's sake, could you update those NULL values to have a value of "Other"?
-- Here's and extra challenge for you - instead of updating them to "Other", Could you update them to be the same division
-- as the most commom division within their respective factories?

USE maven_advanced_sql;

WITH rnk AS (SELECT factory,division, count(product_name) AS num_division
			FROM products
			WHERE division IS NOT NULL
			GROUP BY factory, division
			ORDER BY factory, division),
	top_division AS (SELECT *, rank() over(partition BY factory Order BY num_division desc) AS top_division
			FROM rnk),
	tp AS (SELECT *
			FROM top_division
			WHERE top_division = 1)	
SELECT p.product_name, 
	   p.factory, 
	   p.division,
	   coalesce(p.division, 'Other') AS other_division,
	   CASE 
	   	WHEN p.division IS NOT NULL THEN p.division
	   	WHEN p.division IS NULL THEN t.division
	   END AS filled_division
FROM products AS p
LEFT JOIN tp AS t
 	ON p.factory = t.factory;
