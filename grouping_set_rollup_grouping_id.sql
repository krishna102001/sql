-- CREATE DATABASE SAMPLEDB


-- Create Table Employees
-- (
--     Id int primary key,
--     Name nvarchar(50),
--     Gender nvarchar(10),
--     Salary int,
--     Country nvarchar(10)
-- )


-- Insert Into Employees Values (1, 'Mark', 'Male', 5000, 'USA')
-- Insert Into Employees Values (2, 'John', 'Male', 4500, 'India')
-- Insert Into Employees Values (3, 'Pam', 'Female', 5500, 'USA')
-- Insert Into Employees Values (4, 'Sara', 'Female', 4000, 'India')
-- Insert Into Employees Values (5, 'Todd', 'Male', 3500, 'India')
-- Insert Into Employees Values (6, 'Mary', 'Female', 5000, 'UK')
-- Insert Into Employees Values (7, 'Ben', 'Male', 6500, 'UK')
-- Insert Into Employees Values (8, 'Elizabeth', 'Female', 7000, 'USA')
-- Insert Into Employees Values (9, 'Tom', 'Male', 5500, 'UK')
-- Insert Into Employees Values (10, 'Ron', 'Male', 5000, 'USA')

SELECT * FROM Employees

-- GROUPING SETS 
SELECT Country,Gender, SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Country,Gender
UNION ALL
SELECT Country, NULL, SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Country

-- ABOVE ONE CAN ACHIEVE BY GROUPING SET
SELECT Country,Gender,SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY
GROUPING SETS
(
    (Country,Gender), -- SUM OF SALARY BY GENDER, COUNTRY
    (Country), -- SUM OF SALARY BY COUNTRY
    () -- grand total
)

-- ANOTHER EXAMPLE
SELECT Country,Gender, SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Country,Gender
UNION ALL
SELECT Country, NULL, SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Country
UNION ALL
SELECT  NULL,Gender, SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Gender
UNION ALL
SELECT NULL, NULL, SUM(Salary) AS TOTALSALARY FROM Employees

-- ABOVE CAN ACHIEVE BY GROUPING SETS ALSO AND IN LESS LINE OF CODE(LOC)
SELECT Country,Gender,SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY
GROUPING SETS(
    (Country,Gender),
    (Country),
    (Gender),
    ()
) ORDER BY GROUPING(Country),GROUPING(Gender),Gender


-- ROLLUP // IT IS UESD TO DO AGGREGATE OPERATION ON MULTIPLE LEVELS IN A HIERARCHY

SELECT Country,SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Country
UNION ALL 
SELECT NULL,SUM(Salary) AS TOTALSALARY FROM Employees -- ITS DO GRAND TOTAL

-- ABOVE ONE CAN ACHIEVE BY ROLLUP FUNCTION
SELECT Country, SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY ROLLUP(Country)

SELECT Country,Gender,SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Country,Gender
UNION ALL 
SELECT Country,NULL,SUM(Salary) AS TOTALSALARY FROM Employees
GROUP BY Country
UNION ALL
SELECT NULL,NULL,SUM(Salary) AS TOTALSALARY FROM Employees

-- ABOVE ONE CAN ACHIEVE BY ROLLUP FUNCTION 
SELECT Country, Gender, SUM(Salary) AS TOTALSALARY FROM Employees 
GROUP BY ROLLUP(Country,Gender) ORDER BY GROUPING(Country),GROUPING(Gender),Gender

-- OR 

SELECT Country, Gender, SUM(Salary) AS TOTALSALARY FROM Employees 
GROUP BY Country,Gender WITH ROLLUP


--- CUBE . THE RESULTS SET BY GENERATING ALL COMBINATION OF COLUMNS SPECIFIED IN GROUP BY CUBE()
SELECT Country, Gender, SUM(Salary) AS TOTALSALARY FROM Employees 
GROUP BY Country,Gender
UNION ALL 
SELECT NULL, Gender, SUM(Salary) AS TOTALSALARY FROM Employees 
GROUP BY Gender
UNION ALL
SELECT Country,NULL, SUM(Salary) AS TOTALSALARY FROM Employees 
GROUP BY Country
UNION ALL 
SELECT NULL,NULL, SUM(Salary) AS TOTALSALARY FROM Employees 

-- ABOVE ONE CAN ACHIEVE BY CUBE FUNCTION
SELECT Country, Gender, SUM(Salary) AS TOTALSALARY FROM Employees 
GROUP BY Country,Gender WITH CUBE ORDER BY GROUPING(Country), GROUPING(Gender),Gender
-- OR
SELECT Country, Gender, SUM(Salary) AS TOTALSALARY FROM Employees 
GROUP BY CUBE(Country,Gender)

-- DIFFERENCE BETWEEN ROLLUP() AND CUBE() IS THAT ROLL UP WORK IN HIERARCHY PATTERN WHERE AS CUBE() TRY ALL THE POSSIBLE COMBINATION OF VALUES
-- ROLLUP(COUNTRY,GENDER,CITY)
-- COUNTRY,GENDER,CITY
-- COUNTRY,GENDER
-- COUNTRY,
-- ()

-- CUBE(COUNTRY,GENDER,CITY)
-- COUNTRY,GENDER,CITY
-- COUNTRY,GENDER
-- COUNTRY,CITY
-- COUNTRY
-- GENDER,CITY
-- GENDER
-- CITY
-- ()

-- GROUPING FUNCTION . GROUPING(COLUMN) INDICATES WHETHER THE COLUMN IN A GROUP BY LIST IS A AGGREGATED OR NOT. GROUPING RETURN 1 FOR AGGREGATED OR 0 FOR NOT AGGREGATED IN RESULT SET

-- Create table Sales
-- (
--     Id int primary key identity,
--     Continent nvarchar(50),
--     Country nvarchar(50),
--     City nvarchar(50),
--     SaleAmount int
-- )
-- Go

-- Insert into Sales values('Asia','India','Bangalore',1000)
-- Insert into Sales values('Asia','India','Chennai',2000)
-- Insert into Sales values('Asia','Japan','Tokyo',4000)
-- Insert into Sales values('Asia','Japan','Hiroshima',5000)
-- Insert into Sales values('Europe','United Kingdom','London',1000)
-- Insert into Sales values('Europe','United Kingdom','Manchester',2000)
-- Insert into Sales values('Europe','France','Paris',4000)
-- Insert into Sales values('Europe','France','Cannes',5000)
-- Go

SELECT Continent,Country,City,SUM(SaleAmount) AS TOTALSALES,
        GROUPING(Continent) AS GP_CONTINENT,
        GROUPING(Country) AS GP_COUNTRY,
        GROUPING(City) AS GP_CITY
FROM Sales
GROUP BY ROLLUP(Continent,Country,City)

-- replacing null value by all
SELECT  
    CASE WHEN GROUPING(Continent) = 1 THEN 'ALL' ELSE ISNULL(Continent,'UNKOWN') END AS CONTINENT,
    CASE WHEN GROUPING(Country) = 1 THEN 'ALL' ELSE ISNULL(Country,'UNKOWN')END AS COUNTRY,
    CASE WHEN GROUPING(City)=1 THEN 'ALL' ELSE ISNULL(City,'UNKOWN') END AS CITY,
        SUM(SaleAmount) AS TOTALSALES
FROM Sales
GROUP BY ROLLUP(Continent,Country,City)


-- GROUPING ID FUNCTION CONCATENATE ALL THE GROUPING FUNCTION PERFORM THE BINARY TO DECIMAL CONVERSION AND RETURN EQUIVALENT INTEGER
-- GROUPING_ID(A,B,C) = GROUPING(A) + GROUPING(B) + GROUPING(C) 
SELECT Continent,Country,City,SUM(SaleAmount) AS TOTALSALES,
        CAST(GROUPING(Continent) AS NVARCHAR(1))+
        CAST(GROUPING(Country) AS NVARCHAR(1))+
        CAST(GROUPING(City)  AS NVARCHAR(1)) AS GROUPING
FROM Sales
GROUP BY ROLLUP(Continent,Country,City)

-- ABOVE ONE CAN ACHIEVE BY GROUPING_ID JUST LITTLE DIFFERENCE  IT WILL CHANGE BINARY TO DECIMAL ONLY
SELECT Continent,Country,City,SUM(SaleAmount) AS TOTALSALES,
        GROUPING_ID(Continent,Country,City) AS GPID 
FROM Sales
GROUP BY ROLLUP(Continent,Country,City)

SELECT Continent,Country,City,SUM(SaleAmount) AS TOTALSALES,
        GROUPING_ID(Continent,Country,City) AS GPID 
FROM Sales
GROUP BY ROLLUP(Continent,Country,City) 
HAVING GROUPING_ID(Continent,Country,City) >2