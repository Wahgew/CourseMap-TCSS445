const connection = require('../dbConfig');


// NEEDS TO BE FIX AND MAKE SURE TO UPDATE THE APP.JS IF YOU CHANGE ANY FUNCTION NAMES

const getDetailedAssignments = (req, res) => {
    // Using Query 1
    const query = `
        SELECT CONCAT(P.FName, ' ', P.LName) AS ProfessorName, 
               C.CourseName, 
               A.AssignmentType,
               A.AssignID, 
               A.StuAvgTime
        FROM professor P
        JOIN course C ON P.ProfEmail = C.ProfEmail
        JOIN assignments A ON C.CourseID = A.CourseID
        ORDER BY C.CourseName, A.AssignmentType`;

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching assignments:', err);
            res.status(500).send('Error fetching assignment list');
        } else {
            res.json(results);
        }
    });
};

const getAssignmentDetails = (req, res) => {
    const { assignId } = req.query;
    if (!assignId) {
        return res.status(400).send('Assignment ID is required');
    }

    
    const query = `
        SELECT 
            a.AssignID,
            a.AssignmentType,
            c.CourseName,
            CONCAT(p.FName, ' ', p.LName) as ProfessorName,
            a.StuAvgTime,
            tr.TimeInput,
            CONCAT(s.FName, ' ', s.LName) as StudentName
        FROM ASSIGNMENTS a
        JOIN COURSE c ON a.CourseID = c.CourseID
        JOIN PROFESSOR p ON c.ProfEmail = p.ProfEmail
        LEFT JOIN TIME_RECORD tr ON a.AssignID = tr.AssignID
        LEFT JOIN STUDENT s ON tr.StudentEmail = s.StuEmail
        WHERE a.AssignID = ?`;

    connection.query(query, [assignId], (err, results) => {
        if (err) {
            console.error('Error fetching assignment details:', err);
            res.status(500).send('Error retrieving assignment details');
        } else {
            res.json(results);
        }
    });
};

const getStrugglingStudents = (req, res) => {
    const { assignId } = req.query;
    if (!assignId) {
        return res.status(400).send('Assignment ID is required');
    }

    // Using Query 3
    const query = `
        SELECT STUDENT.FName, STUDENT.LName, TIME_RECORD.TimeInput, ASSIGNMENTS.StuAvgTime
        FROM STUDENT 
        JOIN TIME_RECORD ON STUDENT.StuEmail = TIME_RECORD.StudentEmail
        JOIN ASSIGNMENTS ON TIME_RECORD.AssignID = ASSIGNMENTS.AssignID
        WHERE TIME_RECORD.AssignID = ?
        AND TIME_RECORD.TimeInput > ASSIGNMENTS.StuAvgTime
        ORDER BY TIME_RECORD.TimeInput DESC`;

    connection.query(query, [assignId], (err, results) => {
        if (err) {
            console.error('Error fetching struggling students:', err);
            res.status(500).send('Error retrieving struggling students');
        } else {
            res.json(results);
        }
    });
};

module.exports = {
    getDetailedAssignments,
    getAssignmentDetails,
    getStrugglingStudents
};