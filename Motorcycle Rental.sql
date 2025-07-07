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
INSERT INTO PAYMENT (Transaction_ID, Cost, Mode_of_Payment, Date, Receipt_no) 
VALUES 
(1, 2000.00, 'Credit Card', '2025-03-10', 'REC12345'),
(2, 1000.00, 'Cash', '2025-03-11', 'REC67890');

CREATE TABLE TRANSACTION_TABLE (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    DL_Number VARCHAR(50),
    Bike_ID INT,
    Start_Time DATETIME NOT NULL,
    End_Time DATETIME NOT NULL,
    FOREIGN KEY (DL_Number) REFERENCES USER(DL_Number) ON DELETE CASCADE,
    FOREIGN KEY (Bike_ID) REFERENCES BIKE(Bike_ID) ON DELETE CASCADE
);
INSERT INTO TRANSACTION_TABLE (DL_Number, Bike_ID, Start_Time, End_Time) 
VALUES 
('DL5678901234', 1, '2025-03-10 10:00:00', '2025-03-10 12:00:00'),
('WB8765432109', 2, '2025-03-11 14:00:00', '2025-03-11 16:00:00');

-- Insert user insert 
INSERT INTO USER (DL_Number, First_name, Last_name, Email, Password, Phone) 
VALUES ('MH012345645', 'Shantnu', 'Chapde', 'shantnuchapde@gmail.com', 'password123', '9876543210'),
('MH0129456789', 'Aditya', 'More', 'adityamore@gmail.com', 'aditya456', '8765432109'),
('MH0123456789', 'Amit', 'Sharma', 'amitsharma@example.com', 'securePass@123', '9876543210'),
('KA0987654321', 'Priya', 'Iyer', 'priyaiyer@example.in', 'passPriya#456', '8765432109'),
('DL5678901234', 'Rahul', 'Verma', 'rahulverma@example.in', 'rahul@verma789', '9123456789'),
('TN4321098765', 'Sneha', 'Ravi', 'sneharavi@example.in', 'SnehaR@vi999', '9988776655'),
('WB8765432109', 'Arjun', 'Mukherjee', 'arjunmukherjee@example.in', 'Arjun@Mukh567', '9345678901');
select*from USER;


-- Insert Terminal Table
INSERT INTO TERMINAL (Terminal_Name, No_of_Bikes) 
VALUES 
('Connaught Place Terminal', 12),  
('Marine Drive Terminal', 8),  
('MG Road Terminal', 10),  
('Brigade Road Terminal', 6),  
('Charminar Terminal', 7),  
('Bandra West Terminal', 9);  
SELECT * FROM TERMINAL;


--  Insert Admin 
INSERT INTO ADMIN (Email, Password) 
VALUES ('admin@rental.com', 'adminpass');

-- Insert bikes 
INSERT INTO BIKE (Bike_Name, Bike_Type, Model, Price, Color, Availability) 
VALUES 
('Yamaha R15', 'Sport', '2023', 100.00, 'Blue', TRUE),
('Honda Activa', 'Scooter', '2022', 50.00, 'White', TRUE),
('Royal Enfield', 'Cruiser', '2024', 150.00, 'Black', TRUE),
('Bajaj Pulsar 220F', 'Street', '2023', 90.00, 'Red', TRUE),  
('TVS Apache RTR 160', 'Street', '2023', 85.00, 'Black', TRUE),  
('Hero Splendor Plus', 'Commuter', '2024', 60.00, 'Silver', TRUE),  
('Jawa 42', 'Classic', '2023', 130.00, 'Green', TRUE);  
select*from BIKE;


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
INSERT INTO REVIEW (DL_Number, Bike_ID, Rating, Comment) 
VALUES 
('TN4321098765', 1, 5, 'Amazing ride! Super smooth.'),
('MH0123456789', 2, 4, 'Comfortable and easy to handle.'),
('WB8765432109', 7, 4, 'Classic styling with a comfortable seat. Perfect for long rides!'),
('DL5678901234', 5, 3, 'Powerful engine with great road grip. Feels sturdy and reliable!'),
('KA0987654321', 4, 4, 'Great city ride—smooth handling and excellent fuel efficiency!');


-- Bike Terminal
CREATE TABLE TERMINAL_BIKE (
    Terminal_ID INT,
    Bike_ID INT,
    Available BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (Terminal_ID, Bike_ID),
    FOREIGN KEY (Terminal_ID) REFERENCES TERMINAL(Terminal_ID) ON DELETE CASCADE,
    FOREIGN KEY (Bike_ID) REFERENCES BIKE(Bike_ID) ON DELETE CASCADE
);
INSERT INTO TERMINAL_BIKE (Terminal_ID, Bike_ID, Available) 
VALUES 
(1, 1, TRUE), 
(2, 2, FALSE);
-- LOGS Table (Tracks user and admin activities)
CREATE TABLE LOGS (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID VARCHAR(50),
    Action VARCHAR(255),
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES USER(DL_Number) ON DELETE CASCADE
);
INSERT INTO LOGS (User_ID, Action) 
VALUES 
('DL5678901234', 'User rented a bike'),
('WB8765432109', 'User made a payment');

-- DISCOUNT Table (Stores discount codes for payments)
CREATE TABLE DISCOUNT (
    Discount_ID INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Discount_Percentage DECIMAL(5,2) CHECK (Discount_Percentage BETWEEN 0 AND 100),
    Expiry_Date DATE NOT NULL
);
INSERT INTO DISCOUNT (Code, Discount_Percentage, Expiry_Date) 
VALUES 
('SUMMER20', 20.00, '2025-06-30'),
('WELCOME10', 10.00, '2025-12-31');

-- Foreign Key Constraints
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME  
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE  
WHERE TABLE_NAME = 'TERMINAL_BIKE';


-- Queries 

SELECT U.First_name, U.Last_name, R.Rating, R.Comment, R.Review_Date 
FROM REVIEW R
JOIN USER U ON R.DL_Number = U.DL_Number
WHERE R.Bike_ID = 5; 

-- Get all reviews for a bike
SELECT DL_Number, Bike_ID, Comment, COUNT(*) 
FROM REVIEW 
GROUP BY DL_Number, Bike_ID, Comment
HAVING COUNT(*) > 1;

-- Find available bikes at a specific terminal
SELECT B.Bike_Name, B.Model, B.Price 
FROM TERMINAL_BIKE TB
JOIN BIKE B ON TB.Bike_ID = B.Bike_ID
WHERE TB.Terminal_ID = 1 AND TB.Available = TRUE;

--  Find all logs for a user
SELECT * FROM LOGS WHERE User_ID = 'DL5678901234';

SELECT * FROM DISCOUNT WHERE Expiry_Date > CURDATE();

-- Find the top 5 most rented bikes based on the number of transactions.
SELECT B.Bike_Name, B.Bike_Type, COUNT(T.Transaction_ID) AS Rental_Count
FROM TRANSACTION_TABLE T
JOIN BIKE B ON T.Bike_ID = B.Bike_ID
GROUP BY B.Bike_ID
ORDER BY Rental_Count DESC
LIMIT 5;

