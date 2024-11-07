-- SQL Query 1
-- Purpose:
-- Expected: 



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
-- Purpose:
-- Expected: 



-- SQL Query 5
-- Purpose:
-- Expected: 



-- SQL Query 6
-- Purpose:
-- Expected: 



-- SQL Query 7
-- Purpose:
-- Expected: 



-- SQL Query 8
-- Purpose:
-- Expected: 



-- SQL Query 9
-- Purpose:
-- Expected: 



-- SQL Query 10
-- Purpose:
-- Expected: 
