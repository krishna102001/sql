SELECT * FROM DEPARTMENT
SELECT * FROM EMPLOYEE

-- INNER JOIN --
SELECT E.[ID] , [NAME], [SALARY], [GENDER], [DEPARTMENT_NAME] FROM
EMPLOYEE E JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.ID

-- VIEW IS NOTHING MORE THAN A SAVED SQL QUERY . VIEW CAN BE CONSIDERED AS A VIRTUAL TABLE
CREATE VIEW VW_EMPLOYEEBYDEPARTMENT 
AS 
SELECT EMPLOYEE.ID, NAME, SALARY, GENDER, DEPARTMENT_NAME FROM EMPLOYEE
JOIN DEPARTMENT ON EMPLOYEE.DEPARTMENT_ID = DEPARTMENT.ID

SELECT * FROM VW_EMPLOYEEBYDEPARTMENT -- TO VIEW THE VIRTUAL TABLE 

-- DROP VIEW VW_EMPLOYEEBYDEPARTMENT   IT WILL REMOVE THE VIEW 

-- VIEW CAN BE USED TO PRESENT  AGGREGATED THE DATA AND HIDE THE DETAILS , IT CAN ALSO USED TO IMPLEMENT ROW AND COLUMN LEVEL SECURITY

CREATE VIEW VW_IT_EMPLOYEE
AS
SELECT EMPLOYEE.ID,NAME,SALARY,GENDER,DEPARTMENT_NAME FROM EMPLOYEE 
JOIN DEPARTMENT ON EMPLOYEE.DEPARTMENT_ID = DEPARTMENT.ID WHERE DEPARTMENT_NAME = 'IT'

SELECT * FROM VW_IT_EMPLOYEE

-- WE WANT TO HIDE THE SALARY DETAILS SO OTHER USER CAN NOT SEE THAT 

CREATE VIEW VW_EMPLOYEE_CONFIDENTIALS
AS 
SELECT E.ID,NAME,GENDER,DEPARTMENT_NAME FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.ID

SELECT * FROM VW_EMPLOYEE_CONFIDENTIALS

CREATE VIEW VW_SUMMARIZED_DATA
AS 
SELECT DEPARTMENT_NAME, COUNT(EMPLOYEE.ID) AS TOTAL_EMPLOYEES FROM EMPLOYEE
JOIN DEPARTMENT ON EMPLOYEE.DEPARTMENT_ID = DEPARTMENT.ID 
GROUP BY DEPARTMENT_NAME

SELECT * FROM VW_SUMMARIZED_DATA



-- IS IT POSSIBLE TO UPDATE A BASE TABLE THRU VIEW , LET SEE 

CREATE VIEW VW_EMPLOYEEDATAEXCEPTSALARY 
AS 
SELECT ID, NAME, GENDER, DEPARTMENT_ID FROM EMPLOYEE

SELECT * FROM VW_EMPLOYEEDATAEXCEPTSALARY

UPDATE VW_EMPLOYEEDATAEXCEPTSALARY SET NAME ='JAYANTI' WHERE ID = 6 -- YES WE CAN UPDATE,INSERT,DELETE THE BASE TABLE USING VIEW IF THE TABLE IS MADE OF SINGLE TABLE 

DELETE FROM VW_EMPLOYEEDATAEXCEPTSALARY WHERE ID = 6

INSERT INTO VW_EMPLOYEEDATAEXCEPTSALARY VALUES(6,'JAYANT','MALE',3)

-- NOW CHECKING THE UPDATE WHEN IT MADE OF COMPOSITE TABLE
SELECT * FROM VW_EMPLOYEEBYDEPARTMENT

-- IT WILL UPDATE THE DEPARTMENT_NAME IN DEPARTMENT TABLE, IT WILL NOT WORK AS WE GIVING THEM TASK
UPDATE VW_EMPLOYEEBYDEPARTMENT SET DEPARTMENT_NAME = 'IT' WHERE NAME = 'JAYANT'
-- WE ARE ONLY UPDATING THE DEPARTMENT_NAME OF JAYANT ONLY BUT IT WILL UPDATE THE DEPARTMENT_TABLE

SELECT * FROM DEPARTMENT
SELECT * FROM EMPLOYEE

UPDATE DEPARTMENT SET DEPARTMENT_NAME = 'BPO' WHERE ID =3 -- WE FIX THE CHANGES 

-- IF THE VIEW IS MADE OF MULTIPLE TABLE AND WE WANT TO UPDATE THE TABLE THEN WE CAN USE  "INSTEAD OF " TRIGGERS


-- INDEXED VIEWS --

-- WHEN WE INDEX THE VIEW THEN VIEW IS GOT MATERIALIZED WHICH MEANS THAT NOW VIEW IS CAPABLE OF STORING A DATA 

CREATE VIEW VW_TOTALSALESBYPRODUCT 
WITH SCHEMABINDING
AS 
SELECT NAME, SUM(ISNULL((QUANTITY_SOLD * UNITPRICE),0)) AS TOTAL_SALES, COUNT_BIG(*) AS TOTAL_TARNSACTIONS
FROM dbo.tblPRODUCTSALES JOIN dbo.tblPRODUCT 
ON dbo.tblPRODUCT.PRODUCT_ID = dbo.tblPRODUCTSALES.PRODUCT_ID

SELECT * FROM VW_TOTALSALESBYPRODUCT

CREATE UNIQUE CLUSTERED INDEX UIX_VWTOTALSALESBYPRODUCT_NAME ON VW_TOTALSALESBYPRODUCT(NAME)