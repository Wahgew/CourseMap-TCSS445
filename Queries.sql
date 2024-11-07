-- Query 1
-- Purpose: Lists each professor’s full name, the courses they teach, and the types of assignments in each course along with the average student time spent.
-- Expected: A table showing the professor's name, the course name, each assignment type in that course, and the average student time spent.
SELECT CONCAT(P.FName, ' ', P.LName) AS ProfessorName, 
       C.CourseName, 
       A.AssignmentType, 
       A.StuAvgTime
FROM professor P
JOIN course C ON P.ProfEmail = C.ProfEmail
JOIN assignments A ON C.CourseID = A.CourseID;
-- ***************************

-- SQL Query 2
-- Purpose: Find professors and their courses where the course average time is greater than a specified threshold (default 2 hours)
-- Expected: A list of professor names, course names, and the course average time where the average course time is less than the threshold
--  In the future users will be able to pass their on thresholds.
SELECT DISTINCT
    c.CourseName AS "Course Name",
    CONCAT(p.Fname, ' ', p.Lname) AS "Professor Name",
    ROUND(AVG(a.StuAvgTime),2) AS "AvgCourseTime"  -- Calculate overall average time per course
FROM PROFESSOR p
JOIN COURSE c ON p.ProfEmail = c.ProfEmail
JOIN ASSIGNMENTS a ON a.CourseID = c.CourseID  -- Join with assignments to calculate average
WHERE c.CourseID = ANY (
    SELECT CourseID
    FROM ASSIGNMENTS
    GROUP BY CourseID
    
    HAVING AVG(StuAvgTime) < 10  -- Filter courses with an average course time < 10 hours.
)
GROUP BY c.CourseName, p.Fname, p.Lname  -- Group by course and professor
ORDER BY c.CourseName ASC;



-- SQL Query 3
-- Purpose:
-- Expected: 



-- SQL Query 4
-- Purpose: Retrieves each student’s full name and email, and, if available, their time record ID and time input. Includes students with or without time records.
-- Expected: A table displaying each student’s full name, email, time record ID, and time input (with NULL values for students without time records).
SELECT CONCAT(s.FName, ' ', s.LName) AS FullName, 
       s.StuEmail, 
       tr.RecordID, 
       tr.TimeInput
FROM STUDENT s
LEFT JOIN TIME_RECORD tr ON s.StuEmail = tr.StudentEmail
UNION
SELECT CONCAT(s.FName, ' ', s.LName) AS FullName, 
       s.StuEmail, 
       tr.RecordID, 
       tr.TimeInput
FROM STUDENT s
RIGHT JOIN TIME_RECORD tr ON s.StuEmail = tr.StudentEmail;
-- ***************************




-- SQL Query 5
-- Purpose:
-- Expected: 



-- SQL Query 6
-- Purpose: Calculates the average time each student has spent on assignments in each course they are enrolled in.
-- Expected: A table showing each student’s name, email, the course name, and the average time spent on assignments in that course.
SELECT CONCAT(st.FName, ' ', st.LName) AS StudentName, 
       st.StuEmail, 
       c.CourseName, 
       AVG(tr.TimeInput) AS AvgTimeSpent
FROM STUDENT st
JOIN TIME_RECORD tr ON st.StuEmail = tr.StudentEmail
JOIN ASSIGNMENTS a ON tr.AssignID = a.AssignID
JOIN COURSE c ON a.CourseID = c.CourseID
GROUP BY st.StuEmail, c.CourseID
ORDER BY StudentName, c.CourseName;
-- ***************************

-- SQL Query 7
-- Purpose:
-- Expected: 



-- SQL Query 8
-- Purpose:
-- Expected: 



-- SQL Query 9
-- Purpose: Find students and the names of professors teaching their courses
-- Expected: A list of students, professors, and course names.
SELECT DISTINCT
    CONCAT(s.FName, ' ', s.LName) AS "Student Name",
    c.CourseName AS "Course Name",
    CONCAT(p.FName, ' ', p.LName) AS "Professor Name"
FROM STUDENT s
JOIN TIME_RECORD tr ON s.StuEmail = tr.StudentEmail
JOIN ASSIGNMENTS a ON tr.AssignID = a.AssignID
JOIN COURSE c ON a.CourseID = c.CourseID
JOIN PROFESSOR p ON c.ProfEmail = p.ProfEmail
ORDER BY "Student Name";


-- SQL Query 10
-- Purpose:
-- Expected: 
