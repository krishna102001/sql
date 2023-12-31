CREATE VIEW VW_EMPLOYEEDETAILS
AS
    SELECT EMPLOYEE.ID, NAME, GENDER, DEPARTMENT_NAME FROM EMPLOYEE 
    JOIN DEPARTMENT ON EMPLOYEE.DEPARTMENT_ID = DEPARTMENT.ID

SELECT * FROM VW_EMPLOYEEDETAILS


INSERT INTO VW_EMPLOYEEDETAILS VALUES(9,'VED','MALE','IT') -- IT WILL SHOW ERROR 'IS NOT UPDATEABLE BECAUSE THE MODIFICATION AFFECTS MULTIPLE BASE TABLES'

ALTER TRIGGER TR_VW_EMPLOYEEDEATILS_INSTEADOFINSERT
ON VW_EMPLOYEEDETAILS
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @DEPT_ID INT
    SELECT @DEPT_ID = DEPARTMENT.ID FROM DEPARTMENT
    JOIN INSERTED ON INSERTED.DEPARTMENT_NAME = DEPARTMENT.DEPARTMENT_NAME

    IF(@DEPT_ID IS NULL)
    BEGIN
        RAISERROR('INVALID DEPARTMENT NAME, STATEMENT TERMINATED',16,1)
        RETURN
    END

    INSERT INTO EMPLOYEE(ID, NAME, GENDER, DEPARTMENT_ID)
    SELECT ID,NAME,GENDER,@DEPT_ID FROM INSERTED 
END


INSERT INTO VW_EMPLOYEEDETAILS VALUES(9,'VED','MALE','IT') -- IT WILL GET INSERTED SUCCESSFUL

INSERT INTO VW_EMPLOYEEDETAILS VALUES(10,'VEDI','FEMALE','ITI') -- IT WILL RAISERROR BECAUSE OF INVALID DEPARTMENT NAME

SELECT * FROM EMPLOYEE
SELECT * FROM DEPARTMENT

UPDATE VW_EMPLOYEEDETAILS SET NAME='VEDI' , DEPARTMENT_NAME='IT' WHERE ID = 9 -- IT WILL GIVE ERROR ' is not updatable because the modification affects multiple base tables.'
-- SO TO GET RID OF THIS ERROR WE WILL USE INSTEAD OF UPDATE 

CREATE TRIGGER TR_VW_EMPLOYEEDETAILS_INSTEADOFUPDATE 
ON VW_EMPLOYEEDETAILS
INSTEAD OF UPDATE
AS 
BEGIN
    --CHECK WHETHER USER IS NOT TRYING TO UPDATE THE ID
    IF(UPDATE(ID))
    BEGIN
        RAISERROR('ID CANNOT BE CHANGED',16,1)
        RETURN
    END

    -- IF DEPARTMENT NAME IS UPDATING
    IF(UPDATE(DEPARTMENT_NAME))
    BEGIN
        DECLARE @DEPT_ID INT

        SELECT @DEPT_ID = DEPARTMENT.ID FROM DEPARTMENT JOIN
        INSERTED ON INSERTED.DEPARTMENT_NAME = DEPARTMENT.DEPARTMENT_NAME
        
        IF(@DEPT_ID IS NULL)
        BEGIN
            RAISERROR('DEPARTMENT IS INVALID',16,1)
            RETURN
        END

        UPDATE EMPLOYEE SET DEPARTMENT_ID = @DEPT_ID FROM INSERTED JOIN EMPLOYEE ON INSERTED.ID = EMPLOYEE.ID
    END
    
    IF(UPDATE(GENDER))
    BEGIN
        UPDATE EMPLOYEE SET GENDER = INSERTED.GENDER FROM INSERTED JOIN EMPLOYEE ON INSERTED.ID = EMPLOYEE.ID 
    END

    IF(UPDATE(NAME))
    BEGIN
        UPDATE EMPLOYEE SET NAME = INSERTED.NAME FROM INSERTED JOIN EMPLOYEE ON INSERTED.ID = EMPLOYEE.ID
    END
END


UPDATE VW_EMPLOYEEDETAILS SET NAME = 'VEDI' , DEPARTMENT_NAME = 'BPO' WHERE ID =9

UPDATE VW_EMPLOYEEDETAILS SET NAME = 'SHANTI' WHERE ID = 8 

UPDATE VW_EMPLOYEEDETAILS SET NAME = 'VED' , DEPARTMENT_NAME = 'HR' WHERE ID =9

SELECT * FROM VW_EMPLOYEEDETAILS

DELETE FROM VW_EMPLOYEEDETAILS WHERE ID =1 -- IT WILL CAUSE AN ERROR 'is not updatable because the modification affects multiple base tables.'

ALTER TRIGGER TR_VW_EMPLOYEEDETAILS_INSTEADOFDELETE
ON VW_EMPLOYEEDETAILS
INSTEAD OF DELETE
AS 
BEGIN
    -- DELETE EMPLOYEE FROM EMPLOYEE JOIN DELETED ON DELETED.ID = EMPLOYEE.ID

    --SUBQUERY 
    DELETE FROM EMPLOYEE WHERE ID IN (SELECT ID FROM DELETED)
END

SELECT * FROM VW_EMPLOYEEDETAILS

DELETE FROM VW_EMPLOYEEDETAILS WHERE ID = 9