SELECT * FROM tblEmp
-- THERE IS THREE WAYS TO REMOVE THE NULL 
-- 1. ISNULL(COLUMN NAME, REPLACING_VALUES)
SELECT E.NAME AS EMPLOYEE , ISNULL(M.NAME,'NO MANAGER') AS MANAGER
FROM tblEmp E 
LEFT JOIN tblEmp M 
ON E.MANAGER_ID = M.EMPLOYEE_ID 
-- 2. COALESCE(COLUMN NAME, REPLACING_VALUE) THIS GIVE FIRST NOT NULL VALUE 
SELECT E.NAME AS EMPLOYEE, COALESCE(M.NAME,'NO MANAGER') AS MANAGER
FROM tblEmp E 
LEFT JOIN tblEmp M 
ON E.MANAGER_ID = M.EMPLOYEE_ID
-- 3. CASE WHEN CONDITION THEN (IF TRUE WHAT TO PERFOM) ELSE (WHAT TO NOT) END
SELECT E.NAME AS EMPLOYEE, CASE WHEN M.NAME IS NULL THEN 'NO MANAGER' ELSE M.NAME END AS MANAGER
FROM tblEmp E 
LEFT JOIN tblEmp M 
ON E.MANAGER_ID = M.EMPLOYEE_ID