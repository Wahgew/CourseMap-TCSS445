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



-- Query 3 
-- Purpose: Find the assignments where the students spent more time than the average time spends by all students on the same assignment.
-- Expected: Identify the students who might be struggling with the assignment specific assignments. 
SELECT STUDENT.FName, STUDENT.LName, TIME_RECORD.TimeInput, ASSIGNMENTS.StuAvgTime
FROM STUDENT 
JOIN TIME_RECORD ON STUDENT.StuEmail = TIME_RECORD.StudentEmail
JOIN ASSIGNMENTS ON TIME_RECORD.AssignID = ASSIGNMENTS.AssignID
WHERE TIME_RECORD.TimeInput > 
(SELECT AVG(TIME_RECORD_TWO.TimeInput)
     FROM TIME_RECORD TIME_RECORD_TWO
     WHERE TIME_RECORD.AssignID = TIME_RECORD.AssignID);


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




-- Query 5 
-- Purpose: Determine the assignment that have an average student time that greater than 3.0 and have beenworked by at least 3 distinct student based on the students time record. 
-- Expected: It return assignment with ID, course name, assignment type and the average completion time, where the assignment take over 3 hours to compete an average and have atleast 3 students who recorded time for them. 
SELECT ASSIGNMENTS.AssignID, COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
FROM ASSIGNMENTS
JOIN COURSE ON ASSIGNMENTS.CourseID = COURSE.CourseID
WHERE ASSIGNMENTS.StuAvgTime > 3.0
INTERSECT
SELECT ASSIGNMENTS.AssignID, COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
FROM ASSIGNMENTS
JOIN COURSE ON ASSIGNMENTS.CourseID = COURSE.CourseID
JOIN TIME_RECORD ON ASSIGNMENTS.AssignID = TIME_RECORD.AssignID
GROUP BY ASSIGNMENTS.AssignID, COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
HAVING COUNT(DISTINCT TIME_RECORD.StudentEmail) >= 3;


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



-- Query 7
-- Purpose: It determine how many assignment of each professor has and the average time of students take to complete the assignments.
-- Expected: It returns a list of professors, including their name, and email, along with the total number of assignments they have and the average time students spend on that assignment. 
SELECT PROFESSOR.FName, PROFESSOR.LName, PROFESSOR.ProfEmail, 
	COUNT(DISTINCT ASSIGNMENTS.AssignID) AS Total_Assingments, 
       ROUND(AVG(ASSIGNMENTS.StuAvgTime),2) AS AverageAssingmentTime
FROM PROFESSOR
JOIN COURSE ON PROFESSOR.ProfEmail = COURSE.ProfEmail
JOIN ASSIGNMENTS ON COURSE.CourseID = ASSIGNMENTS.CourseID
GROUP BY PROFESSOR.ProfEmail, PROFESSOR.FName, PROFESSOR.LName
ORDER BY AverageAssingmentTime DESC;



-- Query 8
-- Purpose: Find all students and their assignments where they spent more time 
--          than the average time for that assignment
-- Expected: Shows student names, assignment IDs, and their time spent when it 
--          exceeds the assignment's average time, sorted by time spent
SELECT S.FName, S.LName, T.AssignID, T.TimeInput, A.StuAvgTime
FROM STUDENT S, TIME_RECORD T, ASSIGNMENTS A 
WHERE S.StuEmail = T.StudentEmail 
AND T.AssignID = A.AssignID
AND T.TimeInput > A.StuAvgTime
ORDER BY T.TimeInput DESC;



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



-- Query 10
-- Purpose: Find all professors who teach courses with assignments where the 
--          average student time exceeds 5 hours
-- Expected: Shows professor names and course details where assignments take 
--          longer than 5 hours on average, sorted by average time
SELECT P.FName AS ProfessorName, P.LName, C.CourseName, A.AssignID, A.StuAvgTime
FROM PROFESSOR P, COURSE C, ASSIGNMENTS A
WHERE P.ProfEmail = C.ProfEmail
AND C.CourseID = A.CourseID
AND A.StuAvgTime > 5
ORDER BY A.StuAvgTime DESC;
