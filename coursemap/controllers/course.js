const connection = require('../dbConfig');

// CAN BE IMPROVED ON OR ADD DIFFERENT FUNCTIONAILY ALMOST COMPLETE


const getAllCourses = (req, res) => {
    const query = `
        SELECT 
            c.CourseID, 
            c.CourseName, 
            CONCAT(p.FName, ' ', p.LName) as ProfessorName
        FROM COURSE c
        JOIN PROFESSOR p ON c.ProfEmail = p.ProfEmail
        ORDER BY c.CourseName`;

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching courses:', err);
            res.status(500).send('Error fetching course list');
        } else {
            res.json(results);
        }
    });
};

const getCourseDetails = (req, res) => {
    const { courseId } = req.query;
    if (!courseId) {
        return res.status(400).send('Course ID is required');
    }

    const query = `
        SELECT 
            c.CourseID,
            c.CourseName,
            CONCAT(p.FName, ' ', p.LName) as ProfessorName,
            a.AssignID,
            a.AssignmentType,
            a.StuAvgTime,
            COUNT(DISTINCT tr.StudentEmail) as TotalStudents
        FROM COURSE c
        JOIN PROFESSOR p ON c.ProfEmail = p.ProfEmail
        LEFT JOIN ASSIGNMENTS a ON c.CourseID = a.CourseID
        LEFT JOIN TIME_RECORD tr ON a.AssignID = tr.AssignID
        WHERE c.CourseID = ?
        GROUP BY c.CourseID, c.CourseName, p.FName, p.LName, a.AssignID, a.AssignmentType, a.StuAvgTime`;

    connection.query(query, [courseId], (err, results) => {
        if (err) {
            console.error('Error fetching course details:', err);
            res.status(500).send('Error retrieving course details');
        } else {
            res.json(results);
        }
    });
};

module.exports = {
    getAllCourses,
    getCourseDetails
};