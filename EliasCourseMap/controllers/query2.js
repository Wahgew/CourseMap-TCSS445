//Elias Arriola
//The following file is the backend of query1.html which queries for Course information.
// Step 1: Import Required Libraries 
// Import the database configuration to interact with the MySQL database. 
const db = require('../dbConfig');

// Step 2: Define Controller Functions 
/** Find professors and their courses
 *  where the course average time is less than a specified threshold (default 10 hours)*/
const getCourses = (req, res) => {
    
    // Step 2.1: Construct SQL Query
    const query = `
        SELECT DISTINCT
    c.CourseName AS CourseName,
    CONCAT(p.Fname, ' ', p.Lname) AS ProfessorName,
    ROUND(AVG(a.StuAvgTime),2) AS AvgCourseTime  -- Calculate overall average time per course
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
ORDER BY c.CourseName ASC
    `;
    // Step 2.2: Execute the Query
    db.query(query, (err, results) => {
        if (err) {
            // Step 2.3: Handle Errors
            console.error('Error fetching courses:', err);
            res.status(500).send('Error retrieving courses');
        } else {
            // Step 2.4: Send Results
            res.json(results);
        }
    });
};
//Step 3: Export the functions so they can be used in server.js or other parts of the application.
module.exports = {
    getCourses
};