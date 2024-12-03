// Step 1: Import Required Libraries
// Import the database configuration to interact with the MySQL database.
const db = require('../dbConfig');

// Step 2: Define Controller Functions

// This function retrieves all assignments and sends the results as JSON.
const getAllAssignments = (req, res) => {
  // Step 2.1: Construct SQL Query
  const query = `
    SELECT COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
    FROM ASSIGNMENTS
    JOIN COURSE ON ASSIGNMENTS.CourseID = COURSE.CourseID;
  `;

  // Step 2.2: Execute the Query
  db.query(query, (err, results) => {
    if (err) {
      // Step 2.3: Handle Errors
      console.error('Error fetching all assignments:', err);
      res.status(500).send('Error fetching assignment list');
    } else {
      // Step 2.4: Send Results
      res.json(results); // Send the assignment list as a JSON response
    }
  });
};

// This function retrieves detailed information for assignments matching the criteria.
const getFilteredAssignments = (req, res) => {

  // Step 3.1: Construct SQL Query
    const query = `
        SELECT ASSIGNMENTS.AssignID, COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
        FROM ASSIGNMENTS
        JOIN COURSE ON ASSIGNMENTS.CourseID = COURSE.CourseID
        JOIN TIME_RECORD ON ASSIGNMENTS.AssignID = TIME_RECORD.AssignID
        GROUP BY ASSIGNMENTS.AssignID, COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
        HAVING ASSIGNMENTS.StuAvgTime > 3.0 AND COUNT(DISTINCT TIME_RECORD.StudentEmail) >= 3;
        WHERE = COURSE.CourseName? 
    `;

  // Step 3.2: Execute the Query
  db.query(query, (err, results) => {
    if (err) {
      // Step 3.3: Handle Errors
      console.error('Error fetching filtered assignments:', err);
      res.status(500).send('Error retrieving filtered assignment details');
    } else {
      // Step 3.4: Send Results
      res.json(results); // Send filtered assignment details as JSON
    }
  });
};

// Step 4: Export the Controller Functions
// Export the functions so they can be used in server.js or other parts of the application.
module.exports = {
  getAllAssignments,
  getFilteredAssignments,
};
