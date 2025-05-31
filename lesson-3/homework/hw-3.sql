--Task 1: Employee Salary Report
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

WITH TopSalaryEmployees AS (
    SELECT 
        e.EmployeeID, 
        e.FirstName, 
        e.LastName, 
        e.Department, 
        e.Salary,
        DENSE_RANK() OVER (ORDER BY e.Salary DESC) AS salary_rank,
        COUNT(*) OVER () AS total_employees
    FROM Employees e
),
SalaryCategory AS (
    SELECT 
        EmployeeID, 
        FirstName, 
        LastName, 
        Department, 
        Salary,
        CASE 
            WHEN Salary > 80000 THEN 'High'
            WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
            ELSE 'Low'
        END AS SalaryCategory,
        salary_rank,
        total_employees
    FROM TopSalaryEmployees
    WHERE salary_rank <= total_employees * 0.1  
)
SELECT 
    sc.Department, 
    AVG(sc.Salary) AS AverageSalary,
    sc.SalaryCategory
FROM SalaryCategory sc
GROUP BY sc.Department, sc.SalaryCategory
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;  


select * from Employees;


--Task 2: Customer Order Insights
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
SELECT
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;

select * from Orders;


--Task 3: Product Inventory Check
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
SELECT 
    DISTINCT p.Category,
    p.ProductName,
    p.Price,
    p.Stock,
    IIF(p.Stock = 0, 'Out of Stock', 
        IIF(p.Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products p
WHERE p.Price = (
    SELECT MAX(Price) 
    FROM Products 
    WHERE Category = p.Category
)
ORDER BY p.Price DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

select * from Products;
