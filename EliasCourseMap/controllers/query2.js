const db = require('../dbConfig');

// Get all courses that take more than 10 hours
const getCourses = (req, res) => {
    
    
    const query = `
        SELECT DISTINCT
    c.CourseName AS CourseName,
    CONCAT(p.Fname, ' ', p.Lname) AS ProfessorName,
    ROUND(AVG(a.StuAvgTime),2) AS AvgCourseTime  -- Calculate overall average time per course
FROM PROFESSOR p
JOIN COURSE c ON p.ProfEmail = c.ProfEmail
JOIN ASSIGNMENTS a ON a.CourseID = c.CourseID  -- Join with assignments to calculate average
WHERE c.CourseID = ANY (
    SELECT CourseID
    FROM ASSIGNMENTS
    GROUP BY CourseID
    
    HAVING AVG(StuAvgTime) < 10  -- Filter courses with an average course time < 10 hours.
)
GROUP BY c.CourseName, p.Fname, p.Lname  -- Group by course and professor
ORDER BY c.CourseName ASC
    `;
    
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching courses:', err);
            res.status(500).send('Error retrieving courses');
        } else {
            res.json(results);
        }
    });
};

module.exports = {
    getCourses
};