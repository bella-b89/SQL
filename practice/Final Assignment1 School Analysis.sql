-- PART I: SCHOOL ANALYSIS
-- 1. View the schools and school details tables
SELECT * FROM school_details;
SELECT * FROM schools;

-- 2. In each decade, how many schools were there that produced players?
SELECT FLOOR(yearid/10)*10 AS decade,
		COUNT(DISTINCT schoolid) AS num_school
FROM schools
GROUP BY decade
ORDER BY decade;

-- 3. What are the names of the top 5 schools that produced the most players?

SELECT	 sd.name_full, COUNT(DISTINCT s.playerID) AS num_players
FROM	 schools s LEFT JOIN school_details sd
		 ON s.schoolID = sd.schoolID
GROUP BY s.schoolID, sd.name_full
ORDER BY num_players DESC
LIMIT 	 5;


-- 4. For each decade, what were the names of the top 3 schools that produced the most players?

WITH ds AS (SELECT	FLOOR(s.yearid / 10)*10 AS decade, sd.name_full, COUNT(DISTINCT s.playerID) AS num_players
			FROM	 schools AS s 
			LEFT JOIN school_details AS sd
					 ON s.schoolID = sd.schoolID
			GROUP BY decade, sd.name_full),
	rn AS (SELECT *,
			ROW_NUMBER() OVER(PARTITION BY decade ORDER BY num_players desc) AS row_num
			FROM ds)
SELECT decade, name_full, num_players
FROM rn
WHERE row_num <=3
ORDER BY decade DESC, row_num;
