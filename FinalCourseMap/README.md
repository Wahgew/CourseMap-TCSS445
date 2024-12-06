# CourseMap - UWT Course Time Management System

CourseMap is a web application designed to help UWT computer science students estimate assignment completion times based on professor-specific data. This tool assists in course planning and time management by allowing professors to post assignment details and students to log their own completion times.

## Tech Stack

* **Frontend**: HTML5, CSS3, JavaScript
* **Backend**: Node.js, Express.js
* **Database**: MySQL
* **Styling**: Custom CSS with responsive design

## Getting Started

### Prerequisites

* Node.js (v14 or higher)
* MySQL (v8.0 or higher)
* XAMPP or similar local MySQL server

### Installation

1. Clone the repository
```bash
git clone https://github.com/Wahgew/CourseMap-TCSS445/coursemap.git
cd coursemap
```

2. Install dependencies
```bash
npm install
```

3. Set up environment variables
Create a .env file in the root directory with the following:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=coursemap
PORT=5000
```

4. Initialize the database
```bash
# Import the SQL script provided in the database folder
mysql -u root < database/coursemap.sql
```

5. Start the application
```bash
npm start
```

The application will be running at `http://localhost:5000`

## Project Structure

```
coursemap/
├── controllers/        # Database controllers
├── public/            # Static assets
│   ├── assets/        # Images and media
│   ├── stylesheets/   # CSS files
│   └── javascripts/   # Client-side JS
├── views/             # HTML templates
├── .js            # Main application file
└── dbConfig.js       # Database configuration
```

## Available Scripts

* `npm start`: Runs the server in development mode
* `npm run dev`: Runs the server with nodemon for development



## Team Members

* [Peter Madin]
* [Sopeanith Ny]
* [Elias Arriola]
* [Ahmed Hassan]


## Acknowledgments

* University of Washington Tacoma
* TCSS 445 Database Systems Design