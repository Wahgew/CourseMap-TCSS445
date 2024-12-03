const db = require('../dbConfig');

// Get all assignments that take more than 5 hours
const getLongAssignments = (req, res) => {
    
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
    
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching long assignments:', err);
            res.status(500).send('Error retrieving long assignments');
        } else {
            //console.log('Found assignments:', results);
            res.json(results);
        }
    });
};

module.exports = {
    getLongAssignments
};