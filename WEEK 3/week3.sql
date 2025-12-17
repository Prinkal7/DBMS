CREATE DATABASE BANK;
USE BANK;

-- 🔹 Create all tables
CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets REAL
);

CREATE TABLE BankAccount (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE BankCustomer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(50),
    customer_city VARCHAR(50)
);

CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- 🔹 Insert data into Branch
INSERT INTO Branch VALUES
('SBI_ResidencyRoad', 'Bangalore', 50000000),
('ICICI_MG', 'Bangalore', 40000000),
('HDFC_KarolBagh', 'Delhi', 35000000),
('Axis_CP', 'Delhi', 45000000),
('Canara_Jayanagar', 'Bangalore', 30000000);

-- 🔹 Insert data into BankAccount
INSERT INTO BankAccount VALUES
(1, 'SBI_ResidencyRoad', 25000),
(2, 'SBI_ResidencyRoad', 42000),
(3, 'ICICI_MG', 15000),
(4, 'HDFC_KarolBagh', 60000),
(5, 'Axis_CP', 52000),
(6, 'Canara_Jayanagar', 18000),
(7, 'ICICI_MG', 30000),
(8, 'SBI_ResidencyRoad', 22000),
(9, 'Axis_CP', 27000),
(10, 'SBI_ResidencyRoad', 40000);

-- 🔹 Insert data into BankCustomer
INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

-- 🔹 Insert data into Depositer
INSERT INTO Depositer VALUES
('Avinash', 8),
('Dinesh', 2),
('Dinesh', 10),
('Mohan', 3),
('Nikil', 4),
('Ravi', 5),
('Avinash', 1);

-- 🔹 Insert data into Loan
INSERT INTO Loan VALUES
(101, 'SBI_ResidencyRoad', 80000),
(102, 'ICICI_MG', 120000),
(103, 'Axis_CP', 95000),
(104, 'HDFC_KarolBagh', 70000),
(105, 'Canara_Jayanagar', 65000);

-- 🔹 Query 1: Display branch name and assets in lakhs
SELECT branch_name, (assets / 100000) AS "Assets in Lakhs"
FROM Branch;

-- 🔹 Query 2: Find customers with at least two accounts in the same branch
SELECT d.customer_name, b.branch_name, COUNT(*) AS Num_Accounts
FROM Depositer d
JOIN BankAccount b ON d.accno = b.accno
GROUP BY d.customer_name, b.branch_name
HAVING COUNT(*) >= 2;

-- 🔹 Query 3: Create a view showing total loan amount per branch
CREATE VIEW Branch_Loan_Summary AS
SELECT branch_name, SUM(amount) AS Total_Loan_Amount
FROM Loan
GROUP BY branch_name;

-- 🔹 Query 4: View the total loans by branch
SELECT * FROM Branch_Loan_Summary;

-- 🔹 Query 5: Customers from Bangalore with balance > 20000
SELECT DISTINCT c.customer_name, b.balance
FROM BankCustomer c
JOIN Depositer d ON c.customer_name = d.customer_name
JOIN BankAccount b ON d.accno = b.accno
WHERE c.customer_city = 'Bangalore' AND b.balance > 20000;