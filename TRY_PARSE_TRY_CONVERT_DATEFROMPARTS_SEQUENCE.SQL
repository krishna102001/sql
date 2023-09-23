-- CHOOSE FUNCTION RETURN THE VALUE SPECIFIED  AT THE INDEX IN THE LIST
-- SYNTAX
-- CHOOSE(INDEX , VAL1,VAL2, VAL3,...)
-- HERE INDEX START WITH 1 NOT WITH 0

SELECT CHOOSE(1,'INDIA','US','UK') AS COUNTRY -- IT WILL RETURN INDIA
SELECT CHOOSE(0,'INDIA','US','UK') AS COUNTRY -- IT WILL RETURN NULL
SELECT CHOOSE(3,'INDIA','US','UK') AS COUNTRY -- IT WILL RETURN UK

Create table Employees
(
     Id int primary key identity,
     Name nvarchar(10),
     DateOfBirth date
)
Go

Insert into Employees values ('Mark', '01/11/1980')
Insert into Employees values ('John', '12/12/1981')
Insert into Employees values ('Amy', '11/21/1979')
Insert into Employees values ('Ben', '05/14/1978')
Insert into Employees values ('Sara', '03/17/1970')
Insert into Employees values ('David', '04/05/1978')
Go

SELECT Name, DateOfBirth,
        CASE DATEPART(MM, DateOfBirth)
            WHEN 1 THEN 'JAN'
            WHEN 2 THEN 'FEB'
            WHEN 3 THEN 'MAR'
            WHEN 4 THEN 'APR'
            WHEN 5 THEN 'MAY'
            WHEN 6 THEN 'JUN'
            WHEN 7 THEN 'JUL'
            WHEN 8 THEN 'AUG'
            WHEN 9 THEN 'SEP'
            WHEN 10 THEN 'OCT'
            WHEN 11 THEN 'NOV'
            WHEN 12 THEN 'DEC'
        END
       AS [MONTH]
FROM Employees

SELECT Name,DateOfBirth,CHOOSE(DATEPART(MONTH,DateOfBirth),'JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC') FROM Employees

-- IIF FUNCTION IT RETURN ONE OF TWO  THE VALUES, DEPENDING ON WHETHER THE BOOLEAN EXPRESSION EVALUTES TO TRUE OR FALSE
-- SYNTAX
-- IIF(EXPRESSION, TRUE_VALUE,FALSE_VALUE)
DECLARE @GENDER INT
SET @GENDER = 2
SELECT IIF(@GENDER=1,'MALE','FEMALE') AS GENDER

Create table Employees
(
     Id int primary key identity,
     Name nvarchar(10),
     GenderId int
)
Go

Insert into Employees values ('Mark', 1)
Insert into Employees values ('John', 1)
Insert into Employees values ('Amy', 2)
Insert into Employees values ('Ben', 1)
Insert into Employees values ('Sara', 2)
Insert into Employees values ('David', 1)
Go

SELECT * FROM Employees

SELECT Name, GenderId,
        CASE WHEN GenderId = 1
                    THEN 'Male'
                    ELSE 'Female'
        END AS Gender
FROM Employees

SELECT Name,GenderId,IIF(GenderId = 1,'MALE','FEMALE') AS GENDER FROM Employees

--TRY_PARSE FUNCTION  IT CONVERT THE STRING INTO DATE/TIME OR NUMERIC TYPE
-- RETURNS NULL IF THE PROVIDED STRING IS CANNOT BE CONVERTED TO SPECIFIED DATATYPE
-- REQUIRE .NET FRAME WORK COMMON LANGUAGE RUNTIME(CLR)
-- SYNTAX 
-- TRY_PARSE( STRING VALUE AS DATATYPE)

SELECT TRY_PARSE('99' AS INT) -- IT WILL RETURN 99

SELECT TRY_PARSE('ABC' AS INT) -- IT WILL RETURN NULL 

SELECT CASE WHEN TRY_PARSE('ABC' AS INT) IS NULL
           THEN 'Conversion Failed'
           ELSE 'Conversion Successful'
END AS Result

SELECT PARSE('ABC' AS INT) AS Result -- IT WILL RETURN ERROR
SELECT TRY_PARSE('ABC' AS INT) AS Result -- IT WILL RETURN NULL

Create table Employees
(
     Id int primary key identity,
     Name nvarchar(10),
     Age nvarchar(10)
)
Go

Insert into Employees values ('Mark', '40')
Insert into Employees values ('John', '20')
Insert into Employees values ('Amy', 'THIRTY')
Insert into Employees values ('Ben', '21')
Insert into Employees values ('Sara', 'FIFTY')
Insert into Employees values ('David', '25')
Go

SELECT Name, TRY_PARSE(Age AS INT) AS Age FROM Employees

-- TRY_CONVERT() FUNCTION  IT CONVERT THE VALUE TO SPECIFICED DATA TYPE
-- RETURN NULL IF THE PROVIDED VALUE CANNOT BE CONVERTED TO SPECIFIED DATATYPE
-- IF WE REQUEST A CONVERSION THAT IS EXPLICITLY NOT PERMITTED, THE TRY_CONVERT FAILS WITH AN ERROR
-- SYNTAX 
-- TRY_CONVERT(DATA_TYPE, VALUE,[STYLE])

SELECT TRY_CONVERT(INT,'99') -- IT RETURN 99 INTEGER DATATYPE
SELECT TRY_CONVERT(INT,'ABC') -- IT RETURN NULL
SELECT TRY_CONVERT(XML,10) -- IT WILL RETURN ERROR Explicit conversion from data type int to xml is not allowed.
SELECT Name,Age,TRY_CONVERT(INT,Age) AS AGE FROM Employees

SELECT TRY_CONVERT(XML,'<ROOT><CHILD/></ROOT>') AS [XML]

--EOMONTH  IT RETURN LAST DAY OF MONTH
-- SYNTAX
-- EOMONTH(START_DATE,[MONTH TO ADD (OPTIONAL)])

SELECT EOMONTH('11/09/2023') AS LASTDAY -- (MM/DATE/YEAR)
SELECT EOMONTH('11/09/2023',3) AS LASTDAY -- IT WILL RETURN 2024-02-29
Create table Employees
(
     Id int primary key identity,
     Name nvarchar(10),
     DateOfBirth date
)
Go

Insert into Employees values ('Mark', '01/11/1980')
Insert into Employees values ('John', '12/12/1981')
Insert into Employees values ('Amy', '11/21/1979')
Insert into Employees values ('Ben', '05/14/1978')
Insert into Employees values ('Sara', '03/17/1970')
Insert into Employees values ('David', '04/05/1978')
Go

SELECT Name,DateOfBirth,EOMONTH(DateOfBirth) AS LASTDAY FROM Employees

-- DATEFROMPARTS FUNCTION . IT RETURNS A DATA VALUE FOR SPECIFIED YEAR,MONTH AND DAY
-- THE DATA TYPE OF ALL THREE PARAMETER MUST BE INTEGER , IF INVALID AGRUMENT VALUE ARE SPECIFIED THEN IT WILL GIVE ERROR
-- SYNTAX
-- DATEFROMPARTS(YEAR,MONTH,DAY)

SELECT DATEFROMPARTS(2023,10,10) AS [DATE] -- IT RETURN 2023-10-10

SELECT DATEFROMPARTS(2024,15,10) -- IT WILL GIVE ERROR "Cannot construct data type date, some of the arguments have values which are not valid."

--DATETIME2FROMPARTS IT RETURN DATETIME2
-- THE DATAYPE OF ALL PARAMETER MUST BE INTEGER
-- IF ANY INVALID AGRUMENT VALUES IS SPECIFIED THEN IT WILL GIVE ERROR 
-- IF ANY ARGUMENT ARE NULL THEN FUNCTION WILL ALSO RETURN NULL

-- SYNTAX
-- DATETIME2FROMPARTS(YEAR,MONTH,DAY,HOUR,MINUTES,SECOND,FRACTION,PRECISION)

SELECT DATETIME2FROMPARTS(2023,10,20,23,59,59,0,0) AS [DATETIME2] -- IT RETURN 2023-10-20 23:59:59

SELECT DATETIME2FROMPARTS(2023,10,20,23,59,59,4,5) AS [DATETIME2] -- IT RETURN 2023-10-20 23:59:59.00004

SELECT DATETIME2FROMPARTS(2023,10,20,23,59,NULL,4,5) AS [DATETIME2] -- IT RETURN NULL

-- DATETIME VS DATETIME2
-- DECLARE @TempTable TABLE
-- (
--     DateTime2Precision1 DATETIME2(1),
--     DateTime2Precision2 DATETIME2(2),
--     DateTime2Precision3 DATETIME2(3),
--     DateTime2Precision4 DATETIME2(4),
--     DateTime2Precision5 DATETIME2(5),
--     DateTime2Precision6 DATETIME2(6),
--     DateTime2Precision7 DATETIME2(7)
-- )
-- INSERT INTO @TempTable VALUES
-- (  
--     '2015-10-20 15:09:12.1234567',
--     '2015-10-20 15:09:12.1234567',
--     '2015-10-20 15:09:12.1234567',
--     '2015-10-20 15:09:12.1234567',
--     '2015-10-20 15:09:12.1234567',
--     '2015-10-20 15:09:12.1234567',
--     '2015-10-20 15:09:12.1234567'
-- )
-- SELECT 'Precision - 1' AS [Precision],
--          DateTime2Precision1 AS DateValue,
--          DATALENGTH(DateTime2Precision1) AS StorageSize
-- FROM @TempTable

-- UNION ALL

-- SELECT 'Precision - 2',
--          DateTime2Precision2,
--          DATALENGTH(DateTime2Precision2) AS StorageSize
-- FROM @TempTable

-- UNION ALL

-- SELECT 'Precision - 3',
--          DateTime2Precision3,
--          DATALENGTH(DateTime2Precision3)
-- FROM @TempTable

-- UNION ALL

-- SELECT 'Precision - 4',
--          DateTime2Precision4,
--          DATALENGTH(DateTime2Precision4)
-- FROM @TempTable

-- UNION ALL

-- SELECT 'Precision - 5',
--          DateTime2Precision5,
--          DATALENGTH(DateTime2Precision5)
-- FROM @TempTable

-- UNION ALL

-- SELECT 'Precision - 6',
--          DateTime2Precision6,
--          DATALENGTH(DateTime2Precision6)
-- FROM @TempTable

-- UNION ALL
-- SELECT 'Precision - 7',
--          DateTime2Precision7,
--          DATALENGTH(DateTime2Precision7) AS StorageSize
-- FROM @TempTable

-- OFFSET FUNCTION IT RETURNS A PAGE OF RESULTS FROM THE RESULTS SET
-- ORDER BY CLAUSE IS REQUIRED

-- SYNTAX 
-- SELECT * FROM TABLE_NAME ORDER BY COLUMN_LIST
-- OFFSET ROW_TO_SKIP ROWS FETCH NEXT ROWS_TO_FETCH ROWS ONLY 

Create table tblProducts
(
    Id int primary key identity,
    Name nvarchar(25),
    [Description] nvarchar(50),
    Price int
)
DECLARE @START INT
SET @START = 1
DECLARE @NAME VARCHAR(25)
DECLARE @DESCRIPTION VARCHAR(50)

WHILE(@START <= 100)
BEGIN
    SET @NAME = 'PRODUCT - '+ LTRIM(@START)
    SET @DESCRIPTION = 'PRODUCT DESCRIPTION - ' + LTRIM(@START)
    INSERT INTO tblProducts VALUES(@NAME,@DESCRIPTION,@START * 10)
    SET @START = @START + 1
END

SELECT * FROM tblProducts

SELECT * FROM tblProducts ORDER BY Id
OFFSET 20 ROWS FETCH NEXT 5 ROWS ONLY

CREATE PROC SP_GETROWSBYPAGENUMBER
@PAGENUMBER INT,
@PAGESIZE INT
AS 
BEGIN
    SELECT * FROM tblProducts ORDER BY Id
    OFFSET (@PAGENUMBER - 1) ROWS FETCH NEXT @PAGESIZE ROWS ONLY
END

EXEC SP_GETROWSBYPAGENUMBER 5,10


-- IDENTIFYING THE DEPENDENCIES 

SELECT * FROM sys.dm_sql_referencing_entities('dbo.tblProducts','Object') 

-- The object which is appearing inside the SQL expression is known as referenced entity 
-- and the object which has the SQL expression is known as a referencing entity.

-- To get the REFERENCING ENTITIES use SYS.DM_SQL_REFERENCING_ENTITIES dynamic management function
-- To get the REFERENCED ENTITIES use SYS.DM_SQL_REFERENCED_ENTITIES dynamic management function

SELECT * FROM sys.dm_sql_referenced_entities('dbo.SP_GETROWSBYPAGENUMBER','Object') 

EXEC sp_depends 'tblProducts' -- it will show refernceing and its type


-- SEQUENCE Object : IT Generates sequence of numeric values in an ascending or descending order
-- SYNTAX
-- CREATE SEQUENCE [schema_name . ] sequence_name
--     [ AS [ built_in_integer_type | user-defined_integer_type ] ]
--     [ START WITH <constant> ]
--     [ INCREMENT BY <constant> ]
--     [ { MINVALUE [ <constant> ] } | { NO MINVALUE } ]
--     [ { MAXVALUE [ <constant> ] } | { NO MAXVALUE } ]
--     [ CYCLE | { NO CYCLE } ]
--     [ { CACHE [ <constant> ] } | { NO CACHE } ]
--     [ ; ]

CREATE SEQUENCE [dbo].[SEQUENCEOBJECT] 
AS INT
START WITH 1
INCREMENT BY 1

SELECT NEXT VALUE FOR [dbo].[SEQUENCEOBJECT] -- GENERATING THE SEQUENCE VALUE 
 
SELECT current_value FROM sys.sequences WHERE name = 'SEQUENCEOBJECT' -- it will show current of sequnece

ALTER SEQUENCE [SEQUENCEOBJECT] RESTART WITH 1 -- RESETING THE VALUE OF SEQUENCE

SELECT * FROM Employees 

-- TABLE
-- CREATE TABLE Employees
-- (
--     Id INT PRIMARY KEY,
--     Name NVARCHAR(50),
--     Gender NVARCHAR(10)
-- )

INSERT INTO Employees VALUES(NEXT VALUE FOR[dbo].[SEQUENCEOBJECT],'BEN','MALE')
INSERT INTO Employees VALUES(NEXT VALUE FOR[dbo].[SEQUENCEOBJECT],'MARY','FEMALE')
INSERT INTO Employees VALUES(NEXT VALUE FOR[dbo].[SEQUENCEOBJECT],'KRIS','MALE')

-- DECREMENT BY 1 SEQUENCE CREATED
CREATE SEQUENCE [dbo].[SEQUENCEOBJECT1]
AS INT
START WITH 100
INCREMENT BY -1

SELECT NEXT VALUE FOR [dbo].[SEQUENCEOBJECT1]

-- SPECIFYING MIN MAX VALUE IN SEQUENCE 
CREATE SEQUENCE [dbo].[SEQUENCEOBJECT2]
AS INT
START WITH 100
INCREMENT BY -1
MINVALUE 90
MAXVALUE 100

SELECT NEXT VALUE FOR [DBO].[SEQUENCEOBJECT2]

ALTER SEQUENCE [DBO].[SEQUENCEOBJECT2] RESTART WITH 100

-- IF WANT TO RUN IN LOOP THEN WE USE CYCLE WHEN IT REACH 90 THEN IT WILL AGAIN START WITH 100
ALTER SEQUENCE [dbo].[SEQUENCEOBJECT2]
INCREMENT BY -1
MINVALUE 90
MAXVALUE 100
CYCLE

CREATE SEQUENCE [DBO].[SEQUENCEOBJECT3]
AS INT 
START WITH 1
INCREMENT BY 1
CACHE 10

SELECT NEXT VALUE FOR [DBO].[SEQUENCEOBJECT3]