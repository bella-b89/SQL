-- Assignment 2. Salary Analysis

SELECT *
FROM salaries;

-- 1. Return the top 20% of teams in terms of average annual spending
WITH ans AS (SELECT yearid, teamid,
				SUM(salary) AS yearly_total
			FROM salaries
			GROUP BY teamid, yearid),
	tas AS (SELECT teamid, ROUND(AVG(yearly_total),2) AS total_avg_spending
			FROM ans
			GROUP BY teamid),
	tt AS (SELECT teamid, total_avg_spending,
				NTILE(5) OVER(ORDER by total_avg_spending desc) AS top_team
			FROM tas)
SELECT teamid, ROUND(total_avg_spending / 1000000 ,2) AS tatal_spending_millions
FROM tt
WHERE top_team=1;

-- 3. For each team, show the cumulative sum of spending over the years
WITH yt AS (SELECT yearid, teamid, SUM(salary) AS year_total
			FROM salaries
			GROUP BY yearid, teamid
			ORDER BY teamid, yearid)
SELECT yearid, teamid,
	   ROUND(SUM(year_total) OVER(PARTITION BY teamid ORDER BY yearid ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) / 1000000,2) AS cumulative_total_millions
FROM yt

-- 4. Return the first year that each team's cumulative spending surpassed 1 billion
WITH yt AS (SELECT yearid, teamid, SUM(salary) AS year_total
			FROM salaries
			GROUP BY yearid, teamid),
		ct AS (SELECT yearid, teamid, year_total,
			   SUM(year_total) OVER(PARTITION BY teamid ORDER BY yearid ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_total
		FROM yt),
		min_ct AS (SELECT yearid, teamid, cumulative_total
					FROM ct 
					WHERE cumulative_total > 1000000000),
		fy AS (SELECT yearid, teamid, cumulative_total,
			   ROW_NUMBER()OVER(PARTITION BY teamid ORDER BY cumulative_total) AS first_year
				FROM min_ct)
SELECT yearid, teamid, ROUND(cumulative_total / 1000000, 2) AS cumulative_sum_millions
FROM fy
WHERE first_year = 1;
