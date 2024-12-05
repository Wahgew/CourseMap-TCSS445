// Step 1: Import the mysql2 Library 
const mysql = require('mysql2'); 
require('dotenv').config(); 
// Step 2: Create a Database Connection 
// A connection to the MySQL database is created using the createConnection method. 
const connection = mysql.createConnection({ 
    host: process.env.DB_HOST,            // Database host, usually 'localhost' or an IP address 
    user: process.env.DB_USER,            // Database username
    password: process.env.DB_PASSWORD,    // Database password 
    database: process.env.DB_NAME,        // Database name to connect to 
}); 
// Step 3: Connect to the Database 
// The connect method is called on the connection object to establish the connection. 
connection.connect(err => { 
    if (err) { 
    // If there is an error, log it to the console and exit the connection. 
        console.error('Database connection failed:', err.stack); 
        return; 
    } 
    // If the connection is successful, log a success message. 
    console.log('Connected to the database.'); 
}); 
// Step 4: Export the Connection 
// The connection object is exported using module.exports, allowing other modules to use this db connection. 
module.exports = connection; 