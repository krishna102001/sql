-- DROP TABLE tblEmp
-- CREATE TABLE tblEmp(
--     EMPLOYEE_ID INT NOT NULL PRIMARY KEY,
--     NAME NVARCHAR(50),
--     MANAGER_ID INT NULL,
-- ) 
SELECT * FROM tblEmp
-- INSERT INTO tblEmp VALUES(5,'SAM',1)

SELECT E.NAME AS EMPLOYEE , M.NAME AS MANAGER
FROM tblEmp E
LEFT JOIN tblEmp M 
ON E.MANAGER_ID = M.EMPLOYEE_ID

SELECT E.NAME AS EMPLOYEE ,  M.NAME AS MANAGER -- what to show as output
FROM tblEmp E    -- tblEmp E is a new table (left table)
INNER JOIN tblEmp M -- tblEmp M is a new table (right table)
ON E.MANAGER_ID = M.EMPLOYEE_ID  -- condition

SELECT E.NAME AS EMPLOYEE, M.NAME AS MANAGER
FROM tblEmp E 
CROSS JOIN tblEmp M