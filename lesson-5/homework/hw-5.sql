-- Task-1
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;



-- Task-2
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

WITH RankedEmployees AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        HireDate,
        RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT *
FROM RankedEmployees
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM RankedEmployees
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
ORDER BY SalaryRank, Name;



-- Task-3
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        HireDate,
        RANK() OVER (
            PARTITION BY Department 
            ORDER BY Salary DESC
        ) AS SalaryRank
    FROM Employees
)
SELECT *
FROM RankedSalaries
WHERE SalaryRank <= 2
ORDER BY Department, SalaryRank, Name;
-- Task-4
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');


WITH RankedSalaries AS (
    SELECT *,
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees
)
SELECT *
FROM RankedSalaries
WHERE SalaryRank = 1;


-- Task-5
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees;

-- Task-6
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       SUM(Salary) OVER (PARTITION BY Department) AS DepartmentTotal
FROM Employees;


-- Task-7
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       AVG(Salary) OVER (PARTITION BY Department) AS DepartmentAvg
FROM Employees;


-- Task-8
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryVsDeptAvg
FROM Employees;

-- Task-9
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       AVG(Salary) OVER (
           ORDER BY HireDate
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS MovingAvg3
FROM Employees;


-- Task-10
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

WITH Ordered AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RowNum
    FROM Employees
)
SELECT SUM(Salary) AS Last3HiredSalarySum
FROM Ordered
WHERE RowNum <= 3;


-- Task-11
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAvg
FROM Employees;


-- Task-12
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       MAX(Salary) OVER (
           ORDER BY HireDate
           ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
       ) AS SlidingMax
FROM Employees;


-- Task-13
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Ali Valiyev', 'IT', 2500.00, '2020-01-15'),
(2, 'Laylo Karimova', 'IT', 1800.00, '2021-03-20'),
(3, 'Javlon Ergashev', 'IT', 2300.00, '2019-11-05'),
(4, 'Ziyoda Qodirova', 'HR', 1700.00, '2022-06-01'),
(5, 'Mirjalol Raxmonov', 'HR', 1500.00, '2021-04-11'),
(6, 'Dilshodbek Sobirov', 'HR', 1700.00, '2020-09-19'),
(7, 'Shahnoza Tursunova', 'Finance', 2000.00, '2018-08-22'),
(8, 'Elyor Tadjiev', 'Finance', 1900.00, '2023-02-01'),
(9, 'Malika Sodiqova', 'Finance', 1900.00, '2021-12-15');

SELECT *,
       CAST(Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department) AS DECIMAL(5,2)) AS SalaryPercent
FROM Employees;
