-- Assignment: Pivoting
-- Email from Stu
-- Can you help us create a summary table that shows the average grade for each department and grade level?

SELECT * FROM students;
SELECT * FROM student_grades;


SELECT sg.department,
			ROUND(AVG(CASE WHEN s.grade_level = 9 THEN sg.final_grade END),0) AS freshman,
			ROUND(AVG(CASE WHEN s.grade_level = 10 THEN sg.final_grade END),0) AS sophomore,
			ROUND(AVG(CASE WHEN s.grade_level = 11 THEN sg.final_grade END),0) AS junior,
			ROUND(AVG(CASE WHEN s.grade_level = 12 THEN sg.final_grade END),0) AS senior
FROM students AS s
inner JOIN student_grades AS sg
	ON s.id = sg.student_id
GROUP BY sg.department
ORDER BY sg.department;
