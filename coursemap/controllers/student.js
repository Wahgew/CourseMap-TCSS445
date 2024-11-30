const connection = require('../dbConfig');

// NEEDS TO CHANGE THIS DON'T WORK AND ALSO REMEMBER TO CHANGE THE HTML SCRIPTS WITH ANY CHANGES HERE

const getAllStudents = (req, res) => {
    const query = `
        SELECT 
            StuEmail,
            FName,
            LName,
            Major
        FROM STUDENT
        ORDER BY LName, FName`;

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching students:', err);
            res.status(500).send('Error fetching student list');
        } else {
            res.json(results);
        }
    });
};

const getStudentDetails = (req, res) => {
    const { email } = req.query;
    if (!email) {
        return res.status(400).send('Student email is required');
    }

    const query = `
        SELECT 
            tr.AssignID,
            a.AssignmentType,
            c.CourseName,
            tr.TimeInput,
            a.StuAvgTime,
            CONCAT(p.FName, ' ', p.LName) as ProfessorName
        FROM STUDENT s
        JOIN TIME_RECORD tr ON s.StuEmail = tr.StudentEmail
        JOIN ASSIGNMENTS a ON tr.AssignID = a.AssignID
        JOIN COURSE c ON a.CourseID = c.CourseID
        JOIN PROFESSOR p ON c.ProfEmail = p.ProfEmail
        WHERE s.StuEmail = ?`;

    connection.query(query, [email], (err, results) => {
        if (err) {
            console.error('Error fetching student details:', err);
            res.status(500).send('Error retrieving student details');
        } else {
            res.json(results);
        }
    });
};

module.exports = {
    getAllStudents,
    getStudentDetails
};