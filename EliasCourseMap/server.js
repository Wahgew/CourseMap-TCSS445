// Step 1: Import Required Libraries 
const express = require('express'); 
const app = express(); 

// Step 2: Import Controllers 
// Import the required controllers to handle controller-related routes. 
const query1Controller = require('./controllers/query1'); 
const query4Controller = require('./controllers/query4');
const query5Controller = require('./controllers/query5');

// Step 3: Middleware Setup 
// Use express.json() to parse incoming JSON requests. 
// Use express.static() to serve static files from the 'public' directory. 
app.use(express.json()); 
app.use(express.static('public')); 

// Step 4: Define Routes 
// Set up a GET route for '/employee', '/department', '/project', '/worksOn' that invokes the getAll method  
// from the controllers. For the dropdownmenu selection, use a different 
// method called get(controller name)Details. 
app.get('/query1', query1Controller.getAllProfessors); 
app.get('/query1/details', query1Controller.getProfessorDetails); 

//

app.get('/query4/professors', query4Controller.getAllProfessors);
app.get('/query4/stats', query4Controller.getProfessorStats);


app.get('/query5/longAssignments', query5Controller.getLongAssignments);
// Step 5: Start the Server 
// Define the port the server will listen on, defaulting to 5000 if not specified in environment variables.
const PORT = process.env.PORT || 5000;  
// Start the server and log a message indicating the URL. 
app.listen(PORT, () => { 
    console.log(`Server running on http://localhost:${PORT}`); 
}); 