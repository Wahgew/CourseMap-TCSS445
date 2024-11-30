const connection = require('../dbConfig');

//NEEDS EITHER MORE FUNCTIONS OR DIFFERENT QUERIES TBD 

const getAllProfessors = (req, res) => {
    const query = `
        SELECT DISTINCT 
            p.ProfEmail,
            p.FName,
            p.LName,
            COUNT(DISTINCT c.CourseID) as CourseCount
        FROM PROFESSOR p
        LEFT JOIN COURSE c ON p.ProfEmail = c.ProfEmail
        GROUP BY p.ProfEmail, p.FName, p.LName
        ORDER BY p.LName, p.FName`;

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching professors:', err);
            res.status(500).send('Error fetching professor list');
        } else {
            res.json(results);
        }
    });
};

const getProfessorDetails = (req, res) => {
    const { email } = req.query;
    if (!email) {
        return res.status(400).send('Professor email is required');
    }

    const query = `
        SELECT 
            p.FName,
            p.LName,
            p.ProfEmail,  /* Explicitly selecting ProfEmail */
            c.CourseID,
            c.CourseName,
            (
                SELECT COUNT(DISTINCT a.AssignID)
                FROM ASSIGNMENTS a
                WHERE a.CourseID = c.CourseID
            ) as AssignmentCount,
            (
                SELECT ROUND(AVG(a.StuAvgTime), 2)
                FROM ASSIGNMENTS a
                WHERE a.CourseID = c.CourseID
            ) as AvgCompletionTime,
            (
                SELECT COUNT(DISTINCT t.StudentEmail)
                FROM TIME_RECORD t
                JOIN ASSIGNMENTS a ON t.AssignID = a.AssignID
                WHERE a.CourseID = c.CourseID
            ) as TotalStudents
        FROM PROFESSOR p
        LEFT JOIN COURSE c ON p.ProfEmail = c.ProfEmail
        WHERE p.ProfEmail = ?
        ORDER BY c.CourseName`;

    connection.query(query, [email], (err, results) => {
        if (err) {
            console.error('Error fetching professor details:', err);
            res.status(500).send('Error retrieving professor details');
        } else {
            res.json(results);
        }
    });
};

module.exports = {
    getAllProfessors,
    getProfessorDetails
};