// Database Configuration File

const mysql = require('mysql2');
require('dotenv').config();

// Create connection to MySQL database
const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: 3306
});

// Connect to the Database
connection.connect(err => {
    if (err) {
        console.error('Database connection failed:', err.stack);
        return;
    }
    console.log('Connected to the CourseMap database.');
});

module.exports = connection;