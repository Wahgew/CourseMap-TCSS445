const db = require('../dbConfig');

const getProfessorStats = (req, res) => {
    const query = `
        SELECT 
            PROFESSOR.FName AS FirstName,
            PROFESSOR.LName AS LastName,
            PROFESSOR.ProfEmail,
            COUNT(DISTINCT ASSIGNMENTS.AssignID) AS Total_Assignments,
            ROUND(AVG(ASSIGNMENTS.StuAvgTime), 2) AS AverageAssignmentTime
        FROM PROFESSOR
        JOIN COURSE ON PROFESSOR.ProfEmail = COURSE.ProfEmail
        JOIN ASSIGNMENTS ON COURSE.CourseID = ASSIGNMENTS.CourseID
        GROUP BY PROFESSOR.ProfEmail, PROFESSOR.FName, PROFESSOR.LName
        ORDER BY AverageAssignmentTime DESC
    `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching professor statistics:', err);
            res.status(500).send('Error retrieving professor statistics');
        } else {
            res.json(results);
        }
    });
};

module.exports = {
    getProfessorStats
};