-- CREATE TABLE TBLPRODUCTS(
--     [ID] INT IDENTITY PRIMARY KEY,
--     [NAME] NVARCHAR(50),
--     [DESCRIPTION] NVARCHAR(250)
-- )
-- INSERT INTO TBLPRODUCTS VALUES('TV','52 INCH BLACK COLOR LCD TV')
-- INSERT INTO TBLPRODUCTS VALUES('LAPTOP','VERY THIN BLACK COLOR ACER LAPTOP')
-- INSERT INTO TBLPRODUCTS VALUES('DESKTOP','HP HIGH PERFORMANCE DESKTOP')

-- CREATE TABLE TBLPRODUCTSALE(
--     [ID] INT PRIMARY KEY IDENTITY,
--     PRODUCTID INT FOREIGN KEY REFERENCES TBLPRODUCTS(ID),
--     UNITPRICE INT,
--     QUANTITYSOLD INT
-- )

-- INSERT INTO TBLPRODUCTSALE VALUES(3,450,5)
-- INSERT INTO TBLPRODUCTSALE VALUES(2,250,7)
-- INSERT INTO TBLPRODUCTSALE VALUES(3,450,4)
-- INSERT INTO TBLPRODUCTSALE VALUES(3,450,9)

SELECT * FROM TBLPRODUCTS
SELECT * FROM TBLPRODUCTSALE

--SUBQUERY ALWAYS WILL BE IN THE PARANTHESIS ()
SELECT ID , NAME , DESCRIPTION FROM TBLPRODUCTS WHERE ID NOT IN (SELECT DISTINCT PRODUCTID FROM TBLPRODUCTSALE)

SELECT TBLPRODUCTS.ID,NAME,DESCRIPTION FROM TBLPRODUCTS 
LEFT JOIN TBLPRODUCTSALE ON TBLPRODUCTS.ID = TBLPRODUCTSALE.PRODUCTID
WHERE TBLPRODUCTSALE.PRODUCTID IS NULL

SELECT NAME , ( SELECT SUM(QUANTITYSOLD) FROM TBLPRODUCTSALE WHERE PRODUCTID = TBLPRODUCTS.ID) AS QTYSOLD FROM TBLPRODUCTS -- IT IS CORRELATED SUBQUERY 

SELECT NAME, SUM(QUANTITYSOLD) AS QTYSOLD FROM TBLPRODUCTS
LEFT JOIN TBLPRODUCTSALE ON TBLPRODUCTSALE.PRODUCTID = TBLPRODUCTS.ID GROUP BY NAME

-- IN CORRELATED SUBQUERY THE INNER SUBQUERY IS DEPENDED ON OUTER SUBQUERY          



-- if table exists drop and recreate 
IF(EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TBLPRODUCTSALE'))
BEGIN
    DROP TABLE TBLPRODUCTSALE
END

IF(EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TBLPRODUCTS'))
BEGIN
    DROP TABLE TBLPRODUCTS
END

CREATE TABLE TBLPRODUCTS(
    [ID] INT IDENTITY PRIMARY KEY,
    [NAME] NVARCHAR(50),
    [DESCRIPTION] NVARCHAR(250)
)

CREATE TABLE TBLPRODUCTSALE(
    [ID] INT PRIMARY KEY IDENTITY,
    PRODUCTID INT FOREIGN KEY REFERENCES TBLPRODUCTS(ID),
    UNITPRICE INT,
    QUANTITYSOLD INT
)

DECLARE @ID INT
SET @ID = 1
WHILE(@ID <= 10000)
BEGIN
    INSERT INTO TBLPRODUCTS VALUES('PRODUCT - ' + CAST(@ID AS NVARCHAR(20)), 'PRODUCT - ' + CAST(@ID AS NVARCHAR(20)) + ' DESCRIPTION ')
    PRINT @ID
    SET @ID = @ID + 1
END
SELECT * FROM TBLPRODUCTS

DECLARE @RANDOMPRODUCTID INT
DECLARE @RANDOMUNITPRICE INT
DECLARE @RANDOMQUANTITYSOLD INT 

DECLARE @UPPERLIMITFORPRODUCTID INT
DECLARE @LOWERLIMITFORPRODUCTID INT 

SET @LOWERLIMITFORPRODUCTID = 1
SET @UPPERLIMITFORPRODUCTID = 8500

DECLARE @UPPERLIMITFORUNITPRICE INT
DECLARE @LOWERLIMITFORUNITPRICE INT

SET @LOWERLIMITFORUNITPRICE = 1
SET @UPPERLIMITFORUNITPRICE = 100

DECLARE @UPPERLIMITFORQUANTITYSOLD INT
DECLARE @LOWERLIMITFORQUANTITYSOLD INT

SET @LOWERLIMITFORQUANTITYSOLD = 1
SET @UPPERLIMITFORQUANTITYSOLD = 10

DECLARE @COUNTER INT 
SET @COUNTER = 1
WHILE(@COUNTER <= 15000)
BEGIN
    SELECT @RANDOMPRODUCTID = ROUND(((@UPPERLIMITFORPRODUCTID-@LOWERLIMITFORPRODUCTID)*RAND()+1),0)
    SELECT @RANDOMUNITPRICE = ROUND(((@UPPERLIMITFORUNITPRICE-@LOWERLIMITFORUNITPRICE)*RAND()+1),0)
    SELECT @RANDOMQUANTITYSOLD = ROUND(((@UPPERLIMITFORQUANTITYSOLD-@LOWERLIMITFORQUANTITYSOLD)*RAND()+1),0)
    INSERT INTO TBLPRODUCTSALE VALUES(@RANDOMPRODUCTID,@RANDOMUNITPRICE,@RANDOMQUANTITYSOLD)
    SET @COUNTER = @COUNTER + 1
END
SELECT * FROM TBLPRODUCTSALE

SELECT COUNT(*) FROM TBLPRODUCTS
SELECT COUNT(*) FROM TBLPRODUCTSALE
-- CLEARNING A CACHE AND BUFFERS 
CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS;
GO
DBCC FREEPROCCACHE;
GO

SELECT ID,NAME , DESCRIPTION FROM TBLPRODUCTS WHERE ID IN (
    SELECT PRODUCTID FROM TBLPRODUCTSALE
)

SELECT DISTINCT TBLPRODUCTS.ID, NAME , DESCRIPTION FROM TBLPRODUCTS 
INNER JOIN TBLPRODUCTSALE ON TBLPRODUCTS.ID =TBLPRODUCTSALE.PRODUCTID

SELECT ID, NAME, DESCRIPTION FROM TBLPRODUCTS WHERE NOT EXISTS(SELECT * FROM TBLPRODUCTSALE WHERE TBLPRODUCTSALE.PRODUCTID = TBLPRODUCTS.ID)

SELECT TBLPRODUCTS.ID,NAME,DESCRIPTION FROM TBLPRODUCTS
LEFT JOIN TBLPRODUCTSALE ON TBLPRODUCTS.ID=TBLPRODUCTSALE.PRODUCTID WHERE TBLPRODUCTSALE.PRODUCTID IS NULL