-- Task 1:
IF OBJECT_ID('dbo.TestMultipleZero', 'U') IS NOT NULL
    DROP TABLE dbo.TestMultipleZero;
GO

CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A, B, C, D)
VALUES 
    (0, 0, 0, 1),
    (0, 0, 1, 0),
    (0, 1, 0, 0),
    (1, 0, 0, 0),
    (0, 0, 0, 0), 
    (1, 1, 1, 0);
GO

SELECT *
FROM [dbo].[TestMultipleZero]
WHERE NOT (
    ISNULL(A, 0) = 0 AND
    ISNULL(B, 0) = 0 AND
    ISNULL(C, 0) = 0 AND
    ISNULL(D, 0) = 0
);


-- Task 2
IF OBJECT_ID('dbo.TestMax', 'U') IS NOT NULL
    DROP TABLE dbo.TestMax;
GO

CREATE TABLE TestMax
(
    Year1 INT,
    Max1 INT,
    Max2 INT,
    Max3 INT
);
GO

INSERT INTO TestMax 
VALUES
    (2001, 10, 101, 87),
    (2002, 103, 19, 88),
    (2003, 21, 23, 89),
    (2004, 27, 28, 91);
GO

SELECT 
    T.Year1,
    T.Max1,
    T.Max2,
    T.Max3,
    MaxValue = V.Val
FROM TestMax T
CROSS APPLY (
    SELECT MAX(Val) AS Val
    FROM (VALUES (T.Max1), (T.Max2), (T.Max3)) AS X(Val)
) AS V;


-- Task 3
IF OBJECT_ID('dbo.EmpBirth', 'U') IS NOT NULL
    DROP TABLE dbo.EmpBirth;
GO

CREATE TABLE EmpBirth
(
    EmpId INT IDENTITY(1,1),          
    EmpName VARCHAR(50),              
    BirthDate DATETIME                
);
GO

INSERT INTO EmpBirth (EmpName, BirthDate)
SELECT 'Pawan', '1983-12-04'
UNION ALL
SELECT 'Zuzu', '1986-11-28'
UNION ALL
SELECT 'Parveen', '1977-05-07'
UNION ALL
SELECT 'Mahesh', '1983-01-13'
UNION ALL
SELECT 'Ramesh', '1983-05-09';
GO

SELECT 
    EmpId,
    EmpName,
    BirthDate,
    FORMAT(BirthDate, 'MM-dd') AS Birth_MM_DD 
FROM EmpBirth
WHERE 
    FORMAT(BirthDate, 'MM-dd') BETWEEN '05-07' AND '05-15';


-- Task 4
IF OBJECT_ID('dbo.letters', 'U') IS NOT NULL
    DROP TABLE dbo.letters;
GO

CREATE TABLE letters
(
    letter CHAR(1)
);
GO

INSERT INTO letters(letter)
VALUES ('a'), ('a'), ('a'), 
       ('b'), ('c'), ('d'), ('e'), ('f');
GO

PRINT 'Variant 1: ''b'' birinchi bo''lsin';
SELECT letter
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 0 ELSE 1 END,
    letter;
GO

PRINT 'Variant 2: ''b'' oxirgi bo''lsin';
SELECT letter
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 1 ELSE 0 END,
    letter;
GO

PRINT 'Variant 3: ''b'' 3-o''rinda bo''lsin';
WITH OrderedLetters AS (
    SELECT letter,
           ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
    WHERE letter <> 'b'
),
BRow AS (
    SELECT letter, 3 AS rn FROM letters WHERE letter = 'b'
)
SELECT letter
FROM (
    SELECT letter, rn FROM OrderedLetters
    UNION ALL
    SELECT letter, rn FROM BRow
) t
ORDER BY rn;
GO
select * from letters;
