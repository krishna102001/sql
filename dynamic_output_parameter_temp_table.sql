-- Create table Employees
-- (
--      ID int primary key identity,
--      FirstName nvarchar(50),
--      LastName nvarchar(50),
--      Gender nvarchar(50),
--      Salary int
-- )
-- Go

-- Insert into Employees values ('Mark', 'Hastings', 'Male', 60000)
-- Insert into Employees values ('Steve', 'Pound', 'Male', 45000)
-- Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
-- Insert into Employees values ('Philip', 'Hastings', 'Male', 45000)
-- Insert into Employees values ('Mary', 'Lambeth', 'Female', 30000)
-- Insert into Employees values ('Valarie', 'Vikings', 'Female', 35000)
-- Insert into Employees values ('John', 'Stanmore', 'Male', 80000)
-- Go

DECLARE @SQL NVARCHAR(MAX)
DECLARE @GENDER NVARCHAR(10)
SET @GENDER = 'MALE'
SET @SQL = 'SELECT COUNT(*) FROM Employees WHERE Gender = @GENDER'
EXECUTE sp_executesql @SQL, N'@GENDER NVARCHAR(10)',@GENDER

ALTER PROC SP_EMPLOYEECOUNT
@GENDER NVARCHAR(10),
@COUNT INT OUTPUT
AS 
BEGIN 
    DECLARE @SQL NVARCHAR(MAX)
    SET @SQL = 'SELECT COUNT(*) FROM Employees WHERE Gender = @GENDER'
    EXECUTE sp_executesql @SQL, N'@GENDER NVARCHAR(10), @COUNT INT OUTPUT',@GENDER,@COUNT OUTPUT
    SELECT @COUNT
END

EXEC SP_EMPLOYEECOUNT 'FEMALE',0


-- TEMP TABLE IN DYNAMIC SQL 
Create procedure spTempTableInDynamicSQL
as
Begin
       Declare @sql nvarchar(max)
       Set @sql = 'Create Table #Test(Id int)
                           insert into #Test values (101)
                           Select * from #Test'
       Execute sp_executesql @sql
End
Execute spTempTableInDynamicSQL

-- BELOW ONE WILL GIVE ERROR  "Invalid object name '#Test'"
Alter procedure spTempTableInDynamicSQL
as
Begin
       Declare @sql nvarchar(max)
       Set @sql = 'Create Table #Test(Id int)
                           insert into #Test values (101)'
       Execute sp_executesql @sql
       Select * from #Test
End
Execute spTempTableInDynamicSQL

-- IT IS ACCESSABLE 
Alter procedure spTempTableInDynamicSQL
as
Begin
       Create Table #Test(Id int)
       insert into #Test values (101)
       Declare @sql nvarchar(max)
       Set @sql = 'Select * from #Test'
       Execute sp_executesql @sql
End
Execute spTempTableInDynamicSQL