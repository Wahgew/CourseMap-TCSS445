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
        console.error('Error fetching long assignments:', err);
        return res.status(500).render('error', { message: 'Error retrieving long assignments' });
    }

     // Generate the table rows HTML
     let tableRows = '';
     results.forEach(row => {
         tableRows += `
             <tr>
                 <td>${row.ProfessorName} ${row.LastName}</td>
                 <td>${row.CourseName}</td>
                 <td>${row.AssignID}</td>
                 <td>${row.StuAvgTime}</td>
             </tr>`;
     });// Send the complete page with the generated table
     res.send(`
         <table class="table table-bordered table-striped">
             <thead class="table-dark">
                 <tr>
                     <th>Professor Name</th>
                     <th>Course Name</th>
                     <th>Assignment ID</th>
                     <th>Average Time (hours)</th>
                 </tr>
             </thead>
             <tbody>
                 ${tableRows}
             </tbody>
         </table>
     `);
 });
};

// Step 3: Export Controller Function
// Export function for use in other parts of the application
module.exports = {
   getLongAssignments
};
