-- CREATE TABLE tblEmployee (
--     [ID] int NOT NULL PRIMARY KEY,
--     [NAME] NVARCHAR(50) NOT NULL,
--     [GENDER] NVARCHAR(50) NOT NULL,  -----CREATED EMPLOYEE TABLE
--     [SALARY] int NOT NULL,
--     [CITY] NVARCHAR(50) NOT NULL
-- )
-- INSERT INTO tblEmployee VALUES ('TOM','MALE',10000000,'NOIDA')

SELECT * FROM tblEmployee

SELECT SUM(SALARY) AS TOTALSALARY FROM tblEmployee -- aggregate function is used to get the quick answer

SELECT SUM(SALARY) AS TOTALSALARY , [CITY] FROM tblEmployee GROUP BY CITY -- whenever using 'group by city' the we should must also define the city before the 'group by'

SELECT SUM(SALARY) AS TOTALSALARY , [GENDER] FROM tblEmployee GROUP BY GENDER

SELECT SUM(SALARY) AS TOTALSALARY , [GENDER],[CITY] FROM tblEmployee GROUP BY GENDER , CITY


SELECT COUNT(ID) AS TOTALEMPLOYEE FROM tblEmployee

SELECT CITY, COUNT(ID) AS TOTALEMPLOYEE , SUM(SALARY) AS TOTALSALARY FROM tblEmployee GROUP BY CITY

SELECT CITY , SALARY, COUNT(ID) AS TOTALEMPLOYEE , SUM(SALARY) AS TOTALSALARY FROM tblEmployee GROUP BY CITY,SALARY HAVING SALARY >5000