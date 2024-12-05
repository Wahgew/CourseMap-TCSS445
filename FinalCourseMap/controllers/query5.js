//Ahmed Hassan
// The following file is the backend of query5.html which corresponds to query 10 in the final script.
// Step 1: Import Required Libraries
// Import the database configuration to interact with the MySQL database
const db = require('../dbConfig');

// Step 2: Define Controller Function for Long Assignments
// This function retrieves all assignments that take more than 5 hours to complete,
// along with associated professor and course information
const getLongAssignments = (req, res) => {
  
   // Step 2.1: Construct SQL Query
   /** Find all professors who teach courses with assignments 
    * where the average student time exceeds 5 hours */
   const query = `
       SELECT
           P.FName AS ProfessorName,
           P.LName AS LastName,
           C.CourseName,
           A.AssignID,
           A.StuAvgTime
       FROM PROFESSOR P
       JOIN COURSE C ON P.ProfEmail = C.ProfEmail
       JOIN ASSIGNMENTS A ON C.CourseID = A.CourseID
       WHERE A.StuAvgTime > 5
       ORDER BY A.StuAvgTime DESC
   `;
  
   // Step 2.2: Execute Database Query
   db.query(query, (err, results) => {
       if (err) {
           // Step 2.3: Handle Error Cases
           console.error('Error fetching long assignments:', err);
           res.status(500).send('Error retrieving long assignments');
       } else {
           // Step 2.4: Send Successful Response
           // Commented console.log for debugging purposes
           //console.log('Found assignments:', results);
           res.json(results);
       }
   });
};

// Step 3: Export Controller Function
// Export function for use in other parts of the application
module.exports = {
   getLongAssignments
};