const db = require('../dbConfig');

// Get assignments that are time-intensive and well-attempted
const getAssignments = (req, res) => {

    
    const query = `
        SELECT ASSIGNMENTS.AssignID, COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
        FROM ASSIGNMENTS
        JOIN COURSE ON ASSIGNMENTS.CourseID = COURSE.CourseID
        WHERE ASSIGNMENTS.StuAvgTime > 3.0
        AND ASSIGNMENTS.AssignID IN (
            SELECT ASSIGNMENTS.AssignID
            FROM ASSIGNMENTS
            JOIN COURSE ON ASSIGNMENTS.CourseID = COURSE.CourseID
            JOIN TIME_RECORD ON ASSIGNMENTS.AssignID = TIME_RECORD.AssignID
            GROUP BY ASSIGNMENTS.AssignID, COURSE.CourseName, ASSIGNMENTS.AssignmentType, ASSIGNMENTS.StuAvgTime
            HAVING COUNT(DISTINCT TIME_RECORD.StudentEmail) >= 3
        )
        ORDER BY ASSIGNMENTS.StuAvgTime DESC;
    `;
    
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching assignments:', err);
            res.status(500).send('Error retrieving assignments data');
        } else {
            //console.log('Found assignments:', results.length);
            res.json(results);
        }
    });
};

module.exports = {
    getAssignments
};