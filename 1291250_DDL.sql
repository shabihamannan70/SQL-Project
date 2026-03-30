
/*
===================SQL Project Name : Boutique House Management System[BHMS]====================
							    
								Trainee Name	: Shabiha Mannan Era   
						    	  Trainee ID	: 1291250       
								    Batch ID	: CS/PNTL-A/67/01 
------------------------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: Created a Database With file details [BHMS]
			=> SECTION 02: Created Appropriate Tables with column definition related to the project
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
			=> SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
			=> SECTION 06: CREATE A VIEW & ALTER VIEW
			=> SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			=> SECTION 08: CREATE FUNCTION(SCALAR, INLINE TABLE VALUED, MULTI-STATEMENT TABLE VALUED FUNCTION) & ALTER FUNCTION
			=> SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER)
			=> SECTION 10: CREATE TRIGGER (INSTEAD OF TRIGGER)
*/


--======================== / SECTION 01 \ ========================
	             --/ CREATE DATABASE WITH ATTRIBUTES \--
--================================================================
USE master
GO

-- Check if the database already exists and drop it if it does
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'BHMS_data')
DROP DATABASE BHMS
GO

-- Create the new BHMS with FileStream, and Log filegroups
CREATE DATABASE BHMS
ON
(
	name = 'BHMS_data',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BHMS_data.mdf',
	size = 25MB,
	maxsize = 100MB,
	filegrowth = 5%
)
LOG ON
(
	name = 'BHMS_log',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BHMS_log.ldf',
	size = 2MB,
	maxsize = 50MB,
	filegrowth = 1MB
)
GO

USE BHMS
GO



--============================= / SECTION 02 \ ============================== 
	--/Created Appropriate Tables with column definition related to the project\
--===============================================================================


-----------> Table with IDENTITY, PRIMARY KEY & nullability CONSTRAINT <------------

CREATE TABLE Products
(
	ProductId INT IDENTITY(100,1) PRIMARY KEY,
	ProductName NVARCHAR (50) NOT NULL,
	Quantity INT DEFAULT 0,
	Price MONEY
)
GO

CREATE TABLE Stocks
(
	StockId INT IDENTITY PRIMARY KEY,
	ProductId INT REFERENCES Products(ProductId),
	Stock int NOT NULL,
	Cost MONEY,
	Total AS Stock*cost,--Compiled column
	Date DATE
)
GO

CREATE TABLE productSize
(
	SizeId INT IDENTITY PRIMARY KEY,
	Size VARCHAR(15)
)
GO

CREATE TABLE productColor
(
	ColorId INT IDENTITY PRIMARY KEY,
	Color VARCHAR(10)
)
GO
----------------------Table with Composite Primary Key -------------------
CREATE TABLE productDetails
(
	ProductDetailId INT IDENTITY,
	ProductId INT REFERENCES Products(ProductId),
	SizeId INT REFERENCES productSize(SizeId),
	ColorId INT REFERENCES productColor(ColorId), 
	PRIMARY KEY (ProductDetailId,ProductId,SizeId,ColorId)
)
GO

CREATE TABLE Customer
(
	CustomerId INT IDENTITY PRIMARY KEY,
	CustomerName NVARCHAR (30) NULL,
	ContactNo VARCHAR(20) NOT NULL UNIQUE CHECK(ContactNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Email VARCHAR(30) UNIQUE CONSTRAINT ck_emailCheck CHECK (Email LIKE '%@%'),
	[Address] VARCHAR(100) Null
)
GO

CREATE TABLE Orders
(
	OrderId INT IDENTITY PRIMARY KEY,
	ProductId INT REFERENCES Products(ProductId),
	Quantity INT NOT NULL DEFAULT 1,
	OrderDate DATE DEFAULT GETDATE(),
	CustomerId INT REFERENCES Customer(CustomerId)
)
GO

CREATE TABLE PaymentType
(
	PaymentTypeId INT IDENTITY PRIMARY KEY,
	Types VARCHAR(15)
)
GO

CREATE TABLE Payment
(
	PaymentId INT IDENTITY PRIMARY KEY,
	PaymentTypeId INT REFERENCES PaymentType(PaymentTypeId),
	ProductId INT REFERENCES Products(ProductId),
	Quantity INT DEFAULT 1,
	UnitPrice MONEY,
	Amount AS Quantity*UnitPrice, 
	Discount float,
	NetAmount AS Quantity*UnitPrice*(1-Discount),
	Date DATE DEFAULT GETDATE()
)
GO

CREATE TABLE Rating
(
	RatingId INT,
	RATE INT
)
GO

CREATE TABLE Sales
(
	salesId INT IDENTITY PRIMARY KEY,
	ProductId INT REFERENCES Products(ProductId),
	PaymentId INT REFERENCES Payment(PaymentId),
	soldQuantity int,
	Price MONEY CHECK (Price>0),
	Discount FLOAT DEFAULT 0.00,
	Date DATETIME DEFAULT GETDATE()
)
GO

--============== / CREATE A SCHEMA \ ============--
CREATE SCHEMA bhs
GO
--============== / USE SCHEMA IN A TABLE \ ============--
CREATE TABLE bhs.productColorInfo
(
	ColorId INT IDENTITY ,
	Color VARCHAR(10)
)
GO


--========================= / SECTION 03 \ ==========================
		      --> ALTER, DROP AND MODIFY TABLES & COLUMNS <--
--===================================================================


--============== ALTER TABLE SCHEMA AND TRANSFER TO [dbo] ============--

ALTER SCHEMA dbo TRANSFER bhs.productColorInfo
Go


--============== Update column definition ============--

ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(50) NOT NULL
GO

--==============> ADD CHECK CONSTRAINT with defining name <============--

ALTER TABLE Stocks
ADD CONSTRAINT CK_Date CHECK(Date>'2024-12-02')
GO
ALTER TABLE Stocks
ADD CONSTRAINT CK_stock CHECK(stock>0)
GO

--==============> DROP COLUMN <============--

ALTER TABLE productColorInfo
DROP COLUMN Color
GO

ALTER TABLE payment
ADD salesId INT REFERENCES sales 
GO
--==============> DROP CHECK CONSTRAINT <==============--

ALTER TABLE Stocks
DROP CONSTRAINT [CK_Date]
GO

--==============> DROP TABLE <============--

DROP TABLE productColorInfo
GO

--==============> DROP SCHEMA <============--
DROP SCHEMA bhs
GO


--============================== / SECTION 04 \ ==========================
		       --> CREATE CLUSTERED AND NONCLUSTERED INDEX <--
--========================================================================


--================> Clustered Index <================--

CREATE CLUSTERED INDEX IX_color
ON bhs.productColorInfo
(
	colorId
)
GO

-- Nonclustered Index
CREATE  NONCLUSTERED INDEX IX_CustomerName
ON Customer
(
	CustomerName
)
GO

--========================= / SECTION 05 \ ==============================
				        --> CREATE SEQUENCE <--
--========================================================================

CREATE SEQUENCE seqNum
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 100
	CYCLE
	CACHE 20
GO

--==============> ALTER SEQUENCE <============--

ALTER SEQUENCE seqNum
	MAXVALUE 200
	CYCLE
	CACHE 10
GO

--============================ / SECTION 06 \ ==============================
					       --> CREATE A VIEW <--
--========================================================================

CREATE VIEW v_Products
AS
SELECT ProductId,ProductName,Price,Quantity FROM Products
GO

CREATE VIEW v_orders
AS
SELECT * FROM Orders
GO

----> VIEW WITH ENCRYPTION, SCHEMABINDING & WITH CHECK OPTION <---

CREATE VIEW v_profit
WITH SCHEMABINDING, ENCRYPTION
AS
SELECT p.ProductId,p.ProductName,((sum(NetAmount))-(sum(s.Cost*pay.Quantity))) AS Profit FROM dbo.Products p
INNER JOIN dbo.Payment pay ON p.ProductId=pay.ProductId
INNER JOIN dbo.Stocks s ON s.ProductId=pay.ProductId 
GROUP BY p.ProductId,p.ProductName
GO

--==============> ALTER VIEW <============--
ALTER VIEW v_orders
AS
SELECT OrderId,ProductId,Quantity FROM Orders
GO
--============================ / SECTION 07 \ ===========================
						---> STORED PROCEDURE <---
--========================================================================

--=======> STORED PROCEDURE for insert data using parameter <========--

CREATE PROC sp_insertColor @color VARCHAR(20)
AS
INSERT INTO productColor(Color) VALUES (@color)
GO

--=======> STORED PROCEDURE for update data using parameter <========--

CREATE PROC sp_Product @productId int,
					   @productName VARCHAR(50),
					   @quantity INT,
					   @price MONEY
AS 
UPDATE Products SET 
ProductName=@productName,Quantity=@quantity,Price=@price
WHERE ProductId=@productId
GO

--=======> STORED PROCEDURE for Delete data <========--

CREATE PROC sp_ProductDelete @productId INT
AS
DELETE FROM Products WHERE ProductId=@productId
GO

--=====> STORED PROCEDURE for insert data with OUTPUT parameter <=====--

CREATE PROC sp_iNSERTProductWithOutput @productId int,
					                   @productName VARCHAR(50),
					                   @quantity INT,
					                   @price MONEY,
					                   @Id INT OUTPUT
AS					                   
INSERT INTO Products(ProductName,Quantity,Price) VALUES
(@productName,@quantity,@price)
SELECT @Id=IDENT_CURRENT('Products')
GO
--=====> ALTER STORED PROCEDURE <====--

ALTER PROC sp_insertColor @color VARCHAR(30)
AS
INSERT INTO productColor(Color) VALUES (@color)
GO
--============================ / SECTION 08 \ ===========================
						      --> FUNCTION <--
--========================================================================

--==============> A SCALAR FUNCTION <============--

CREATE FUNCTION fn_salesPerDay(@day INT,@month INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @salesPerDay MONEY
	SELECT @salesPerDay= SUM(UnitPrice*Quantity*(1-Discount))
	FROM Payment
	WHERE day(date)=@day AND MONTH(date)=@month
	RETURN @salesPerDay 
END
GO


--======> Inline table valued function <======

CREATE FUNCTION fn_SalesOfMonth(@year INT,@month INT)
RETURNS TABLE
AS
RETURN
(
	SELECT 
	SUM(UnitPrice*Quantity) 'Total Sales',
	SUM(UnitPrice*Quantity*Discount) 'Total Discount',
	SUM(UnitPrice*Quantity*(1-Discount)) 'Net Sales'
	FROM Payment
	WHERE YEAR(date)=@year AND MONTH(date)=@month
)
GO

--======> Multi-Statement Table valued function <======--

CREATE FUNCTION fn_Profit (@ProductId int)
RETURNS @profit TABLE
(
	productName VARCHAR(100),
	profitAmount MONEY,
	profitPercent FLOAT
	
)
AS
BEGIN
	INSERT INTO @profit(productName,profitAmount,profitPercent)
	SELECT ProductName,SUM(NetAmount-Cost*P.Quantity),
	SUM((NetAmount-Cost*P.Quantity)/Cost*P.Quantity)
	FROM Payment p
	JOIN Stocks s ON p.ProductId=s.ProductId
	JOIN Products ps ON ps.ProductId=s.ProductId
	WHERE ps.ProductId=@ProductId
	GROUP BY ps.ProductName
	RETURN
END
GO

--==============> ALTER FUNCTION <============--

ALTER FUNCTION fn_SalesOfMonth(@day INT,@month INT)
RETURNS TABLE
AS
RETURN
(
	SELECT 
	SUM(UnitPrice*Quantity) 'Total Sales',
	SUM(UnitPrice*Quantity*Discount) 'Total Discount',
	SUM(UnitPrice*Quantity*(1-Discount)) 'Net Sales'
	FROM Payment
	WHERE DAY(date)=@day AND MONTH(date)=@month
)
GO
SELECT * FROM fn_SalesOfMonth(06,01)
GO

--============================ / SECTION 09 \ ===========================
					    ---> FOR/AFTER TRIGGER <---
--========================================================================

CREATE TRIGGER tr_payWiseStock
ON Payment
FOR INSERT
AS
BEGIN
	DECLARE @i INT, --for salesId
			@q INT,--for Quantity
			@ProductId INT,
			@PaymentId INT,
			@netAmount MONEY,
			@discount FLOAT,
			@date DATE
	SELECT @i=salesId,@q=Quantity,@ProductId=ProductId,@PaymentId=PaymentId,@netAmount=NetAmount,@discount=Discount,@date=Date FROM inserted

	UPDATE Sales SET ProductId=@ProductId,PaymentId=@PaymentId,soldQuantity=soldQuantity+@q,price=@netAmount,Discount=@discount,Date=@date
	WHERE salesId=@i
END
GO

--============ AN AFTER/FOR TRIGGER FOR INSERT, UPDATE, DELETE ============--

--> Create trigger on Layer table For update and Delete with Rollback Transaction

CREATE TRIGGER tr_ProductDetails
ON ProductDetails
FOR UPDATE,DELETE
AS
BEGIN
	PRINT 'Update or Delete Not Possible!!!'
	ROLLBACK TRANSACTION
END
GO

--============================ / SECTION 10 \ =====================
					  ---> INSTEAD OF TRIGGER <---
--=================================================================

--============== AN INSTEAD OF TRIGGER ON VIEW ============--

CREATE TRIGGER tr_insertProduct
ON v_Products
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Products(ProductName,Price,Quantity)
	SELECT ProductName,Price,Quantity FROM inserted
END 
GO
INSERT INTO v_Products(ProductId,ProductName,Price,Quantity)
VALUES(105,'[Stoned Work Burqa]',2200,10)
GO













