# Motorcycle-Rental-DBMS-MySQL
Database Management System for a Motorcycle Rental Company using MySQL Workbench

# 🏍️ Motorcycle Rental Database Management System | MySQL Workbench

This project is a fully functional **Database Management System** for a motorcycle rental business. It includes schema design, data population, transactions, payments, reviews, and powerful SQL queries for business insights.

---

## 📁 Project Structure
---

## 🗃️ Main Tables

- `USER`
- `BIKE`
- `TERMINAL`
- `TRANSACTION_TABLE`
- `PAYMENT`
- `REVIEW`
- `TERMINAL_BIKE`
- `LOGS`
- `DISCOUNT`

---

## 🔧 Key Functionalities

- 🚲 Add & manage motorcycle inventory
- 🧍 Customer registration via `USER` table
- 📅 Rental & return tracking
- 💳 Payment integration with discount support
- 💬 Review system for customer feedback
- 📊 SQL reports to analyze performance



## 🎤 Project Presentation
--
A PowerPoint presentation is included for walkthrough and explanation:

📂 [`Motorcycle_Rental_DBMS_Presentation.pptx`](./Motorcycle_Rental_DBMS_Presentation.pptx)

This presentation covers:
- Problem Statement
---

## 🧠 Sample SQL Queries

```sql
-- Top 5 most rented bikes
SELECT B.Bike_Name, COUNT(*) AS Rents
FROM TRANSACTION_TABLE T
JOIN BIKE B ON T.Bike_ID = B.Bike_ID
GROUP BY B.Bike_ID
ORDER BY Rents DESC
LIMIT 5;

-- Total revenue generated
SELECT SUM(Cost) AS Total_Revenue FROM PAYMENT;
- ER Diagram
- Schema Overview
- Key SQL Queries
- Project Features & Use Cases



