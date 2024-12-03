const db = require('../dbConfig');

// Get student performance data
const getStudentPerformance = (req, res) => {
    
    const query = `
        SELECT 
            STUDENT.FName,
            STUDENT.LName,
            TIME_RECORD.TimeInput,
            ASSIGNMENTS.StuAvgTime
        FROM STUDENT 
        JOIN TIME_RECORD ON STUDENT.StuEmail = TIME_RECORD.StudentEmail
        JOIN ASSIGNMENTS ON TIME_RECORD.AssignID = ASSIGNMENTS.AssignID
        WHERE TIME_RECORD.TimeInput > (
            SELECT AVG(TIME_RECORD_TWO.TimeInput)
            FROM TIME_RECORD TIME_RECORD_TWO
            WHERE TIME_RECORD_TWO.AssignID = TIME_RECORD.AssignID
        )
        ORDER BY (TIME_RECORD.TimeInput - ASSIGNMENTS.StuAvgTime) DESC
    `;
    
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching student performance:', err);
            res.status(500).send('Error retrieving student performance data');
        } else {
            console.log('Found student records:', results.length);
            res.json(results);
        }
    });
};

module.exports = {
    getStudentPerformance
};