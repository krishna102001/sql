-- CREATE TABLE PRODUCTSALES(
--     ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
--     SALES_AGENT NVARCHAR(5) NOT NULL,
--     SALES_COUNTRY NVARCHAR(5) NOT NULL ,
--     SALES_AMOUNT INT
-- )
-- INSERT INTO PRODUCTSALES VALUES('TOM','UK',200)
-- INSERT INTO PRODUCTSALES VALUES('JOHN','US',180)
-- INSERT INTO PRODUCTSALES VALUES('JOHN','UK',260)
-- INSERT INTO PRODUCTSALES VALUES('DAVID','INDIA',450)
-- INSERT INTO PRODUCTSALES VALUES('TOM','INDIA',350)
-- INSERT INTO PRODUCTSALES VALUES('DAVID','US',200)
-- INSERT INTO PRODUCTSALES VALUES('TOM','US',130)
-- INSERT INTO PRODUCTSALES VALUES('JOHN','INDIA',540)
-- INSERT INTO PRODUCTSALES VALUES('JOHN','UK',120)
-- INSERT INTO PRODUCTSALES VALUES('DAVID','UK',220)
-- INSERT INTO PRODUCTSALES VALUES('JOHN','UK',420)
-- INSERT INTO PRODUCTSALES VALUES('DAVID','US',320)
-- INSERT INTO PRODUCTSALES VALUES('TOM','US',340)
-- INSERT INTO PRODUCTSALES VALUES('TOM','UK',660)
-- INSERT INTO PRODUCTSALES VALUES('JOHN','INDIA',230)
-- INSERT INTO PRODUCTSALES VALUES('DAVID','INDIA',2000)
-- SELECT * FROM PRODUCTSALES

SELECT SALES_COUNTRY , SALES_AGENT , SUM(SALES_AMOUNT) AS TOTAL FROM PRODUCTSALES
GROUP BY SALES_COUNTRY,SALES_AGENT ORDER BY SALES_COUNTRY, SALES_AGENT

-- PIVOT OPERATOR IS SQL SERVER OPERATOR THAT CAN BE USED TO TURN UNIQUE VALUES FROM ONE COLUMN INTO MULTIPLE COLUMN IN THE OUPUT THERE BY 
-- EFFECTIVELY ROTATING A TABLE

SELECT SALES_AGENT, INDIA, UK, US FROM PRODUCTSALES
PIVOT
(
    SUM(SALES_AMOUNT) FOR SALES_COUNTRY IN ([INDIA], [UK], [US])
)
AS PIVOTTABLE

SELECT SALES_AGENT, INDIA, UK, US FROM
(
    SELECT SALES_AGENT, SALES_COUNTRY, SALES_AMOUNT FROM PRODUCTSALES
) AS SOURCETABLE
PIVOT
(
    SUM(SALES_AMOUNT) FOR SALES_COUNTRY IN ([INDIA],[UK],[US])
)
AS PIVOTTABLE