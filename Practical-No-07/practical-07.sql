show databases;

create database practical7;

use practical7;

-- Create the borrower table
CREATE TABLE borrower (
    customer_name VARCHAR(100),
    loan_number INT PRIMARY KEY
);

-- Insert data in borrower table
INSERT INTO borrower (customer_name, loan_number) VALUES
('Vinayak Vathare', 1),
('Ram Kumar', 2),
('Raj Vinit', 3),
('Veer Singh', 4),
('Anjali Desai', 5),
('Pooja Agarwal', 6),
('Amit Sharma', 7),
('Neha Patel', 8),
('Ravi Gupta', 9),
('Sita Menon', 10);

-- Create the account table
CREATE TABLE account (
    account_number INT PRIMARY KEY,
    branch_name VARCHAR(100),
    balance DECIMAL(10, 2)
);


-- Insert sample data into account table
INSERT INTO account (account_number, branch_name, balance) VALUES
(101, 'Shahupuri', 15000.00),
(102, 'Shahupuri', 8000.00),
(103, 'Main Branch', 12000.00),
(104, 'Shahupuri', 20000.00),
(105, 'Downtown', 5000.00),
(106, 'Main Branch', 30000.00),
(107, 'Downtown', 10000.00),
(108, 'Shahupuri', 7000.00),
(109, 'Main Branch', 25000.00),
(110, 'Downtown', 12000.00);


-- Create the depositor table
CREATE TABLE depositor (
    customer_name VARCHAR(100),
    account_number INT,
    PRIMARY KEY (customer_name, account_number),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

-- Insert sample data into depositor table
INSERT INTO depositor (customer_name, account_number) VALUES
('Vinayak Vathare', 101),
('Ram Kumar', 102),
('Raj Vinit', 103),
('Veer Singh', 104),
('Anjali Desai', 101),
('Pooja Agarwal', 106),
('Amit Sharma', 105),
('Neha Patel', 107),
('Ravi Gupta', 108),
('Sita Menon', 109);


select * from account

-- Now we can execute the queries as specified:

-- 1. Find all customers having either loan, an account or both at the bank.
SELECT DISTINCT customer_name FROM borrower
UNION
SELECT DISTINCT customer_name FROM depositor;

-- 2. Find all customers having an account but not loan at the bank.
SELECT DISTINCT d.customer_name 
FROM depositor d 
LEFT JOIN borrower b ON d.customer_name = b.customer_name 
WHERE b.customer_name IS NULL;

-- 3. Find all customers having both an account and loan at the bank.
SELECT DISTINCT d.customer_name 
FROM depositor d 
JOIN borrower b ON d.customer_name = b.customer_name;

-- 4. Find the customers who have balance more than 10000.
SELECT DISTINCT d.customer_name 
FROM depositor d 
JOIN account a ON d.account_number = a.account_number 
WHERE a.balance > 10000;

-- 5. List in alphabetic order, customers who have account at ‘Shahupuri’ branch.
SELECT DISTINCT d.customer_name 
FROM depositor d 
JOIN account a ON d.account_number = a.account_number 
WHERE a.branch_name = 'Shahupuri' 
ORDER BY d.customer_name;

-- 6. Find all customers who have either an account or loan (but not both) at the bank.
SELECT DISTINCT d.customer_name 
FROM depositor d 
LEFT JOIN borrower b ON d.customer_name = b.customer_name 
WHERE b.customer_name IS NULL
UNION
SELECT DISTINCT b.customer_name 
FROM borrower b 
LEFT JOIN depositor d ON b.customer_name = d.customer_name 
WHERE d.customer_name IS NULL;
