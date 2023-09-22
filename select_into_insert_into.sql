-- SELECT INTO --
SELECT * INTO EMPLOYEESBACKUP FROM EMPLOYEE -- IT WILL CREATE A DUPLICATE OF THIS TABLE
-- BOTH THE TABLE WILL HAVE SAME DATA
SELECT * FROM EMPLOYEESBACKUP 
SELECT * FROM EMPLOYEE
DROP TABLE EMPLOYEESBACKUP

SELECT ID,NAME,GENDER INTO EMPLOYEESBACKUP1 FROM EMPLOYEE
SELECT * FROM EMPLOYEESBACKUP1
DROP TABLE EMPLOYEESBACKUP1

-- MAKING ONE TABLE FROM JOINING A TWO TABLE
SELECT E.ID,NAME,GENDER,DEPARTMENT_NAME INTO EMPLOYEESBACKUP1 FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.ID

SELECT * FROM EMPLOYEESBACKUP1

SELECT E.ID,NAME,GENDER,DEPARTMENT_NAME INTO EMPLOYEESBACKUP1 FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.ID WHERE E.ID IN(1,2,3)

SELECT * INTO EMPLOYEESBACKUP FROM EMPLOYEE WHERE 1<>1


--INSERT INTO ---
INSERT INTO EMPLOYEESBACKUP(ID,NAME,GENDER) 
SELECT  ID, NAME,GENDER FROM EMPLOYEE


-- DIFFERENCE BETWEEN WHERE AND HAVING CLAUSE
CREATE TABLE SALES(
    PRODUCT NVARCHAR(50),
    SALESAMOUNT INT
)
INSERT INTO SALES VALUES('IPHONE',500)
INSERT INTO SALES VALUES('LAPTOP',800)
INSERT INTO SALES VALUES('IPHONE',1000)
INSERT INTO SALES VALUES('SPEAKERS',400)
INSERT INTO SALES VALUES('LAPTOP',600)

SELECT * FROM SALES

SELECT PRODUCT, SUM(SALESAMOUNT) AS TOTALSALES FROM SALES 
GROUP BY PRODUCT
-- WHERE IS APPLIED BEFORE THE GROUP BY FUNCTION, IT WILL FILTER THE ROW FIRST THEN APPLY THE AGGREGATE FUNCTION
SELECT PRODUCT, SUM(SALESAMOUNT) AS TOTALSALES FROM SALES 
WHERE PRODUCT IN ('IPHONE','LAPTOP')
GROUP BY PRODUCT

--HAVING IS APPLIED AFTER THE GROUP BY FUNCTION AND IT WORK WITH AGGREGATE FUNCTION AND WHERE FUNCTION DOES NOT WORK 
SELECT PRODUCT, SUM(SALESAMOUNT) AS TOTALSALES FROM SALES 
GROUP BY PRODUCT
WHERE PRODUCT IN ('IPHONE','LAPTOP') -- IT WILL GIVE ERROR

SELECT PRODUCT, SUM(SALESAMOUNT) AS TOTALSALES FROM SALES 
GROUP BY PRODUCT
HAVING PRODUCT IN ('IPHONE','SPEAKERS')

SELECT PRODUCT, SUM(SALESAMOUNT) AS TOTALSALES FROM SALES 
GROUP BY PRODUCT
HAVING SUM(SALESAMOUNT)>500