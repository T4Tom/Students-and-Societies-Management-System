DROP DATABASE IF EXISTS coursework;

CREATE DATABASE coursework;

USE coursework;

-- This is the Course table
 
DROP TABLE IF EXISTS Course;

CREATE TABLE Course (
CRS_CODE 	INT UNSIGNED NOT NULL,
Crs_Title 	VARCHAR(255) NOT NULL,
Crs_Enrollment INT UNSIGNED,
PRIMARY KEY (CRS_CODE));


INSERT INTO Course VALUES 
(100,'BSc Computer Science', 150),
(101,'BSc Computer Information Technology', 20),
(200, 'MSc Data Science', 100),
(201, 'MSc Security', 30),
(210, 'MSc Electrical Engineering', 70),
(211, 'BSc Physics', 100);


-- This is the student table definition


DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
URN INT UNSIGNED NOT NULL,
Stu_FName 	VARCHAR(255) NOT NULL,
Stu_LName 	VARCHAR(255) NOT NULL,
Stu_DOB 	DATE,
Stu_Email 	VARCHAR(100),
Stu_Course	INT UNSIGNED NOT NULL,
Stu_Type 	ENUM('UG', 'PG'),
PRIMARY KEY (URN),
FOREIGN KEY (Stu_Course) REFERENCES Course (CRS_CODE)
ON DELETE RESTRICT);


INSERT INTO Student VALUES
(612345, 'Sara', 'Khan', '2002-06-20', 'sk28962@surrey.ac.uk', 100, 'UG'),
(612346, 'Pierre', 'Gervais', '2002-03-12', 'pg82651@surrey.ac.uk', 100, 'UG'),
(612347, 'Patrick', 'O-Hara', '2001-05-03', 'po67517@surrey.ac.uk', 100, 'UG'),
(612348, 'Iyabo', 'Ogunsola', '2002-04-21', 'io67210@surrey.ac.uk', 100, 'UG'),
(612349, 'Omar', 'Sharif', '2001-12-29', 'os61286@surrey.ac.uk', 100, 'UG'),
(612350, 'Yunli', 'Guo', '2002-06-07', 'yg04557@surrey.ac.uk', 100, 'UG'),
(612351, 'Costas', 'Spiliotis', '2002-07-02', 'sc25937@surrey.ac.uk', 100, 'UG'),
(612352, 'Tom', 'Jones', '2001-10-24',  'tj01638@surrey.ac.uk', 101, 'UG'),
(612353, 'Simon', 'Larson', '2002-08-23', 'sl96258@surrey.ac.uk', 101, 'UG'),
(612354, 'Sue', 'Smith', '2002-05-16', 'ss57298@surrey.ac.uk', 101, 'UG');

DROP TABLE IF EXISTS Undergraduate;

CREATE TABLE Undergraduate (
UG_URN 	INT UNSIGNED NOT NULL,
UG_Credits   INT NOT NULL,
CHECK (60 <= UG_Credits <= 150),
PRIMARY KEY (UG_URN),
FOREIGN KEY (UG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Undergraduate VALUES
(612345, 120),
(612346, 90),
(612347, 150),
(612348, 120),
(612349, 120),
(612350, 60),
(612351, 60),
(612352, 90),
(612353, 120),
(612354, 90);

DROP TABLE IF EXISTS Postgraduate;

CREATE TABLE Postgraduate (
PG_URN 	INT UNSIGNED NOT NULL,
Thesis  VARCHAR(512) NOT NULL,
PRIMARY KEY (PG_URN),
FOREIGN KEY (PG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);


-- Please add your table definitions below this line.......

DROP TABLE IF EXISTS Academic;

CREATE TABLE Academic (
ACAD_ID INT UNSIGNED NOT NULL,
Acad_FName VARCHAR(255) NOT NULL,
Acad_LName VARCHAR(255) NOT NULL,
Acad_DOB DATE,
Acad_Email VARCHAR(100),
Acad_Course INT UNSIGNED NOT NULL,
PRIMARY KEY (ACAD_ID),
FOREIGN KEY (Acad_Course) REFERENCES Course(CRS_CODE));


INSERT INTO Academic VALUES
(622961, 'John', 'Doe', '1945-12-28', 'jd62718@surrey.ac.uk', 200),
(957699, 'Jane', 'Smith', '1947-03-13', 'js14015@surrey.ac.uk', 101),
(592653, 'David', 'Lee', '1951-04-13', 'dl54635@surrey.ac.uk', 101),
(158148, 'Sarah', 'Jones', '1936-01-21', 'sj98964@surrey.ac.uk', 100),
(748265, 'Michael', 'Brown', '1943-01-21', 'mb38157@surrey.ac.uk', 200),
(615446, 'Tom', 'Davis', '1961-09-12', 'td57107@surrey.ac.uk', 210),
(199913, 'Daniel', 'Miller', '1932-05-19', 'dm54038@surrey.ac.uk', 201),
(622085, 'Olivia', 'Wilson', '1959-09-25', 'ow51121@surrey.ac.uk', 200),
(596799, 'James', 'Moore', '1988-04-27', 'jm80019@surrey.ac.uk', 211),
(404817, 'Chloe', 'Taylor', '1956-11-28', 'ct95438@surrey.ac.uk', 211);


DROP TABLE IF EXISTS Hobby;

CREATE TABLE Hobby (
HOB_ID INT UNSIGNED NOT NULL,
Hob_Name VARCHAR(255) NOT NULL,
Hob_Category VARCHAR(512),
PRIMARY KEY (HOB_ID));


INSERT INTO Hobby VALUES
(1, 'Reading', 'Intellectual'),
(2, 'Gardening', 'Outdoor'),
(3, 'Photography', 'Creative'),
(4, 'Cooking', 'Creative'),
(5, 'Hiking', 'Outdoor'),
(6, 'Painting', 'Creative'),
(7, 'Playing video games', 'Gaming'),
(8, 'Charity work', 'Social'),
(9, 'Robots', 'Construction'),
(10, 'Yoga', 'Fitness');


DROP TABLE IF EXISTS Enjoys;

CREATE TABLE Enjoys (
URN INT UNSIGNED NOT NULL,
HOB_ID INT UNSIGNED NOT NULL,
PRIMARY KEY (URN, HOB_ID),
FOREIGN KEY (URN) REFERENCES Student(URN),
FOREIGN KEY (HOB_ID) REFERENCES Hobby(HOB_ID));


INSERT INTO Enjoys VALUES
(612345, 5),
(612351, 3),
(612350, 1),
(612354, 6),
(612347, 2),
(612349, 10),
(612351, 7);


DROP TABLE IF EXISTS Society;

CREATE TABLE Society (
SOC_ID INT UNSIGNED NOT NULL,
Soc_Name VARCHAR(255) NOT NULL,
Soc_Price FLOAT(5, 2) NOT NULL,
Soc_IsTeamSurrey BOOLEAN NOT NULL,
Soc_Category VARCHAR(255),
PRIMARY KEY (SOC_ID));


INSERT INTO Society VALUES
(1, 'Debating Society', 10.00, FALSE, 'Intellectual'),
(2, 'Gaming Club', 5.00, FALSE, 'Gaming'),
(3, 'Photography Society', 8.00, FALSE, 'Creative'),
(4, 'Hiking Club', 0.00, TRUE, 'Fitness'),
(5, 'Music Society', 12.00, FALSE, 'Creative'),
(6, 'Book Club', 3.00, FALSE, 'Intellectual'),
(7, 'Drama Society', 15.00, FALSE, 'Creative'),
(8, 'Coding Club', 0.00, TRUE, 'Intellectual'),
(9, 'Art Society', 7.00, FALSE, 'Creative'),
(10, 'Charity Committee', 0.00, TRUE, 'Social');


DROP TABLE IF EXISTS Joins;

CREATE TABLE Joins (
URN INT UNSIGNED NOT NULL,
SOC_ID INT UNSIGNED NOT NULL,
PRIMARY KEY (URN, SOC_ID),
FOREIGN KEY (URN) REFERENCES Student(URN),
FOREIGN KEY (SOC_ID) REFERENCES Society(SOC_ID));


INSERT INTO Joins VALUES
(612347, 2),
(612351, 5),
(612352, 3),
(612347, 8),
(612345, 5),
(612353, 1),
(612348, 7),
(612349, 10);


DROP TABLE IF EXISTS Event;

CREATE TABLE Event (
EVENT_ID INT UNSIGNED NOT NULL,
Event_Name VARCHAR(255) NOT NULL,
Soc_ID INT UNSIGNED NOT NULL,
Event_Date DATE,
Event_Time TIME,
Event_Location VARCHAR(255),
Event_Description VARCHAR(512),
PRIMARY KEY (EVENT_ID),
FOREIGN KEY (Soc_ID) REFERENCES Society(SOC_ID));


INSERT INTO Event VALUES
(1, 'Workshop: Introduction to SQL', 8, '2024-12-28', '10:00:00', 'Lecture Hall A', 'Learn the basics of SQL in this interactive workshop.'),
(2, 'Movie Night: The Shawshank Redemption', 7, '2024-12-29', '19:00:00', 'Student Lounge', 'Enjoy a classic film with friends.'),
(3, 'Photography Competition', 3, '2024-12-30', '14:00:00', 'Main Field', 'Show off your photography skills and compete against your cohort!'),
(4, 'Library Book Club Meeting', 6, '2024-12-31', '16:00:00', 'Library Meeting Room', 'Discuss the latest book selection.'),
(5, 'New Year''s Eve Celebration', 10, '2024-12-31', '22:00:00', 'Student Union', 'Ring in the New Year with music, food, and friends.'),
(6, 'Career Fair', 2, '2025-01-01', '10:00:00', 'Gymnasium', 'Connect with potential employers and explore career opportunities.'),
(7, 'Open Mic Night', 5, '2025-01-02', '19:00:00', 'Coffee Shop', 'Showcase your talents in music, poetry, comedy, and more.'),
(8, 'Sports Day', 4, '2025-01-03', '10:00:00', 'Sports Field', 'Compete in various sporting events and cheer on your team.'),
(9, 'Guest Lecture: Climate Change', 1, '2025-01-04', '15:00:00', 'Science Building Auditorium', 'Learn about the latest research on climate change.'),
(10, 'Student Art Exhibition', 9, '2025-01-05', '14:00:00', 'Art Gallery', 'View and appreciate the creative works of student artists.');


DROP TABLE IF EXISTS Attends;

CREATE TABLE Attends (
URN INT UNSIGNED NOT NULL,
EVENT_ID INT UNSIGNED NOT NULL,
PRIMARY KEY (URN, EVENT_ID),
FOREIGN KEY (URN) REFERENCES Student(URN),
FOREIGN KEY (EVENT_ID) REFERENCES Event(EVENT_ID));


INSERT INTO Attends VALUES
(612345, 7),
(612346, 3),
(612347, 1),
(612348, 9),
(612349, 5),
(612350, 2),
(612351, 10),
(612352, 8),
(612353, 4),
(612354, 6);