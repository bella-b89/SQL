-- Assignment :Duplicate Values
-- Email from Stu 
-- We've learned that there's student who's showing up muliple times in our student records.
-- Can you generate a report of the students and their emails, and exclude the duplicate student record?

SELECT * FROM students;

-- check if there are duplicate name of students
SELECT student_name, count(*)
FROM students 
GROUP BY student_name;

-- duplicate name OF student
SELECT id, student_name, email
FROM students
WHERE student_name = 'Noah Scott'

-- distinct name of student
SELECT id, student_name, email,
		ROW_NUMBER() over(PARTITION BY student_name ORDER BY id desc) AS dis
FROM students;

-- subqueary & final result
SELECT id, student_name, email FROM 
		(SELECT id, student_name, email,
		ROW_NUMBER() over(PARTITION BY student_name ORDER BY id desc) AS dis
		FROM students) AS dis_student
WHERE dis = 1;
