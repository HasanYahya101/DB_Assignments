-- Create the Database
use master
go
create database Exam_Project_System;

-- Use the Database
use [Exam_Project_System];

-- Drop all tables if exist
DROP TABLE Staff_Member;
DROP TABLE Project;
DROP TABLE Student;
DROP TABLE Exam;

-- Select all values in tables
SELECT * FROM Staff_Member;
SELECT * FROM Project;
SELECT * FROM Student;
SELECT * FROM Exam;

-- Create Table Staff_Member
create table Staff_Member
(
    F_Name varchar(100) NOT NULL,
    L_Name varchar(100) NOT NULL,
    User_No int PRIMARY KEY NOT NULL,
);

-- Create table Project
create table Project
(
    Proj_No INT NOT NULL PRIMARY KEY,
    Project_Name VARCHAR(100) NOT NULL,
    Level INT NOT NULL,
    Keywords VARCHAR(100) NOT NULL,
    Description VARCHAR(100) NOT NULL
);

-- Create Table Student
create table Student
(
    F_Name VARCHAR(100) NOT NULL,
    L_Name VARCHAR(100) NOT NULL,
    User_No int PRIMARY KEY NOT NULL,
    Project_No int NOT NULL,
    Super_No int NOT NULL,
    FOREIGN KEY (Super_No) REFERENCES Staff_Member(User_No),
    Assessor1 VARCHAR NOT NULL,
    Assessor2 VARCHAR NOT NULL,
    FOREIGN KEY (Project_No) REFERENCES Project(Proj_No)
);

-- Create Table Exam
create table Exam
(
    Stud_User_No INT NOT NULL,
    Exam_No INT NOT NULL,
    Time Time NOT NULL,
    Day INT NOT NULL,
    Room_No INT NOT NULL,
    -- stud_user_no refrences user no in student
    FOREIGN KEY (Stud_User_No) REFERENCES Student(User_No),
    PRIMARY KEY (Stud_User_No, Exam_No)
);

-- 1) Insert values into Staff_Member table
INSERT INTO Staff_Member (F_Name, L_Name, User_No) 
VALUES ('Hasan', 'Yahya', 1001),
       ('Wasee', 'Rehman', 1002),
       ('Zayed', 'Abdullah', 1003);

-- Insert values into Project table
INSERT INTO Project (Proj_No, Project_Name, Level, Keywords, Description)
VALUES (1, 'Weather', 1, 'Weather, App', 'Made using Javascript'),
       (2, 'Pacman', 2, 'Pacman, SFML', 'Made using C++ and SFML Library'),
       (3, 'Sudoku', 3, 'Sudoku, SFML', 'Made using C++ and SFML Library');

-- Alter Table Student
ALTER TABLE Student
ALTER COLUMN Assessor1 VARCHAR(100) NOT NULL;
ALTER TABLE Student
ALTER COLUMN Assessor2 VARCHAR(100) NOT NULL;

-- Insert values into Student table
INSERT INTO Student (F_Name, L_Name, User_No, Project_No, Super_No, Assessor1, Assessor2)
VALUES ('Ali', 'Sahab', 1010, 1, 1001, 'Assessor1A', 'Assessor2A'),
       ('Michael', 'Johnson', 1011, 2, 1002, 'Assessor1B', 'Assessor2B'),
       ('Mani', 'Hasan', 1012, 2, 1002, 'Assessor1C', 'Assessor2C');

-- Insert values into Exam table
INSERT INTO Exam (Stud_User_No, Exam_No, Time, Day, Room_No)
VALUES (1010, 1, '09:00:00', 1, 005),
       (1011, 1, '10:30:00', 1, 009),
       (1011, 4, '10:30:00', 1, 007);

-- Now all Values have been entered into Tables

-- 2) Delete the records of all students who are working on project no 10.
DELETE FROM Student
WHERE Project_No = 10;

-- 3) Change the level of projects from 4 to 5 which have ‘Android’ in their keywords.
UPDATE Project
SET Level = 5
WHERE Keywords LIKE '%Android%' AND Level = 4;

-- 4) Write query for the following problems:
-- 1. Find exam time and date of student user no: 1010 and Room_no = 005
SELECT Time, Day
FROM Exam
WHERE Stud_User_No = 1010 AND Room_No = 005;

-- 2. Show all project names in descending order.
SELECT Project_Name
FROM Project
ORDER BY Project_Name DESC;

-- 3. Show fname of staff member with L_Name starting with A and ending with A.
SELECT F_Name
FROM Staff_Member
WHERE L_Name LIKE 'A%A';

-- 4. Show name of student who has not been assigned any supervisor as yet.
SELECT F_Name, L_Name
FROM Student
WHERE Super_No IS NULL;

-- 5. Show user no who are sitting between room 005 and 009 during exam.
SELECT Stud_User_No
FROM Exam
WHERE Room_No BETWEEN 005 AND 009;

-- 6. Show students name with its supervisor name and project number.
SELECT S.F_Name, S.L_Name, SM.F_Name, SM.L_Name, S.Project_No
FROM Student S
JOIN Staff_Member SM
ON S.Super_No = SM.User_No;