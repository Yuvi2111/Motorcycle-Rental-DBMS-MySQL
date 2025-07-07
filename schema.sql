create database Motorcycle_Rental;
use Motorcycle_Rental;

-- USER Table 
create table user (
DL_Number varchar(50) primary key,
First_name varchar(50),
Last_name varchar(50),
Email varchar(100) unique,
Password varchar(255),
Phone varchar(20)
);
desc BIKE;

CREATE TABLE BIKE (
    Bike_ID INT PRIMARY KEY AUTO_INCREMENT,
    Bike_Name VARCHAR(100) NOT NULL,
    Bike_Type VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Color VARCHAR(50),
    Availability BOOLEAN DEFAULT TRUE
);

-- Terminal Table
create table TERMINAL (
	Terminal_ID int primary key auto_increment,
    Terminal_Name varchar(100),
    No_of_Bikes int
);
desc TERMINAL;

CREATE TABLE PAYMENT (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Transaction_ID INT,
    Cost DECIMAL(10,2) NOT NULL,
    Mode_of_Payment VARCHAR(50) NOT NULL,
    Date DATE NOT NULL,
    Receipt_no VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (Transaction_ID) REFERENCES TRANSACTION_TABLE(Transaction_ID) ON DELETE CASCADE
);

CREATE TABLE TRANSACTION_TABLE (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    DL_Number VARCHAR(50),
    Bike_ID INT,
    Start_Time DATETIME NOT NULL,
    End_Time DATETIME NOT NULL,
    FOREIGN KEY (DL_Number) REFERENCES USER(DL_Number) ON DELETE CASCADE,
    FOREIGN KEY (Bike_ID) REFERENCES BIKE(Bike_ID) ON DELETE CASCADE
);
-- customer Review
CREATE TABLE REVIEW (
    Review_ID INT PRIMARY KEY AUTO_INCREMENT,
    DL_Number VARCHAR(50),
    Bike_ID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    Review_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DL_Number) REFERENCES USER(DL_Number) ON DELETE CASCADE,
    FOREIGN KEY (Bike_ID) REFERENCES BIKE(Bike_ID) ON DELETE CASCADE
);
-- Bike Terminal
CREATE TABLE TERMINAL_BIKE (
    Terminal_ID INT,
    Bike_ID INT,
    Available BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (Terminal_ID, Bike_ID),
    FOREIGN KEY (Terminal_ID) REFERENCES TERMINAL(Terminal_ID) ON DELETE CASCADE,
    FOREIGN KEY (Bike_ID) REFERENCES BIKE(Bike_ID) ON DELETE CASCADE
);
-- LOGS Table (Tracks user and admin activities)
CREATE TABLE LOGS (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID VARCHAR(50),
    Action VARCHAR(255),
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES USER(DL_Number) ON DELETE CASCADE
);
-- DISCOUNT Table (Stores discount codes for payments)
CREATE TABLE DISCOUNT (
    Discount_ID INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Discount_Percentage DECIMAL(5,2) CHECK (Discount_Percentage BETWEEN 0 AND 100),
    Expiry_Date DATE NOT NULL
);