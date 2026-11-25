-- Assignment: MIN / MAX Value Filtering
-- Email from Stu
-- Can you create a report of each student with their highest grade for the semester,
-- as well as which class it was in?

WITH rn AS (SELECT s.id, s.student_name, 
					sg.semester_id, sg.class_name, sg.final_grade AS top_grade,
					RANK() OVER(PARTITION BY s.id ORDER BY sg.final_grade desc) AS rn
			FROM students AS s
			INNER JOIN student_grades AS sg
				ON s.id = sg.student_id)
SELECT id, student_name, top_grade, class_name
FROM rn
WHERE rn = 1;
