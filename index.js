const express = require('express');
const ejs = require('ejs');
const util = require('util');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const path = require("path");

/**
 * The following constants with your MySQL connection properties
 * You should only need to change the password
 */

const PORT = 8000;
const DB_HOST = 'localhost';
const DB_USER = 'root';
const DB_PASSWORD = '64HarrowLane';
const DB_NAME = 'coursework';
const DB_PORT = 3306;

/**
 * DO NOT CHANGE ANYTHING BELOW THIS LINE UP TO THE NEXT COMMENT
 */
var connection = mysql.createConnection({
	host: DB_HOST,
	user: DB_USER,
	password: DB_PASSWORD,
	database: DB_NAME,
	port: DB_PORT
});


connection.query = util.promisify(connection.query).bind(connection);

connection.connect(function (err) {
	if (err) {
		console.error('error connecting: ' + err.stack);
		console.log('Please make sure you have updated the password in the index.js file. Also, ensure you have run db_setup.sql to create the database and tables.');
		return;
	}
	console.log('Connected to the Database');
});


const app = express();

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: false }));

/**
 * YOU CAN CHANGE THE CODE BELOW THIS LINE
 */

// Add your code here


app.get('/', async (req, res) => {
	const courses = await connection.query("SELECT Crs_Enrollment, Crs_Title FROM Course ORDER BY Crs_Enrollment DESC");
	var totalEnrollments = 0;
	for (let index = 0; index < courses.length; index++) {
		totalEnrollments += courses[index].Crs_Enrollment;
		var count = index + 1;
	}
	averageEnrollments = totalEnrollments / count;
	res.render("index", {
		courseCount: courses.length,
		totalEnrollments: totalEnrollments,
		averageEnrollments: averageEnrollments,
		highestEnrollments: courses[0].Crs_Title,
		lowestEnrollments: courses[count - 1].Crs_Title
	});
});

app.get('/courses', async (req, res) => {
	const courses = await connection.query("SELECT * FROM Course");
	res.render("courses", { courses: courses });
});

app.get('/edit-course/:id', async (req, res) => {
	const courses = await connection.query("SELECT * FROM Course WHERE Crs_Code = ?", [req.params.id])
	res.render("edit", {
		course: courses[0],
		message: ""
	});
});




app.get('/create-course', async (req, res) => {
	res.render("create", {
		message: ""
	});
});


app.post("/edit-course/:id", async (req, res) => {
	var message = "";

	if (isNaN(req.body.Crs_Enrollment) || req.body.Crs_Enrollment > 10000 || req.body.Crs_Enrollment < 0) {
		message = "Please enter a valid enrollment value.";
	} else if (req.body.Crs_Title.length > 250 || req.body.Crs_Title.length < 10) {
		message = "Please ensure that the course title is between 10 and 250 characters long."
	} else {
		await connection.query("UPDATE Course SET ? WHERE Crs_Code = ?", [req.body, req.params.id]);
		message = "Course Updated"
	}

	const courses = await connection.query("SELECT * FROM Course WHERE Crs_Code = ?", [req.params.id]);

	res.render("edit", {
		course: courses[0],
		message: message
	});
});


app.post("/create-course", async (req, res) => {
	var message = "";
	var unique = true;
	const courses = await connection.query("SELECT * FROM Course");


	courses.forEach(course => {
		if (course.Crs_Code == req.body.Crs_Code) {
			unique = false;
		}
	});

	if (isNaN(req.body.Crs_Code) || req.body.Crs_Code < 0) {
		message = "Please enter a valid course code.";
	} else if (isNaN(req.body.Crs_Enrollment) || req.body.Crs_Enrollment > 10000 || req.body.Crs_Enrollment < 0) {
		message = "Please enter a valid enrollment value.";
	} else if (req.body.Crs_Title.length > 250 || req.body.Crs_Title.length < 10) {
		message = "Please ensure that the course title is between 10 and 250 characters long."
	} else if (!unique) {
		message = "Please ensure that the course code is unique."
	} else {
		await connection.query("INSERT INTO Course VALUES (?, \?\, ?)", [parseInt(req.body.Crs_Code), req.body.Crs_Title, parseInt(req.body.Crs_Enrollment)]);
		message = "Course added";
	}

	res.render("create", {
		message: message
	});
});

/**
 * DON'T CHANGE ANYTHING BELOW THIS LINE
 */

app.listen(PORT, () => {

	console.log(`Server is running on port http://localhost:${PORT}`);

});



exports.app = app;