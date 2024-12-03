//Elias Arriola
//The following file is the backend of query1.html which queries for professor information.
// Step 1: Import Required Libraries 
// Import the database configuration to interact with the MySQL database. 
const db = require('../dbConfig'); 
 
// Step 2: Define Controller Functions 
// This function constructs a SQL query to retrieve basic professor information  
 // (ProfEmail) and sends the results as JSON.
 const getAllProfessors = (req, res) => { 
  // Step 2.1: Construct SQL Query 
  const query = ` 
    SELECT  ProfEmail, CONCAT(FName, ' ',LName) as Name 
    FROM PROFESSOR 
  `; 
 
  // Step 2.2: Execute the Query 
  db.query(query, (err, results) => { 
    if (err) { 
      // Step 2.3: Handle Errors 
      console.error('Error fetching professors:', err); 
      res.status(500).send('Error fetching professors list'); 
    } else { 
      // Step 2.4: Send Results 
      res.json(results); // Send the professor list as a JSON response 
    } 
  }); 
}; 
 
/** Lists each professor’s full name,
 * the courses they teach, 
 * and the types of assignments in each course 
 * along with the average student time spent. 
 * */ 
const getProfessorDetails = (req, res) => { 
  // Step 3.1: Extract Parameters 
  const { ProfEmail } = req.query; 
 
  if (!ProfEmail) { 
    // Step 3.2: Validate Input 
    return res.status(400).send('ProfEmail is required'); 
  } 
 
  // Step 3.3: Construct SQL Query 
  const query = `
    SELECT CONCAT(P.FName, ' ', P.LName) AS ProfessorName, 
       C.CourseName, 
       A.AssignmentType, 
       A.StuAvgTime
FROM professor P
JOIN course C ON P.ProfEmail = C.ProfEmail
JOIN assignments A ON C.CourseID = A.CourseID
WHERE P.ProfEmail = ?

  `; 
 
  // Step 3.4: Execute the Query 
  db.query(query, [ProfEmail], (err, results) => { 
    if (err) { 
      // Step 3.5: Handle Errors 
      console.error('Error fetching professor details:', err); 
      res.status(500).send('Error retrieving professor details'); 
    } else { 
      // Step 3.6: Send Results 
      res.json(results); // Send department details as JSON 
    } 
  }); 
}; 
 
// Step 4: Export the Controller Functions 
// Export the functions so they can be used in server.js or other parts of the application. 
module.exports = { 
  getAllProfessors, 
  getProfessorDetails, 
}; 