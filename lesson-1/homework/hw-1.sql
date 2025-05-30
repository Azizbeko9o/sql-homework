--1. NOT NULL Constraint
CREATE TABLE student 
(
    id INTEGER,
    name TEXT,
    age INTEGER
);

select * from student;

alter table student
alter column id int not null;


--2. UNIQUE Constraint

CREATE TABLE product 
(
    product_id INT,           
    product_name VARCHAR(255),
    price DECIMAL
);


ALTER TABLE product
ADD CONSTRAINT product_id_unique UNIQUE (product_id);


ALTER TABLE product
ADD CONSTRAINT product_unique UNIQUE (product_id, product_name);

select * from product;


--3. PRIMARY KEY Constraint
CREATE TABLE orders 
(
    order_id INT PRIMARY KEY, 
    customer_name VARCHAR(255),
    order_date DATE
);

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'orders' AND CONSTRAINT_TYPE = 'PRIMARY KEY';

ALTER TABLE orders
DROP CONSTRAINT PK__orders__46596229AC0B2406; 


ALTER TABLE orders
ADD CONSTRAINT PK_orders PRIMARY KEY (order_id);

select * from orders;


--4. FOREIGN KEY Constraint
CREATE TABLE category 
(
    category_id INT PRIMARY KEY,  
    category_name VARCHAR(255)    
);

CREATE TABLE item 
(
    item_id INT PRIMARY KEY,      
    item_name VARCHAR(255),       
    category_id INT,              
    FOREIGN KEY (category_id) REFERENCES category(category_id)  
);

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'item' AND CONSTRAINT_TYPE = 'FOREIGN KEY';

ALTER TABLE item
DROP CONSTRAINT FK__item__category_i__63A3C44B;  

ALTER TABLE item
ADD CONSTRAINT FK_item_category FOREIGN KEY (category_id) REFERENCES category(category_id);

select * from category; 
select * from item;


--5. CHECK Constraint
CREATE TABLE account 
(
    account_id INT PRIMARY KEY,         
    balance DECIMAL CHECK (balance >= 0),  
    account_type VARCHAR(50) CHECK (account_type IN ('Saving', 'Checking'))  
);

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'account' AND CONSTRAINT_TYPE = 'CHECK';

ALTER TABLE account
DROP CONSTRAINT CK__account__balance__6774552F;

ALTER TABLE account
DROP CONSTRAINT CK__account__account__68687968;

ALTER TABLE account
ADD CONSTRAINT chk_balance CHECK (balance >= 0);

ALTER TABLE account
ADD CONSTRAINT chk_account_type CHECK (account_type IN ('Saving', 'Checking'));

select * from account;


--6. DEFAULT Constraint
CREATE TABLE customer 
(
    customer_id INT PRIMARY KEY,        
    name VARCHAR(255),                 
    city VARCHAR(255) DEFAULT 'Unknown' 
);

SELECT c.name AS Constraint_Name
FROM sys.check_constraints c
JOIN sys.columns col ON c.parent_object_id = col.object_id
WHERE c.parent_object_id = OBJECT_ID('customer')
  AND col.name = 'city';

ALTER TABLE customer
DROP CONSTRAINT DF_customer_city;  

ALTER TABLE customer
ADD CONSTRAINT DF_customer_city DEFAULT 'Unknown' FOR city;

select * from customer;



--7. IDENTITY Column
CREATE TABLE invoice 
(
    invoice_id INT IDENTITY(1,1),
    amount DECIMAL
);

INSERT INTO invoice (amount) VALUES (100.50);
INSERT INTO invoice (amount) VALUES (250.75);
INSERT INTO invoice (amount) VALUES (75.25);
INSERT INTO invoice (amount) VALUES (150.00);
INSERT INTO invoice (amount) VALUES (200.00);

SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 300.00);

SET IDENTITY_INSERT invoice OFF;

select * from invoice;


--8. All at once
CREATE TABLE books 
(
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    price DECIMAL CHECK (price > 0),
    genre VARCHAR(100) DEFAULT 'Unknown'
);

INSERT INTO books (title, price, genre) 
VALUES ('The Great Gatsby', 15.99, 'Fiction');

INSERT INTO books (title, price, genre) 
VALUES ('1984', 10.99, 'Dystopian');

INSERT INTO books (title, price, genre) 
VALUES ('To Kill a Mockingbird', 12.50, 'Drama');

INSERT INTO books (title, price, genre) 
VALUES ('', 9.99, 'Mystery');

INSERT INTO books (title, price, genre) 
VALUES ('Invisible Man', 0, 'Fiction');

INSERT INTO books (title, price) 
VALUES ('Brave New World', 18.00);

select * from books;


--9. Scenario: Library Management System

CREATE TABLE Book (
    book_id INT PRIMARY KEY IDENTITY(1,1),  
    title TEXT NOT NULL,                     
    author TEXT NOT NULL,                   
    published_year INT                       
);

CREATE TABLE Member (
    member_id INT PRIMARY KEY IDENTITY(1,1), 
    name TEXT NOT NULL,                       
    email TEXT NOT NULL,                     
    phone_number TEXT                         
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY IDENTITY(1,1),     
    book_id INT,                                
    member_id INT,                             
    loan_date DATE DEFAULT GETDATE(),           
    return_date DATE,                           
    FOREIGN KEY (book_id) REFERENCES Book(book_id),   
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

INSERT INTO Book (title, author, published_year)
VALUES ('Ozbekiston Tarixi', 'Abdulla Qodiriy', 1938),
       ('Jahon Adabiyoti', 'Hamid Olimjon', 1975),
       ('Yoshlar uchun Filosofiya', 'Muhammad Yusupov', 2020);

INSERT INTO Member (name, email, phone_number)
VALUES ('Ali Murodov', 'ali@example.com', '998901234567'),
       ('Zarina Ergasheva', 'zarina@example.com', '998907654321');

INSERT INTO Loan (book_id, member_id, loan_date, return_date)
VALUES (1, 1, '2025-06-01', NULL),  
       (2, 2, '2025-06-03', NULL);  

SELECT * FROM Book;

SELECT b.title, b.author, l.loan_date, l.return_date
FROM Loan l
JOIN Book b ON l.book_id = b.book_id
WHERE l.member_id = 1;  

SELECT * FROM Book
WHERE author = 'Hamid Olimjon';

SELECT m.name, m.email, l.loan_date, l.return_date
FROM Loan l
JOIN Member m ON l.member_id = m.member_id
WHERE l.book_id = 2;  

SELECT b.title, m.name, l.loan_date, l.return_date
FROM Loan l
JOIN Book b ON l.book_id = b.book_id
JOIN Member m ON l.member_id = m.member_id
WHERE l.loan_date < GETDATE() AND l.return_date IS NULL;


select * from Book;
select * from Member;
select * from Loan;



--Tasks:1.Understand Relationships
CREATE TABLE Book 
(
    book_id INT PRIMARY KEY IDENTITY(1,1),  
    title TEXT NOT NULL,                     
    author TEXT NOT NULL,                    
    published_year INT                       
);

CREATE TABLE Member 
(
    member_id INT PRIMARY KEY IDENTITY(1,1), 
    name TEXT NOT NULL,                       
    email TEXT NOT NULL,                      
    phone_number TEXT                         
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY IDENTITY(1,1),     
    book_id INT,                                
    member_id INT,                              
    loan_date DATE DEFAULT GETDATE(),           
    return_date DATE,                           
    FOREIGN KEY (book_id) REFERENCES Book(book_id),   
    FOREIGN KEY (member_id) REFERENCES Member(member_id) 
);

INSERT INTO Book (title, author, published_year)
VALUES ('Ozbekiston Tarixi', 'Abdulla Qodiriy', 1938),
       ('Jahon Adabiyoti', 'Hamid Olimjon', 1975),
       ('Yoshlar uchun Filosofiya', 'Muhammad Yusupov', 2020);

INSERT INTO Member (name, email, phone_number)
VALUES ('Ali Murodov', 'ali@example.com', '998901234567'),
       ('Zarina Ergasheva', 'zarina@example.com', '998907654321');

INSERT INTO Loan (book_id, member_id, loan_date, return_date)
VALUES (1, 1, '2025-06-01', NULL),  
       (2, 2, '2025-06-03', NULL);  

SELECT * FROM Book;

SELECT b.title, b.author, l.loan_date, l.return_date
FROM Loan l
JOIN Book b ON l.book_id = b.book_id
WHERE l.member_id = 1;  

SELECT * FROM Book
WHERE author = 'Hamid Olimjon';

SELECT m.name, m.email, l.loan_date, l.return_date
FROM Loan l
JOIN Member m ON l.member_id = m.member_id
WHERE l.book_id = 2;  

SELECT b.title, m.name, l.loan_date, l.return_date
FROM Loan l
JOIN Book b ON l.book_id = b.book_id
JOIN Member m ON l.member_id = m.member_id
WHERE l.loan_date < GETDATE() AND l.return_date IS NULL;

select * from Book;
select * from Member;
select * from Loan;


--Task-2.Write SQL Statements
CREATE TABLE Book (
    book_id INT PRIMARY KEY IDENTITY(1,1),  
    title TEXT NOT NULL,                    
    author TEXT NOT NULL,                   
    published_year INT                      
);

-- 2. Create Member Table
CREATE TABLE Member (
    member_id INT PRIMARY KEY IDENTITY(1,1), 
    name TEXT NOT NULL,                      
    email TEXT NOT NULL,                     
    phone_number TEXT                        
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY IDENTITY(1,1),    
    book_id INT,                               
    member_id INT,                              
    loan_date DATE DEFAULT GETDATE(),           
    return_date DATE,                          
    FOREIGN KEY (book_id) REFERENCES Book(book_id), 
    FOREIGN KEY (member_id) REFERENCES Member(member_id) 
);

INSERT INTO Book (title, author, published_year)
VALUES 
    ('Ozbekiston Tarixi', 'Abdulla Qodiriy', 1938),
    ('Jahon Adabiyoti', 'Hamid Olimjon', 1975),
    ('Yoshlar uchun Filosofiya', 'Muhammad Yusupov', 2020);

INSERT INTO Member (name, email, phone_number)
VALUES 
    ('Ali Murodov', 'ali@example.com', '998901234567'),
    ('Zarina Ergasheva', 'zarina@example.com', '998907654321'),
    ('Jamshid Tursunov', 'jamshid@example.com', '998931234567');

INSERT INTO Loan (book_id, member_id, loan_date, return_date)
VALUES 
    (1, 1, '2025-06-01', NULL), 
    (2, 2, '2025-06-03', NULL),
    (3, 3, '2025-06-05', NULL);  
