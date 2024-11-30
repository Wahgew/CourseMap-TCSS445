const connection = require('../dbConfig');

// NEEDS SOME WORK OR OTHER FUNCTIONAILY FEEL FREE TO CHANGE THIS

const getTimeRecords = (req, res) => {
    const query = `
        SELECT 
            tr.RecordID,
            CONCAT(s.FName, ' ', s.LName) as StudentName,
            a.AssignmentType,
            c.CourseName,
            tr.TimeInput,
            a.StuAvgTime
        FROM TIME_RECORD tr
        JOIN STUDENT s ON tr.StudentEmail = s.StuEmail
        JOIN ASSIGNMENTS a ON tr.AssignID = a.AssignID
        JOIN COURSE c ON a.CourseID = c.CourseID
        ORDER BY tr.RecordID DESC`;

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching time records:', err);
            res.status(500).send('Error fetching time record list');
        } else {
            res.json(results);
        }
    });
};

const addTimeRecord = (req, res) => {
    const { studentEmail, assignId, timeInput } = req.body;
    if (!studentEmail || !assignId || !timeInput) {
        return res.status(400).send('All fields are required');
    }

    // Get the next RecordID
    const getMaxIdQuery = 'SELECT MAX(RecordID) as maxId FROM TIME_RECORD';
    connection.query(getMaxIdQuery, (err, results) => {
        if (err) {
            console.error('Error getting max RecordID:', err);
            return res.status(500).send('Error adding time record');
        }

        const newRecordId = (results[0].maxId || 0) + 1;
        const insertQuery = `
            INSERT INTO TIME_RECORD (RecordID, StudentEmail, AssignID, TimeInput)
            VALUES (?, ?, ?, ?)`;

        connection.query(insertQuery, [newRecordId, studentEmail, assignId, timeInput], (err) => {
            if (err) {
                console.error('Error adding time record:', err);
                res.status(500).send('Error adding time record');
            } else {
                res.json({ message: 'Time record added successfully' });
            }
        });
    });
};

module.exports = {
    getTimeRecords,
    addTimeRecord
};