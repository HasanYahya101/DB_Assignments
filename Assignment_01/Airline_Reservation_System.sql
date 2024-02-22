-- Create the Database
use master
go
create database Airline_Reservation_System

-- Use the Database
use [Airline_Reservation_System];

-- Create Table Airport
CREATE TABLE Airport (
    airport_code VARCHAR(10) PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL
);

-- Create Table Flight
CREATE TABLE Flight (
    number INT PRIMARY KEY,
    airline VARCHAR(100),
    weekdays VARCHAR(50)
);

-- Create Table Flight_Leg
CREATE TABLE Flight_Leg (
    Leg_no INT NOT NULL,
    number INT NOT NULL, -- This is connected to the Flight Number from the Flight Table
    FOREIGN KEY (number) REFERENCES Flight(number),
    PRIMARY KEY (Leg_no, number)
);

-- Create Table Departure_Airport
CREATE TABLE Departure_Airport (
    scheduled_dep_time DATETIME NOT NULL,
    airport_code VARCHAR(10) NOT NULL, -- This is connected to Airport Code from Airport Table
    Leg_no INT NOT NULL, -- This is connected to Leg Number from Flight_Leg Table
    number INT NOT NULL, -- This is connected to Flight Number from Flight Table
    FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (Leg_no, number) REFERENCES Flight_Leg(Leg_no, number), -- Referencing both columns in Flight_Leg
    PRIMARY KEY (airport_code, Leg_no)
);

-- Create Table Departure_Airport
CREATE TABLE Arival_Airport (
    scheduled_arr_time DATETIME NOT NULL,
    airport_code VARCHAR(10) NOT NULL, -- This is connected to Airport Code from Airport Table
    Leg_no INT NOT NULL, -- This is connected to Leg Number from Flight_Leg Table
    number INT NOT NULL, -- This is connected to Flight Number from Flight Table
    FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (Leg_no, number) REFERENCES Flight_Leg(Leg_no, number), -- Referencing both columns in Flight_Leg
    PRIMARY KEY (airport_code, Leg_no)
);

-- Create Table Airplane_Type
CREATE TABLE Airplane_Type (
    Type_name VARCHAR(100) PRIMARY KEY,
    Company VARCHAR(100) NOT NULL,
    Max_Seats INT NOT NULL
);

-- Create Table Airplane
CREATE TABLE Airplane (
    Airplane_ID INT PRIMARY KEY,
    Total_Seats INT NOT NULL,
);

-- Create Table Flight_Leg
CREATE TABLE Fare (
    Code INT NOT NULL,
    Restrictions VARCHAR(100) NOT NULL,
    Amount INT NOT NULL,
    number INT NOT NULL, -- This is connected to the Flight Number from the Flight Table
    FOREIGN KEY (number) REFERENCES Flight(number),
    PRIMARY KEY (Code, number)
);

-- Create Table Leg_Instance
CREATE TABLE Leg_Instance (
    No_of_seats INT NOT NULL,
    Date DATE NOT NULL,
    Leg_no INT NOT NULL,
    number INT NOT NULL, -- This is connected to the Flight Number from the Flight Table
    FOREIGN KEY (number) REFERENCES Flight(number),
    FOREIGN KEY (Leg_no, number) REFERENCES Flight_Leg(Leg_no, number), -- Referencing both columns in Flight_Leg
    PRIMARY KEY (Leg_no, number, Date)
);

-- Create Can_Land Table
CREATE TABLE Can_Land (
    Type_name VARCHAR(100) NOT NULL, -- This is connected to Type Name from Airplane Type Table
    airport_code VARCHAR(10) NOT NULL, -- This is connected to Airport Code from Airport Table
    FOREIGN KEY (Type_name) REFERENCES Airplane_Type(Type_name),
    FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
    PRIMARY KEY (Type_name, airport_code)
);

-- Alter Table Airplane to add Type_name as Foreign Key
ALTER TABLE Airplane
ADD Type_name VARCHAR(100) NOT NULL,
FOREIGN KEY (Type_name) REFERENCES Airplane_Type(Type_name);

-- Alter Table Leg_Instance to add Airplane_ID as Foreign Key
ALTER TABLE Leg_Instance
ADD Airplane_ID INT NOT NULL,
FOREIGN KEY (Airplane_ID) REFERENCES Airplane(Airplane_ID);

-- Create Table Departs
CREATE TABLE Departs (
    Dep_time TIME NOT NULL,
    Airport_code VARCHAR(10) NOT NULL, -- This is connected to Airport Code from Airport Table
    Date DATE NOT NULL, -- This is connected to Date from Leg_Instance Table
    Leg_no INT NOT NULL, -- This is connected to Leg Number from Flight_Leg Table
    number INT NOT NULL, -- This is connected to Flight Number from Flight Table
    FOREIGN KEY (Airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (Leg_no, number, Date) REFERENCES Leg_Instance(Leg_no, number, Date), -- Referencing all columns in Leg_Instance
    PRIMARY KEY (Airport_code, Date, Leg_no, number)
);

-- Create Table Arrives
CREATE TABLE Arrives (
    Arr_time TIME NOT NULL,
    Airport_code VARCHAR(10) NOT NULL, -- This is connected to Airport Code from Airport Table
    Date DATE NOT NULL, -- This is connected to Date from Leg_Instance Table
    Leg_no INT NOT NULL, -- This is connected to Leg Number from Flight_Leg Table
    number INT NOT NULL, -- This is connected to Flight Number from Flight Table
    FOREIGN KEY (Airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (Leg_no, number, Date) REFERENCES Leg_Instance(Leg_no, number, Date), -- Referencing all columns in Leg_Instance
    PRIMARY KEY (Airport_code, Date, Leg_no, number)
);

-- Create table Seat
CREATE TABLE Seat (
    Seat_no INT NOT NULL,
    Customer_name VARCHAR(100) NOT NULL,
    Cphone INT NOT NULL,
    DATE DATE NOT NULL, -- This is connected to Date from Leg_Instance Table
    Leg_no INT NOT NULL, -- This is connected to Leg Number from Flight_Leg Table
    number INT NOT NULL, -- This is connected to Flight Number from Flight Table
    FOREIGN KEY (Leg_no, number, Date) REFERENCES Leg_Instance(Leg_no, number, Date), -- Referencing all columns in Leg_Instance
    PRIMARY KEY (Seat_no, Date, Leg_no, number)
);

-- Create table Reservation
CREATE TABLE Reservation (
    Seat_no INT NOT NULL,
    Customer_name VARCHAR(100) NOT NULL,
    Cphone INT NOT NULL,
    DATE DATE NOT NULL, -- This is connected to Date from Leg_Instance Table
    Leg_no INT NOT NULL, -- This is connected to Leg Number from Flight_Leg Table
    number INT NOT NULL, -- This is connected to Flight Number from Flight Table
    FOREIGN KEY (Leg_no, number, Date) REFERENCES Leg_Instance(Leg_no, number, Date), -- Referencing all columns in Leg_Instance
    PRIMARY KEY (Seat_no, Date, Leg_no, number)
);

-- Print all Table
SELECT * FROM Airport;
SELECT * FROM Flight;
SELECT * FROM Flight_Leg;
SELECT * FROM Departure_Airport;
SELECT * FROM Arival_Airport;
SELECT * FROM Airplane_Type;
SELECT * FROM Airplane;
SELECT * FROM Fare;
SELECT * FROM Leg_Instance;
SELECT * FROM Can_Land;
SELECT * FROM Departs;
SELECT * FROM Arrives;
SELECT * FROM Seat;
SELECT * FROM Reservation;

-- Drop the Tables
DROP TABLE Airport;
DROP TABLE Flight;
DROP TABLE Flight_Leg;
DROP TABLE Departure_Airport;
DROP TABLE Arival_Airport;
DROP TABLE Airplane_Type;
DROP TABLE Airplane;
DROP TABLE Fare;
DROP TABLE Leg_Instance;
DROP TABLE Can_Land;
DROP TABLE Departs;
DROP TABLE Arrives;
DROP TABLE Seat;
DROP TABLE Reservation;

-- Drop the Database
DROP DATABASE Airline_Reservation_System;