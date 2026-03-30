
/*
--==========SQL Project Name : Boutique House Management System[BHMS]===============--
							    
								Trainee Name	: Shabiha Mannan Era   
						    	  Trainee ID	: 1291250       
								    Batch ID	: CS/PNTL-A/67/01 
 --------------------------------------------------------------------------------
Table of Contents: DML
			=> SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			=> SECTION 02: INSERT DATA USING SEQUENCE VALUE
			=> SECTION 03: INSERT UPDATE DELETE DATA THROUGH VIEW
			=> SECTION 04: INSERT UPDATE DELETE DATA THROUGH STORED PROCEDURE
			=> SECTION 05: RETREIVE DATA USING FUNCTION(SCALAR,INLINE TABLE VALUED, MULTI STATEMENT TABLE VALUED)
			=> SECTION 06: TEST TRIGGER (FOR/AFTER TRIGGER ON TABLE, INSTEAD OF TRIGGER ON TABLE & VIEW)
			=> SECTION 07: QUERY
				SUB SECTION => 7.01 : SELECT FROM TABLE
				SUB SECTION => 7.02 : SELECT FROM VIEW
				SUB SECTION => 7.03 : SELECT INTO
				SUB SECTION => 7.04 : IMPLICIT JOIN WITH TOP CLAUSE, ORDER BY CLAUSE
				SUB SECTION => 7.05 : INNER JOIN WITH WHERE CLAUSE
				SUB SECTION => 7.06 : OUTER JOIN
				SUB SECTION => 7.07 : CROSS JOIN
				SUB SECTION => 7.08 : TOP CLAUSE WITH TIES
				SUB SECTION => 7.09 : DISTINCT
				SUB SECTION => 7.10 : COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR
				SUB SECTION => 7.11 : LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE
				SUB SECTION => 7.12 : OFFSET FETCH
				SUB SECTION => 7.13 : UNION
				SUB SECTION => 7.14 : EXCEPT INTERSECT
				SUB SECTION => 7.15 : AGGREGATE FUNCTIONS
				SUB SECTION => 7.16 : GROUP BY & HAVING CLAUSE
				SUB SECTION => 7.17 : ROLLUP & CUBE OPERATOR
				SUB SECTION => 7.18 : GROUPING SETS
				SUB SECTION => 7.19 : SUB-QUERIES (INNER, CORRELATED)
				SUB SECTION => 7.20 : EXISTS
				SUB SECTION => 7.21 : CTE
				SUB SECTION => 7.22 : BUILT IN FUNCTION
				SUB SECTION => 7.23 : CASE
				SUB SECTION => 7.24 : IIF
				SUB SECTION => 7.25 : COALESCE & ISNULL
				SUB SECTION => 7.26 : WHILE
				SUB SECTION => 7.27 : GROPING FUNCTION
				SUB SECTION => 7.28 : RANKING FUNCTION
				SUB SECTION => 7.29 : IF ELSE & PRINT
				SUB SECTION => 7.30 : TRY CATCH
				SUB SECTION => 7.31 : GOTO
				SUB SECTION => 7.32 : WAITFOR
				SUB SECTION => 7.33 : sp_helptext
				SUB SECTION => 7.34 : TRANSACTION WITH SAVE POINT
				SUB SECTION => 7.35 : CREATE A MERGE
				
*/
USE BHMS
GO
--============================ / SECTION 01 \ ==============================
			  --> INSERT DATA USING INSERT INTO KEYWORD <--
--========================================================================
-- Insert sample data into the Products table

INSERT INTO Products(ProductName,Quantity,Price) VALUES
('[Dubai Jafran Fabric Burqa]',50,1500),
('[Double Georgette Burqa]',24,1200),
('[Double Georgette Printed Burqa]',30,1100)
GO
SELECT * FROM Products
GO

INSERT INTO Products VALUES
('[Dubai Jafran Fabric Hijab]',20,500),
('[Double Georgette Hijab]',40,300)
GO
SELECT * FROM Products
GO

INSERT INTO Stocks(ProductId,Stock,Cost,Date) VALUES
(101,70,1200,'2025-01-01'),
(100,40,1200,'2025-01-01'),
(102,10,970,'2025-01-01'),
(103,5,450,'2025-01-02'),
(104,10,250,'2025-01-02')
GO

INSERT INTO ProductSize(Size) VALUES
('Small'),
('Medium'),
('Large'),
('Extra Large')
GO

SELECT * FROM ProductSize
GO

INSERT INTO ProductColor(Color) VALUES
('Black'),
('Brown'),
('Maroon'),
('Navy Blue'),
('Pink'),
('Peach'),
('Teal'),
('Olive'),
('Levender'),
('Grey')
GO
SELECT * FROM productColor
GO

INSERT INTO productDetails (ProductId,SizeId,colorId) VALUES
(100,1,1),
(100,2,1),
(100,3,1),
(100,4,1),
(100,1,2),
(100,2,5),
(100,3,6),
(100,4,10),
(101,1,1),
(101,2,1),
(101,3,1),
(101,4,1),
(101,1,2),
(101,2,5),
(101,3,9),
(101,4,10),
(103,3,1),
(103,3,2),
(103,3,3),
(103,3,4),
(103,3,5),
(103,3,6),
(103,3,9),
(103,3,10),
(103,4,1),
(103,4,2),
(103,4,10),
(104,3,1),
(104,3,5),
(104,3,7),
(104,3,10),
(104,4,1)
GO
SELECT * FROM productDetails
GO

INSERT INTO Customer(CustomerName,ContactNo,Email,Address) VALUES
('Maliha','01912398766','maliha1@gmail.com','D Block,Mirpur 1'),
('Habiba','01617295469','Ha34@gmail.com','Mirpur 6'),
('Sumaiya','01825407822','Sumaiya22@gmail.com','Uttora'),
('Momo','01756129160','momo60@gmail.com','Mirpur 1'),
('Shanjida','01450517217','m101@gmail.com','Mirpur 2')
GO
SELECT * FROM Customer
GO
INSERT INTO Customer(CustomerName,ContactNo,Email) VALUES
('Asha','01876155590','asha@gmail.com')
GO
SELECT * FROM Customer

INSERT INTO Orders(ProductId,Quantity,OrderDate,CustomerId) VALUES
(100,2,'2025-01-06',3),
(100,2,'2025-01-06',2),
(104,1,'2025-01-06',3),
(103,1,'2025-01-06',3),
(101,3,'2025-01-03',1)
GO
SELECT * FROM Orders
GO
INSERT INTO Orders(ProductId,CustomerId) VALUES
(105,5)
GO
INSERT INTO PaymentType(Types) VALUES
('Bank'),
('Cash'),
('Bkash'),
('Rocket')
GO
SELECT * FROM PaymentType
GO

INSERT INTO Payment(PaymentTypeId,ProductId,Quantity,UnitPrice,Discount,Date) VALUES
(2,100,2,1500,0.05,'2025-01-06'),
(2,103,1,500,0.05,'2025-01-06'),
(2,104,1,300,0.05,'2025-01-06'),
(3,100,2,1500,0,'2025-01-06'),
(1,101,3,1200,0,'2025-01-03')

SELECT * FROM Payment
GO


--============================ / SECTION 02 \ ==============================
			      --> INSERT DATA USING SEQUENCE VALUE <--
--========================================================================

INSERT INTO  Rating (RatingId, Rate)
VALUES 
(NEXT VALUE FOR seqNum,5),
(NEXT VALUE FOR seqNum,4.5),
(NEXT VALUE FOR seqNum,4),
(NEXT VALUE FOR seqNum,3)
GO
SELECT * FROM Rating
GO

--============================ / SECTION 03 \ ==============================
			--> INSERT UPDATE DELETE DATA THROUGH VIEW <--
--========================================================================

-- INSERT DATA THROUGH VIEW
INSERT INTO v_Products (ProductName,Price,Quantity) VALUES
('[Dubai Cherry Georgette Burqa]',1450,35)
SELECT * FROM v_Products
GO

-- UPDATE DATA THROUGH VIEW
UPDATE v_Products
SET ProductName= '[Double Georgette Printed Hijab]' , Price='220'
WHERE ProductId=106
GO
SELECT * FROM v_Products
GO

-- DELETE DATA THROUGH VIEW
DELETE FROM v_Products
WHERE ProductId=107
GO
SELECT * FROM v_Products
GO
--============================ / SECTION 04 \ ==============================
		---> INSERT UPDATE DELETE DATA THROUGH STORED PROCEDURE <---
--========================================================================
--TEST to INSERT
EXEC sp_insertColor 'Violate'
GO

SELECT * FROM productColor
GO

--TEST to UPDATE
EXEC sp_Product 102,'[Double Georgette Printed Burqa]',20,1100
GO
SELECT * FROM Products
GO

--TEST to DELETE
EXEC sp_ProductDelete 100
GO
SELECT * FROM Products
GO

--========> TEST STORED PROCEDURE with Output Parameter <======--
DECLARE @Id INT
EXEC sp_iNSERTProductWithOutput 102,'[Double Georgette Printed Burqa]',20,1100,@Id OUTPUT
PRINT 'The New Product Id is: ' +STR(@Id)
GO
SELECT * FROM Products
GO
--============================ / SECTION 05 \ ==============================
				 --> RETREIVE DATA USING FUNCTION <--
--========================================================================

-- A Scalar Function to get Sales Per Day
SELECT dbo.fn_salesPerDay(06,01) 'Sales_Per_Day'
GO

-- A Inline table valued function to get Total Sales in a Month
SELECT * FROM fn_SalesOfMonth(2025,01)
GO

-- A Multi-Statement Table valued function to get Profit
SELECT * FROM dbo.fn_Profit(100)
GO

--============================ /SECTION 06\ ============================
						   ---> TEST TRIGGER <---
--========================================================================

----> TEST FOR/AFTER TRIGGER
INSERT INTO Payment(PaymentTypeId,ProductId,Quantity,UnitPrice,Discount,Date,salesId) VALUES
(2,103,4,500,0.05,'2025-02-03',1)
SELECT * FROM Payment
SELECT * FROM Sales
GO

---->TEST INSTEAD OF TIGGER
SELECT * FROM Products
GO

--============================ / SECTION 07 \ ==============================
							  ---> QUERY <---
--========================================================================

--====7.01 A SELECT STATEMENT TO KNOW ABOUT PRODUCTS FROM A TABLE ======--
SELECT * FROM Products
GO

--============== 7.02 A SELECT STATEMENT TO KNOW ABOUT PROIT FROM A VIEW  ============--

SELECT * FROM v_profit
GO


--============== 7.03 A SELECT INTO STATEMENT ============--

SELECT *  INTO #PaymentTypeInfo
FROM PaymentType
GO

SELECT * FROM #PaymentTypeInfo
GO

--============== 7.04 IMPLICIT JOIN WITH TOP CLAUSE, ORDER BY CLAUSE ============--

SELECT TOP 5 p.ProductId,p.ProductName,c.CustomerName,pt.NetAmount FROM Payment pt
JOIN Products p ON p.ProductId=pt.ProductId
JOIN Orders O ON O.ProductId=p.ProductId
JOIN Customer c ON C.CustomerId=o.CustomerId
ORDER BY pt.NetAmount DESC

--============== 7.05 INNER JOIN WITH WITH WHERE BY CLAUSE ============--

-- TO KNOW PRODUCT WHICH COLOR IS GREY AND PRICE IS GREATER THAN 1000

SELECT * FROM Products p
INNER JOIN productDetails pd ON p.ProductId=pd.ProductId
INNER JOIN productColor pc ON pc.ColorId=pd.ColorId
WHERE Color='Grey' AND Price>1000
GO


--============== 7.06 OUTER JOIN ============--

SELECT * FROM Products p
LEFT JOIN productDetails pd ON p.ProductId=pd.ProductId
RIGHT JOIN productColor pc ON pc.ColorId=pd.ColorId
GO

--============== 7.07 CROSS JOIN ============--

SELECT * FROM productColor 
CROSS JOIN productSize 
GO

--============== 7.08 TOP CLAUSE WITH TIES ============--

SELECT TOP 5 WITH TIES p.ProductId,p.ProductName,c.CustomerName,pt.NetAmount 
FROM Payment pt
JOIN Products p ON p.ProductId=pt.ProductId
JOIN Orders O ON O.ProductId=p.ProductId
JOIN Customer c ON C.CustomerId=o.CustomerId
ORDER BY pt.NetAmount 
GO

--============== 7.09 DISTINCT ============--

SELECT DISTINCT p.ProductId,v.ProductName,NetAmount,Profit  FROM v_profit v
JOIN Payment P ON v.ProductId=p.ProductId
ORDER BY NetAmount
GO

--============== 7.10 COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR ============--

SELECT * FROM v_profit v
JOIN Payment P ON v.ProductId=p.ProductId
WHERE p.ProductId=104
AND Date BETWEEN '2025-01-01' AND '2025-01-06'
AND NOT PaymentId=3
AND Quantity>2
OR NetAmount>500
GO

--============== 7.11 LIKE, IN, NOT IN, OPERATOR & IS NULL/IS NOT NULL CLAUSE ============--

SELECT * FROM Customer c
WHERE CustomerName LIKE 'S%'
AND [Address] NOT IN ('Mirpur 2')
AND Email IS NOT NULL
GO

--============== 7.12 OFFSET FETCH ============--

-- OFFSET 3 ROWS

SELECT * FROM Products
ORDER BY Price
OFFSET 3 ROWS
GO

-- OFFSET 5 ROWS AND GET NEXT 5 ROWS

SELECT * FROM productColor
ORDER BY Color
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY
GO

--============== 7.13 UNION ============--

SELECT * FROM productDetails
WHERE SizeId IN (1,3)

UNION

SELECT * FROM productDetails
WHERE SizeId IN (1,4)
GO

--============== 7.14 EXCEPT INTERSECT ============--

-- EXCEPT

SELECT * FROM Payment

EXCEPT

SELECT * FROM Payment
WHERE ProductId=100
GO

--INTERSECT

SELECT * FROM Payment

INTERSECT

SELECT * FROM Payment
WHERE ProductId=100
GO

--============== 7.15 AGGREGATE FUNCTION ============--

SELECT SUM(UnitPrice*Quantity) 'Total Sales',
	   SUM(UnitPrice*Quantity*Discount) 'Total Discount',
	   SUM(UnitPrice*Quantity*(1-Discount)) 'Net Sales'
FROM Payment
GO

--============== 7.16 AGGREGATE FUNCTION WITH GROUP BY & HAVING CLAUSE ============--

SELECT ProductId,paymentTypeId,
	SUM(UnitPrice*Quantity) 'Total Sales',
	SUM(UnitPrice*Quantity*Discount) 'Total Discount',
	SUM(UnitPrice*Quantity*(1-Discount)) 'Net Sales'
FROM Payment
GROUP BY ProductId,paymentTypeId
HAVING 'Net Sales'>'1000'
GO

--============== 7.17 ROLLUP & CUBE OPERATOR ============--

--ROLLUP
SELECT ProductId,paymentTypeId,
	SUM(UnitPrice*Quantity) 'Total Sales',
	SUM(UnitPrice*Quantity*Discount) 'Total Discount',
	SUM(UnitPrice*Quantity*(1-Discount)) 'Net Sales'
FROM Payment
GROUP BY ROLLUP(ProductId,paymentTypeId)
GO
-- CUBE
SELECT ProductId,paymentTypeId,
	SUM(UnitPrice*Quantity) 'Total Sales',
	SUM(UnitPrice*Quantity*Discount) 'Total Discount',
	SUM(UnitPrice*Quantity*(1-Discount)) 'Net Sales'
FROM Payment
GROUP BY  CUBE(ProductId,paymentTypeId)
GO

--============== 7.18 GROUPING SETS ============--

SELECT ProductId,paymentTypeId,
	SUM(UnitPrice*Quantity) 'Total Sales',
	SUM(UnitPrice*Quantity*Discount) 'Total Discount',
	SUM(UnitPrice*Quantity*(1-Discount)) 'Net Sales'
FROM Payment
GROUP BY  GROUPING SETS(ProductId,paymentTypeId)
GO

--============== 7.19 SUB-QUERIES============--


--A SUBQUERY TO QUERY THOSE CUSTOMERS WHO HAVE NOT ORDER PRODUCTS

SELECT * FROM Customer 
WHERE CustomerId NOT IN (SELECT CustomerId FROM Orders)
GO

-- A CORRELATED-QUERY

SELECT pc.Color,
       (
           SELECT SUM(p.Quantity)
           FROM Payment p
           JOIN Products pr ON p.ProductId = pr.ProductId
		   JOIN productDetails pd ON pd.ProductId = pr.ProductId
           WHERE pd.ColorId = pc.ColorId
       ) AS TotalQuantitySold
FROM productColor pc
GO

--============== 7.20 EXISTS ============--

IF EXISTS(SELECT * FROM Orders WHERE CustomerId=3)
	PRINT 'Available'
ELSE
	PRINT 'Not Available'
GO



--============== 7.21 CTE ============--

-- A CTE TO GET MAXIMUM FISH SALES

WITH cte AS
(
	SELECT ProductId, SUM(NetAmount) 'Total'
	FROM Payment
	GROUP BY ProductId
)
SELECT p.ProductId,p.ProductName,cte.Total FROM Products p
INNER JOIN cte ON cte.ProductId=p.ProductId
WHERE cte.Total>2000
GO



--============== 7.22 BUILT IN FUNCTION ============--

-- Get current date and time

SELECT GETDATE()
GO

-- GET STRING LENGTH

SELECT CustomerId,CustomerName, LEN(CustomerName) 'Name Length' FROM Customer
GO

-- CONVERT DATA USING CAST()

SELECT CAST('2025-01-06' AS DATETIME) 'DATE'
GO

-- CONVERT DATA USING CONVERT()

SELECT CONVERT(VARCHAR,CAST('2025-01-06' AS DATETIME) ,100)
GO

-- CONVERT DATA USING TRY_CONVERT()
SELECT CustomerId,CustomerName,TRY_CONVERT(INT,CustomerName ,1)AS NULL_VALUE  FROM Customer
GO

-- GET DIFFERENCE OF DATES

SELECT  DATEDIFF(DAY,'2025-01-06','2025-03-31')AS DATEDIFF
GO

-- GET A MONTH NAME

SELECT  DATEDIFF(MONTH,'2025-01-06',GETDATE())AS MONTHDATEDIFF
GO

--============== 7.23 CASE ============--

SELECT CustomerId,CustomerName, Address,
CASE 
	WHEN Address IS NULL THEN 'Mirpur 1'
	ELSE Address
END AS 'Address'
FROM Customer
GO

--============== 7.24 IIF ============--

SELECT ProductId,SUM(Price),
IIF (SUM(Price)>1000,'HIGH','LOW') 'Price'
FROM Products
GROUP BY ProductId
GO

--============== 7.25 COALESCE & ISNULL ============--

SELECT PaymentId,SalesId, COALESCE(CONVERT(VARCHAR,SalesId),'NA') 'SalesId' FROM Payment
GO

SELECT PaymentId,SalesId, ISNULL(SalesId,2) 'SalesId' FROM Payment
GO

--============== 7.26 WHILE ============--

	DECLARE @counter int
	SET @counter = 0

	WHILE @counter < 20

	BEGIN
	  SET @counter = @counter + 1
	  INSERT INTO Rating(RatingId, Rate) VALUES((NEXT VALUE FOR [dbo].seqNum), NULL)
	END

	SELECT * FROM Rating
GO

--============== 7.28 RANKING FUNCTION ============--

SELECT PaymentId,p.ProductId,p.ProductName,
	RANK() OVER(ORDER BY p.ProductId) AS 'Rank',
	DENSE_RANK() OVER(ORDER BY p.ProductId) AS 'Dense_Rank',
	NTILE(3) OVER(ORDER BY p.ProductId) AS 'NTILE'
FROM Payment pay
JOIN Products  p ON p.ProductId=pay.ProductId
GO

--============== 7.29 IF ELSE & PRINT ============--

DECLARE @Per_Day_Sales MONEY
SELECT @Per_Day_Sales=SUM(NetAmount) FROM Payment
WHERE Date=GETDATE()
IF @Per_Day_Sales > '5000'
	BEGIN
		PRINT 'Great !!!'
	END
ELSE
	BEGIN
		PRINT 'We need to work hard!'
	END
GO

--============== 7.30 TRY CATCH ============--

BEGIN TRY
    INSERT INTO Sales 
    VALUES (105,8,1,0,0,'2025-01-05')

    PRINT 'Insert successful.'
END TRY
BEGIN CATCH
    -- Error handling
    PRINT 'Price can not be 0:'
    PRINT ERROR_MESSAGE()
END CATCH
GO
SELECT * FROM Sales
GO

--============== 7.31 GOTO ============--

DECLARE @quantity INT
SELECT @quantity=Quantity FROM Products

IF @quantity>=4
	GOTO A
IF @quantity<4
	GOTO B
A:
	PRINT 'GIVE 0.05 DISCOUNT'
	PRINT 'THANK YOU FOR PURCHASE!!'
	RETURN

B:
	PRINT 'THANK YOU FOR PURCHASE!!'
	RETURN
GO

--============== 7.32 WAITFOR ============--

SELECT GETDATE() CurrentTime
WAITFOR DELAY '00:00:05'
SELECT GETDATE() CurrentTime
GO

--============== 7.33 SYSTEM STORED PROCEDURE(sp_helptext) TO GET UNENCRYPTED STORED PROCEDURE SCRIPT  ============--

EXEC sp_helptext sp_ProductDelete
GO

--============== 7.34 TRANSACTION WITH SAVE POINT  ============--

BEGIN TRANSACTION
	BEGIN TRY
		UPDATE Stocks SET Stock=Stock-10
		WHERE ProductId=102

		UPDATE Products SET Quantity=Quantity+10
		WHERE ProductId=102
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		RAISERROR('Insufficient Stock!!!',1,1)
		ROLLBACK TRANSACTION
	END CATCH
GO

--============== 7.35 CREATE A MERGE =============--

MERGE Stocks AS tgt
USING (
    SELECT ProductId, SUM(Quantity) AS TotalOrdered
    FROM Orders
    GROUP BY ProductId
) AS src
ON tgt.ProductId = src.ProductId

WHEN MATCHED THEN
    UPDATE 
    SET 
        Stock = CASE 
                   WHEN tgt.Stock - src.TotalOrdered > 0 
                   THEN tgt.Stock - src.TotalOrdered 
                   ELSE 1  -- fallback to minimum valid value
               END,
        Date = GETDATE()

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductId, Stock, Cost, Date)
    VALUES (
        src.ProductId,
        CASE 
            WHEN 0 - src.TotalOrdered > 0 THEN 0 - src.TotalOrdered ELSE 1 
        END,
        0,
        GETDATE()
    );
GO
SELECT * FROM Products 
SELECT * FROM Stocks
GO