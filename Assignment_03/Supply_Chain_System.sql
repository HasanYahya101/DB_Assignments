use master;
GO
CREATE DATABASE Supply_Chain_System;
GO
use [Supply_Chain_System];

-- Creating tables
CREATE TABLE Suppliers
(
    snum CHAR(2) PRIMARY KEY NOT NULL,
    sname VARCHAR(100) NOT NULL,
    status INT NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE Parts
(
    pnum CHAR(2) PRIMARY KEY NOT NULL,
    pname VARCHAR(100) NOT NULL,
    color VARCHAR(100) NOT NULL,
    weight INT NOT NULL DEFAULT 0,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE Jobs
(
    jnum CHAR(2) PRIMARY KEY NOT NULL,
    jname VARCHAR(100) NOT NULL,
    numworkers INT NOT NULL DEFAULT 0,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE Shipments
(
    snum CHAR(2) NOT NULL,
    pnum CHAR(2) NOT NULL,
    jnum CHAR(2) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (snum, pnum, jnum),
    FOREIGN KEY (snum) REFERENCES Suppliers(snum),
    FOREIGN KEY (pnum) REFERENCES Parts(pnum),
    FOREIGN KEY (jnum) REFERENCES Jobs(jnum)
);

-- Inserting data into tables
INSERT INTO Suppliers (snum, sname, status, city) 
VALUES ('S1', 'SMITH', 20, 'LONDON'),
       ('S2', 'JONES', 10, 'PARIS'),
       ('S3', 'BLAKE', 30, 'PARIS'),
       ('S4', 'CLARK', 20, 'LONDON'),
       ('S5', 'ADAMS', 30, 'ATHENS');

INSERT INTO Parts (pnum, pname, color, weight, city)
VALUES ('P1', 'NUT', 'RED', 12, 'LONDON'),
       ('P2', 'BOLT', 'GREEN', 17, 'PARIS'),
       ('P3', 'SCREW', 'BLUE', 17, 'ROME'),
       ('P4', 'SCREW', 'RED', 14, 'LONDON'),
       ('P5', 'CAM', 'BLUE', 12, 'PARIS'),
       ('P6', 'COG', 'RED', 19, 'LONDON');

INSERT INTO Jobs (jnum, jname, numworkers, city)
VALUES  ('J1', 'SORTER', 20, 'PARIS'),
        ('J2', 'PUNCH', 10, 'ROME'),
        ('J3', 'READER', 30, 'ATHENS'),
        ('J4', 'CONSOLE', 20, 'ATHENS'),
        ('J5', 'COLLATOR', 30, 'LONDON'),
        ('J6', 'TERMINAL', 20, 'OSLO'),
        ('J7', 'TAPE', 10, 'LONDON');

INSERT INTO Shipments (snum, pnum, jnum, quantity)
VALUES ('S1', 'P1', 'J1', 200),
       ('S1', 'P1', 'J4', 700),
       ('S2', 'P3', 'J1', 400),
       ('S2', 'P3', 'J2', 200),
       ('S2', 'P3', 'J3', 200),
       ('S2', 'P3', 'J4', 500),
       ('S2', 'P3', 'J5', 600),
       ('S2', 'P3', 'J6', 400),
       ('S2', 'P3', 'J7', 800),
       ('S2', 'P5', 'J2', 100),
       ('S3', 'P3', 'J1', 200),
       ('S3', 'P4', 'J2', 500),
       ('S4', 'P6', 'J3', 300),
       ('S4', 'P6', 'J7', 300),
       ('S5', 'P2', 'J2', 200),
       ('S5', 'P2', 'J4', 100),
       ('S5', 'P5', 'J5', 500),
       ('S5', 'P5', 'J7', 100),
       ('S5', 'P6', 'J2', 200),
       ('S5', 'P1', 'J4', 100),
       ('S5', 'P3', 'J4', 200),
       ('S5', 'P4', 'J4', 800),
       ('S5', 'P5', 'J4', 400),
       ('S5', 'P6', 'J4', 500);

-- Selecting data from tables for checking
SELECT * FROM Suppliers;
SELECT * FROM Parts;
SELECT * FROM Jobs;
SELECT * FROM Shipments;

-- Q1: List the part number for every part that is shipped by more than one supplier.
SELECT pnum
FROM Shipments
GROUP BY pnum
HAVING COUNT(DISTINCT snum) > 1;

-- Q2: Find the average weight of all parts.
SELECT AVG(weight) AS average_weight
FROM Parts;

-- Q3: For each part list the part number and the total quantity in which that part is shipped and order the results in descending order of the total quantity shipped. Name the total quantity shipped in the result as total Shipped.
SELECT pnum, SUM(quantity) AS total_shipped
FROM Shipments
GROUP BY pnum
ORDER BY total_shipped DESC;

-- Q4: List only the names of those suppliers who ship a part that weighs more than 200.
SELECT DISTINCT sname
FROM Suppliers
JOIN Shipments ON Suppliers.snum = Shipments.snum
JOIN Parts ON Shipments.pnum = Parts.pnum
WHERE weight > 200;

-- Q5: List the names of those cities in which both a supplier and a job are located.
SELECT city
FROM Suppliers
INTERSECT
SELECT city
FROM Jobs;

-- Q6: List the names of those jobs that receive a shipment from supplier number S1.
SELECT DISTINCT jname
FROM Jobs
JOIN Shipments ON Jobs.jnum = Shipments.jnum
WHERE snum = 'S1';

-- Q7: List the names of those parts that are not shipped to any job.
SELECT pname
FROM Parts
WHERE pnum NOT IN (SELECT pnum FROM Shipments);

-- Q8: List the names of those suppliers who ship part number P2 to any job.
SELECT DISTINCT sname
FROM Suppliers
JOIN Shipments ON Suppliers.snum = Shipments.snum
WHERE pnum = 'P2';

-- Q9: List the names of those suppliers who ship part at least one red part to any job.
SELECT DISTINCT sname
FROM Suppliers
JOIN Shipments ON Suppliers.snum = Shipments.snum
JOIN Parts ON Shipments.pnum = Parts.pnum
WHERE color = 'RED';

-- Q10: List the part number for every part that is shipped more than once (the part must be shipped more than one time).
SELECT pnum
FROM Shipments
GROUP BY pnum
HAVING COUNT(pnum) > 1;

-- Finally Drop the tables and Delete the Database (because the Assignment is done)
DROP TABLE Shipments;
DROP TABLE Suppliers;
DROP TABLE Parts;
DROP TABLE Jobs;

-- Drop the database
use master;
go
DROP DATABASE Supply_Chain_System;