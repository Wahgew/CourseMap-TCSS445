//Ahmed Hassan 
//The following file is the backend of query3.html which corresponds to query 5 in the final script.
// Step 1: Import Required Libraries 
// Import the database configuration to interact with the MySQL database.
const db = require('../dbConfig');

// Step 2: Define Controller Functions 
/** Determine the assignment that have an average student time
 *  that greater than 3.0 and have beenworked by at least 3 distinct student 
 * based on the students time record. */
const getAssignments = (req, res) => {

    // Step 2.1: Construct SQL Query
    const query = `
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
    `;
    // Step 2.2: Execute the Query
    db.query(query, (err, results) => {
        if (err) {
            // Step 2.3: Handle Errors
            console.error('Error fetching assignments:', err);
            res.status(500).send('Error retrieving assignments data');
        } else {
            // Step 2.4: Send Results
            //console.log('Found assignments:', results.length);
            res.json(results);
        }
    });
};
//Step 3: Export the functions so they can be used in server.js or other parts of the application.
module.exports = {
    getAssignments
};