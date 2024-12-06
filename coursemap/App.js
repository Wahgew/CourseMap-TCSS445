const express = require('express');
const path = require('path');
require('dotenv').config();

// Import controllers
const professorController = require('./controllers/professor');
const courseController = require('./controllers/course');
const studentController = require('./controllers/student');
const assignmentController = require('./controllers/assignment');
const timeRecordController = require('./controllers/timeRecord');

const app = express();

app.use(express.json());
app.use(express.static('public'));

// Routes for the frontend pages
// app.get('/', (req, res) => {
//     res.sendFile(path.join(__dirname, 'views', 'index.html'));
// });

// app.get('/professor', (req, res) => {
//     res.sendFile(path.join(__dirname, 'views', 'professor.html'));
// });

// app.get('/course', (req, res) => {
//     res.sendFile(path.join(__dirname, 'views', 'course.html'));
// });

// app.get('/student', (req, res) => {
//     res.sendFile(path.join(__dirname, 'views', 'student.html'));
// });

// app.get('/assignment', (req, res) => {
//     res.sendFile(path.join(__dirname, 'views', 'assignment.html'));
// });

// API Routes
app.get('/professor', professorController.getAllProfessors);
app.get('/professor/details', professorController.getProfessorDetails);
app.get('/course', courseController.getAllCourses);
app.get('/course/details', courseController.getCourseDetails);
app.get('/student', studentController.getAllStudents);
app.get('/student/details', studentController.getStudentDetails);
app.get('/assignment', assignmentController.getDetailedAssignments);
app.get('/assignment/details', assignmentController.getAssignmentDetails);
app.post('/timeRecord', timeRecordController.addTimeRecord);

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Error!');
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});