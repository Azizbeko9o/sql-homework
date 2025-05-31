--1. DELETE vs TRUNCATE vs DROP (with IDENTITY example)

IF OBJECT_ID('dbo.test_identity', 'U') IS NOT NULL
    DROP TABLE dbo.test_identity;

CREATE TABLE test_identity (
    id INT IDENTITY(1,1),         
    name VARCHAR(50)
);

INSERT INTO test_identity (name) VALUES ('A'), ('B'), ('C'), ('D'), ('E');

PRINT 'Boshlang‘ich ma''lumotlar:';
SELECT * FROM test_identity;

-- TEST CASE 1: DELETE
DELETE FROM test_identity;

INSERT INTO test_identity (name) VALUES ('F');

PRINT 'DELETE dan keyin kiritilgan F (id davom etadi):';
SELECT * FROM test_identity;

-- TEST CASE 2: TRUNCATE
TRUNCATE TABLE test_identity;

INSERT INTO test_identity (name) VALUES ('G');

PRINT 'TRUNCATE dan keyin kiritilgan G (id reset bo‘ladi):';
SELECT * FROM test_identity;


-- TEST CASE 3: DROP
DROP TABLE test_identity;

CREATE TABLE test_identity (
    id INT IDENTITY(1,1),
    name VARCHAR(50)
);

INSERT INTO test_identity (name) VALUES ('H');

PRINT 'DROP dan keyin qayta yaratilib H qo‘shildi (id 1 bo‘ladi):';
SELECT * FROM test_identity;


--2. Common Data Types
IF OBJECT_ID('dbo.data_types_demo', 'U') IS NOT NULL
    DROP TABLE dbo.data_types_demo;

CREATE TABLE data_types_demo (
    int_column INT, 

    smallint_column SMALLINT,  

    decimal_column DECIMAL(10, 2),

    float_column FLOAT,  

    varchar_column VARCHAR(50), 

    date_column DATE,  

    time_column TIME,  

    datetime_column DATETIME,  

    bit_column BIT,  

    binary_column BINARY(4) 
);

INSERT INTO data_types_demo
(int_column, smallint_column, decimal_column, float_column, varchar_column, date_column, , datetime_column, bit_column, binary_column)
VALUES time_column
(123, 45, 12345.67, 3.14159, 'Hello, SQL!', '2025-05-31', '15:30:00', '2025-05-31 15:30:00', 1, 0x4F4F);

SELECT * FROM data_types_demo;


--3. Inserting and Retrieving an Image
IF OBJECT_ID('dbo.photos', 'U') IS NOT NULL
    DROP TABLE dbo.photos;

CREATE TABLE photos (
    id INT IDENTITY(1,1) PRIMARY KEY,  
    photo VARBINARY(MAX)              
);

INSERT INTO photos (photo)
SELECT * FROM OPENROWSET(BULK 'C:\Python\darslar\homework\photo_2025-05-08_18-08-33.jpg', SINGLE_BLOB) AS img;

SELECT photo FROM photos WHERE id = 1;


--4. Computed Columns
CREATE TABLE students (
    student_id INT PRIMARY KEY,               
    student_name VARCHAR(100),                
    classes INT,                              
    tuition_per_class DECIMAL(10, 2),       
    total_tuition AS (classes * tuition_per_class)  
);

INSERT INTO students (student_id, student_name, classes, tuition_per_class)
VALUES 
(1, 'Alice', 5, 300.00),    
(2, 'Bob', 3, 450.00),      
(3, 'Charlie', 4, 500.00); 

SELECT * FROM students;


--5. CSV to SQL Server
CREATE TABLE worker (
    id INT PRIMARY KEY,         
    name VARCHAR(100)           
);

INSERT INTO worker (id, name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Robert Brown'),
(4, 'Emily Davis'),
(5, 'Michael Wilson');

SELECT * FROM worker;
