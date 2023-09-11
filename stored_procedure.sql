-- SELECT * FROM EMPLOYEE 
-- SP IS USED WHEN WE HAVE TO WRITE THE SAME QUERY AGAIN N AGAIN INSTEAD OF WRITING SAME QUERY WE USE STORED PROCEDURE AND CALL ITS NAME WHEN 
-- REQUIRED

-- TO CREATE A STORED PROCEDURE WE USE PROCEDURE OR PROC KEYWORD

CREATE PROCEDURE spEmployeeDetails -- NEVER NAME THE SP_ ANY SP WHILE CREATING A PROCEDURE BCZ THIS PREFIX IS ALREADY USED BY SYSTEM
AS
BEGIN
    SELECT * FROM EMPLOYEE
END

-- OR --

CREATE PROC spEmployeeDetails1
AS 
BEGIN
    SELECT NAME,GENDER FROM EMPLOYEE
END

-- TO EXECUTE THE PROCEDURE WE USE EXECUTE OR EXEC KEYWORD

EXECUTE spEmployeeDetails

-- OR --

EXEC spEmployeeDetails1

-- SP WITH PARAMETER --

CREATE PROC spEmployeeDetailsGetByGender 
@GENDER NVARCHAR(20), @ID INT
AS 
BEGIN
 SELECT NAME,GENDER,SALARY FROM EMPLOYEE WHERE GENDER = @GENDER AND ID = @ID
END

-- SP WITH ENCRYPTION AND MODIFY THE ALREADY CREATED SP USING ALTER KEYWORD
-- ALTER PROC spEmployeeDetailsGetByGender
-- @GENDER NVARCHAR(20), @ID INT
-- WITH ENCRYPTION
-- AS 
-- BEGIN
--  SELECT NAME,GENDER,SALARY FROM EMPLOYEE WHERE GENDER = @GENDER AND ID = @ID
-- END

EXECUTE spEmployeeDetailsGetByGender 'MALE' , 1

-- DROP PROCEDURE spEmployeeDetailsGetByGender   THIS REMOVE THE SP

-- SP WITH OUTPUT --

CREATE PROCEDURE spEmployeeCountByGender 
@GENDER NVARCHAR(20) , @TOTALEMPLOYEE INT OUTPUT --TO GET OUTPUT WE NEED TO DEFINE OUTPUT OR OUT KEYWORD , THIS VARIABLE WILL HOLD THE VALUE
AS
BEGIN 
    SELECT @TOTALEMPLOYEE = COUNT(ID) FROM EMPLOYEE WHERE GENDER = @GENDER
END

-- FOR GETTING THE OUTPUT FROM SP WE HAVE TO FIRST DECLARE THE VARIABLE WITH SAME DATATYPES
DECLARE @TOTAL INT
EXECUTE spEmployeeCountByGender 'FEMALE',@TOTAL OUTPUT -- ORDER OF PASSING PARAMETER MUST BE SAME AS WHILE CREATING THE PROCEDURE
-- EXECUTE spEmployeeCountByGender @TOTALEMPLOYEE= @TOTAL OUTPUT , @GENDER='FEMALE'
PRINT @TOTAL

-- SP WITH RETURN VALUES
CREATE PROC spEmployeeCountByGen 
@GENDER NVARCHAR(20)
AS
BEGIN
    RETURN (SELECT COUNT(ID) FROM EMPLOYEE WHERE GENDER = @GENDER) -- RETURN FUNCTION WILL RETURN ONLY INT DATA TYPE ONLY AND IT ALSO CAN NOT RETURN MULTIPLE OUTPUT
END

DECLARE @TOTAL INT 
EXECUTE @TOTAL = spEmployeeCountByGen 'FEMALE'
PRINT @TOTAL

-- DIFFERENCE -- 

CREATE PROC spEmployeeGetById
@NAMES NVARCHAR(20) OUT, @ID INT 
AS
BEGIN
    SELECT @NAMES = [NAME] FROM EMPLOYEE WHERE ID = @ID
END

DECLARE @NAME NVARCHAR(20) 
EXECUTE spEmployeeGetById @NAME OUT , 3
PRINT 'NAME OF PERSON IS ' + @NAME

-- BELOW ONE WILL THROUGH AN ERROR BECAUSE IT RETURNS STRING WHICH WILL FAILED IN CONVERSION INTO INT DATATYPES
CREATE PROC spEmployeeGetByIdRETURN
@ID INT 
AS
BEGIN
    RETURN(SELECT [NAME] FROM EMPLOYEE WHERE ID = @ID)
END

DECLARE @NAME NVARCHAR(20) 
EXECUTE @NAME = spEmployeeGetByIdRETURN 3
PRINT @NAME

-- SOME HELP THINGS

SP_HELP spEmployeeDetails
SP_HELPTEXT spEmployeeDetails
SP_DEPENDS spEmployeeDetails