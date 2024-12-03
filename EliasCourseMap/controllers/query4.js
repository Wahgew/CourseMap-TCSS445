const db = require('../dbConfig');

// Get list of all professors for dropdown
const getAllProfessors = (req, res) => {
    const query = `
        SELECT ProfEmail, FName, LName
        FROM PROFESSOR
        ORDER BY LName, FName
    `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching professors:', err);
            res.status(500).send('Error fetching professors list');
        } else {
            res.json(results);
        }
    });
};

// Get statistics for a specific professor
const getProfessorStats = (req, res) => {
    const { ProfEmail } = req.query;

    if (!ProfEmail) {
        return res.status(400).send('ProfEmail is required');
    }

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
        WHERE PROFESSOR.ProfEmail = ?
        GROUP BY PROFESSOR.ProfEmail, PROFESSOR.FName, PROFESSOR.LName
        ORDER BY AverageAssignmentTime DESC
    `;

    db.query(query, [ProfEmail], (err, results) => {
        if (err) {
            console.error('Error fetching professor statistics:', err);
            res.status(500).send('Error retrieving professor statistics');
        } else {
            res.json(results);
        }
    });
};

module.exports = {
    getAllProfessors,
    getProfessorStats
};