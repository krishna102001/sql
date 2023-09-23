-- DYNAMIC SQL 
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

DECLARE @SQL NVARCHAR(1000)
DECLARE @PARAMS NVARCHAR(1000)
SET @SQL = 'SELECT * FROM Employees WHERE FirstName = @FirstName AND LastName = @LastName'
SET @PARAMS = '@FirstName nvarchar(100),@LastName nvarchar(100)'

execute sp_executesql @SQL,@PARAMS,@FirstName = 'Ben',@LastName = 'Hoskins'

-- DYNAMIC STORED PROCEDURE 
CREATE PROCEDURE SP_SEARCHDYNAMICSQL
@FirstName NVARCHAR(100) = NULL,
@LastName NVARCHAR(100) = NULL,
@Gender NVARCHAR(50) = NULL,
@Salary INT = NULL 
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @SQLPARAMS NVARCHAR(MAX)
    
    SET @SQL = 'SELECT * FROM Employees WHERE 1 = 1'

    IF(@FirstName IS NOT NULL)
        SET @SQL = @SQL + ' AND FirstName = @FN'
    IF(@LastName IS NOT NULL)
        SET @SQL = @SQL + ' AND LastName = @LN'
    IF(@Gender IS NOT NULL)
        SET @SQL = @SQL + ' AND Gender = @Gen'
    IF(@Salary IS NOT NULL)
        SET @SQL = @SQL + ' AND Salary = @Sal'
    
    EXECUTE sp_executesql @SQL, N'@FN NVARCHAR(50),@LN NVARCHAR(50), @Gen NVARCHAR(50), @Sal int',
    @FN = @FirstName, @LN = @LastName, @Gen = @Gender, @Sal = @Salary
END

exec SP_SEARCHDYNAMICSQL @FirstName='BEN'
exec SP_SEARCHDYNAMICSQL @Gender='MALE'


-- Cached planned 
SELECT cp.usecounts, cp.cacheobjtype, cp.objtype, st.text, qp.query_plan
FROM sys.dm_exec_cached_plans AS cp
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
ORDER BY cp.usecounts DESC

DBCC FREEPROCCACHE

SELECT * FROM Employees WHERE FirstName = 'BEN' -- in this case query plan will be executed every time if we do minor change then it will create new query plan 

-- in below one case query plan will be reused even if we change the @firstname very time
Declare @FirstName nvarchar(50)
Set @FirstName = 'BEN'
Execute sp_executesql N'Select * from Employees where FirstName=@FN', N'@FN nvarchar(50)', @FirstName

-- dynamic sql 
CREATE DATABASE SalesDB

Declare @FN nvarchar(50)
Set @FN = 'John'
Declare @sql nvarchar(max)
Set @sql = 'Select * from Employees where FirstName = ''' +  @FN + ''''
Exec(@sql)

-- if we set @fn place drop TABLE  . it will become easy for hacker to do the sql injection 
Declare @FN nvarchar(50)
Set @FN = ''' Drop Database SalesDB --'''
Declare @sql nvarchar(max)
Set @sql = 'Select * from Employees where FirstName = ''' + @FN + ''''
Exec(@sql)

-- SO TO PREVENT FROM SQL INJECTION WE CAN USE QUOTENAME(VARIABLE,SYMBOL("",'''',[]))
Declare @FN nvarchar(50)
Set @FN = ''' Drop Database SalesDB --'''
Declare @sql nvarchar(max)
Set @sql = 'Select * from Employees where FirstName = ' + QUOTENAME(@FN,'''') 
PRINT @sql
Exec(@sql)

Declare @FN nvarchar(50)
Set @FN = 'John'
Declare @sql nvarchar(max)
Set @sql = 'Select * from Employees where FirstName = ' + QUOTENAME(@FN,'''')
Print @sql

DBCC FREEPROCCACHE

Declare @FN nvarchar(50)
Set @FN = 'MarK'
Declare @sql nvarchar(max)
Set @sql = 'Select * from Employees where FirstName = ' + QUOTENAME(@FN,'''')
Exec(@sql)

SELECT cp.usecounts, cp.cacheobjtype, cp.objtype, st.text, qp.query_plan
FROM sys.dm_exec_cached_plans AS cp
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
ORDER BY cp.usecounts DESC



--- QUOTENAME FUNCTION 
-- Takes two parameters - the first is a string, and the second is a delimiter that you want SQL server to use to wrap the string in.
-- The delimiter can be a left or right bracket ( [] ), a single quotation mark ( ' ), or a double quotation mark ( " )
-- The default for the second parameter is []


-- Create table [USA Customers]
-- (
--      ID int primary key identity,
--      FirstName nvarchar(50),
--      LastName nvarchar(50),
--      Gender nvarchar(50)
-- )
-- Go

-- Insert into [USA Customers] values ('Mark', 'Hastings', 'Male')
-- Insert into [USA Customers] values ('Steve', 'Pound', 'Male')
-- Insert into [USA Customers] values ('Ben', 'Hoskins', 'Male')
-- Insert into [USA Customers] values ('Philip', 'Hastings', 'Male')
-- Insert into [USA Customers] values ('Mary', 'Lambeth', 'Female')
-- Insert into [USA Customers] values ('Valarie', 'Vikings', 'Female')
-- Insert into [USA Customers] values ('John', 'Stanmore', 'Male')
-- Go

Declare @sql nvarchar(max)
Declare @tableName nvarchar(50)
Set @tableName = 'USA Customers'
Set @sql = 'Select * from ' + QUOTENAME(@tableName) -- IT HELPS TO PREVENT A SQL INJECTION
Execute sp_executesql @sql

Declare @sql nvarchar(max)
Declare @tableName nvarchar(50)
Set @tableName = 'USA Customers'
Set @sql = 'Select * from ' +QUOTENAME('dbo') +'.'+QUOTENAME(@tableName)
PRINT @sql
Execute sp_executesql @sql

SELECT QUOTENAME('USA CUSTOMERS','''') -- FOR SINGLE QUOTATION MARK
SELECT QUOTENAME('USA CUSTOMERS','"') -- FOR DOUBLE QUOTATION MARK
SELECT QUOTENAME('USA CUSTOMERS','[') -- FOR SQUARE BRACKET