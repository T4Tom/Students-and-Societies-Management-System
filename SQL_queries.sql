USE coursework;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Query 1: Returns the number of students per course
SELECT Count(*) AS NumOfStudents, Course.Crs_Title
FROM Student
INNER JOIN Course ON Student.Stu_Course = Course.CRS_CODE
GROUP BY Student.Stu_Course;

-- Query 2: Returns the first and last name of every student taking Computer Science
SELECT Stu_FName, Stu_LName
FROM Student
WHERE Stu_Course = (
    SELECT CRS_CODE
    FROM Course
    WHERE Crs_Title = 'BSc Computer Science'
);

-- Query 3: Returns the first and last names, number of credits scored and course of every undergraduate student in the database, with results ordered by the name of the course they take.
SELECT UG_URN, Stu_FName, Stu_LName, UG_Credits, Crs_Title
FROM (
    Course INNER JOIN Student ON Student.Stu_Course = Course.CRS_CODE
)
INNER JOIN Undergraduate ON Undergraduate.UG_URN = Student.URN
ORDER BY Course.CRS_CODE;


-- If you want to do some more queries as the extra challenge task you can include them here

/* Returns information about events from societies for a particular
student (in this case, URN 612351) based on the category of hobbies they have.
For example, if a student enjoys a creative hobby such as painting, they will
be shown a list creative societies that they may wish to join. */
SELECT Soc_Category, Event_Name, Event_Description, Event_Date, Event_Time, Event_Location
FROM (
    Event INNER JOIN Society ON Event.Soc_ID = Society.SOC_ID
)
INNER JOIN Hobby ON Society.Soc_Category IN (
    SELECT Hob_Category
    FROM Hobby
    WHERE HOB_ID IN (
        SELECT HOB_ID
        FROM Enjoys
        WHERE URN = '612351'
    )
)
GROUP BY EVENT_ID;