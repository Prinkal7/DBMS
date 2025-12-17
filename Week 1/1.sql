SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS newdatabase;

USE newdatabase;

CREATE TABLE uno (
    name VARCHAR(2)
);

CREATE TABLE student (
    stdid INT,
    stdname VARCHAR(20),
    dob DATE,
    doj DATE,
    fee INT,
    gender VARCHAR(50)
);

DESC student;

INSERT INTO student VALUES
(1,'SHAREEF','2001-01-10','2001-10-05',1000,'M'),
(2,'NADEEM','2001-10-05','2001-10-25',1100,'M');

ALTER TABLE student ADD phone_no INT;

ALTER TABLE student CHANGE phone_no student_no INT;

SELECT * FROM student;

DELETE FROM student WHERE stdid = 2;