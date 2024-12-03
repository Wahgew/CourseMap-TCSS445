//The following file is the backend of query4.html which queries for professor information.
// Step 1: Import Required Libraries
// Import the database configuration to interact with the MySQL database.
const db = require('../dbConfig');

// Step 2: Define Controller Function for Professor List
// This function retrieves a list of all professors for initial dropdown population
const getAllProfessors = (req, res) => {
    // Step 2.1: Construct SQL Query
    // Query selects basic professor information and orders alphabetically by last name
    const query = `
        SELECT ProfEmail, FName, LName
        FROM PROFESSOR
        ORDER BY LName, FName
    `;

    // Step 2.2: Execute Database Query
    db.query(query, (err, results) => {
        if (err) {
            // Step 2.3: Handle Error Cases
            console.error('Error fetching professors:', err);
            res.status(500).send('Error fetching professors list');
        } else {
            // Step 2.4: Send Successful Response
            res.json(results);
        }
    });
};

// Step 3: Define Controller Function for Professor Statistics
// This function retrieves detailed statistics for a specific professor
const getProfessorStats = (req, res) => {
    // Step 3.1: Extract Query Parameters
    const { ProfEmail } = req.query;

    // Step 3.2: Validate Input Parameters
    if (!ProfEmail) {
        return res.status(400).send('ProfEmail is required');
    }

    // Step 3.3: Construct Complex SQL Query
    /**It determine how many assignment of each professor has and the average time of 
     * students take to complete the assignments. */  

    const query = `
        SELECT
            PROFESSOR.FName AS FirstName,
            PROFESSOR.LName AS LastName,
            PROFESSOR.ProfEmail,
            COUNT(DISTINCT ASSIGNMENTS.AssignID) AS Total_Assignments,
            ROUND(AVG(ASSIGNMENTS.StuAvgTime), 2) AS AverageAssignmentTime
        FROM PROFESSOR
        JOIN COURSE ON PROFESSOR.ProfEmail = C.ProfEmail
        JOIN ASSIGNMENTS ON COURSE.CourseID = ASSIGNMENTS.CourseID
        WHERE PROFESSOR.ProfEmail = ?
        GROUP BY PROFESSOR.ProfEmail, PROFESSOR.FName, PROFESSOR.LName
        ORDER BY AverageAssignmentTime DESC
    `;

    // Step 3.4: Execute Parameterized Query
    db.query(query, [ProfEmail], (err, results) => {
        if (err) {
            // Step 3.5: Handle Error Cases
            console.error('Error fetching professor statistics:', err);
            res.status(500).send('Error retrieving professor statistics');
        } else {
            // Step 3.6: Send Successful Response
            res.json(results);
        }
    });
};

// Step 4: Export Controller Functions
// Export functions for use in other parts of the application
module.exports = {
    getAllProfessors,
    getProfessorStats
};