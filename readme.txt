# CourseMap - UWT Course Time Management System

CourseMap is a web application designed to help UWT computer science students estimate assignment completion times based on professor-specific data. This tool assists in course planning and time management by allowing professors to post assignment details and students to log their own completion times.

## Tech Stack

* **Frontend**: HTML5, CSS3, JavaScript
* **Backend**: Node.js, Express.js
* **Database**: MySQL
* **Styling**: Custom CSS 

## Getting Started

### Prerequisites

* Node.js (v14 or higher)
* MySQL (v8.0 or higher)
* XAMPP or similar local MySQL server

### Installation

1. Clone the repository
```bash
git clone https://github.com/Wahgew/CourseMap-TCSS445.git
cd FinalCourseMap
```

2. Install dependencies
```bash
cd FinalCourseMap
npm install
```

3. Set up environment variables
Create a .env file in the backend directory with the following:
```env
DB_HOST=localhost # Database host
DB_USER=tcss445-user  # Replace with your MySQL username
DB_PASSWORD=mypassword # Replace with your MySQL password
DB_NAME=coursemap # Database name for coursemap database

# Server Port
DB_PORT=3306
```


4. Start the application
```bash
npm start
```

The application will be running at `http://localhost:5000` 

## Project Structure

```
FinalCourseMap/
├── server.js          # Main application file
├── dbConfig.js        # Database configuration
├── controllers/       # Database controllers
│       ├── query1.js
│       ├── query2.js
│       ├── query3.js
│       ├── query4.js
│       └── query5.js
├── public/           # Static HTML files
│   ├── index.html
│   ├── query1.html
│   ├── query2.html
│   ├── query3.html
│   └── query4.html
├── Stylesheets/             # Styling files
│     ├── index.css
│     └── query1.css
└── assets/          # Images and media
│       
├── .env          #Same as assignment 3&4
├── package.json
└── readme.md
```

## Available Scripts

* `npm start`: Runs the server in development mode


## Features

- View professor course assignments and average completion times
- Search courses by various criteria
- Filter assignments by completion time
- View detailed professor statistics
- Track long-duration assignments

## Contributors

* Peter Madin
* Sopeanith Ny
* Elias Arriola
* Ahmed Hassan

## Queries Implementation

1. **Query 1**: Professor details and their course assignments
2. **Query 2**: Courses with average work time less than 10 hours
3. **Query 3**: Time-intensive assignments with student participation
4. **Query 4**: Professor assignment statistics
5. **Query 5**: Long assignments (over 5 hours)
