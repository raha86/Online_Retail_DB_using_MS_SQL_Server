--use the database
USE OnlineRetailDB;
GO

--We need to create additional queries to involve update, delete, insert and maintain log of these oprations in the OnlineRetailDB database

--To automatically log changes in the database we can use triggers

--We'll create a table to store logs
CREATE TABLE ChangeLog(
	LogId INT PRIMARY KEY IDENTITY(1, 1),
	TableName NVARCHAR(50),
	Operation NVARCHAR(10),
	RecordId INT,
	ChangeDate DATETIME DEFAULT GETDATE(),
	ChangedBy NVARCHAR(100)
);
GO

SELECT * FROM ChangeLog;

--A. Create TRIGGER for Product Table

--1. TRIGGER for INSERT
CREATE OR ALTER TRIGGER trg_Insert_Products
ON Products
AFTER INSERT 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Products', 'INSERT', inserted.ProductId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'INSERT operation logged for products table';
END;
GO
--try to insert one record into Products table
INSERT INTO Products (ProductName, CategoryId, Price, Stock)
VALUES
('Wireless Mouse', 1, 4.99, 20);

INSERT INTO Products (ProductName, CategoryId, Price, Stock)
VALUES
('Spiderman Multiverse Comic', 3, 2.50, 150);


--2. TRIGGER for UPDATE
CREATE OR ALTER TRIGGER trg_Update_Products
ON Products
AFTER UPDATE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Products', 'UPDATE', inserted.ProductId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'UPDATE operation logged for products table';
END;
GO

--try to update one record into Products table
UPDATE Products SET Price = Price - 300 WHERE ProductId = 2;


--3. TRIGGER for DELETE
CREATE OR ALTER TRIGGER trg_Delete_Products
ON Products
AFTER DELETE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Products', 'DELETE', deleted.ProductId, SYSTEM_USER
	FROM deleted;

	--Display a message indicating that the trigger has executed
	PRINT 'DELETE operation logged for products table';
END;
GO

--try to delete from Products
DELETE FROM Products WHERE ProductId=9;



--B. Create TRIGGER for Customers Table

--1.TRIGGER for INSERT

CREATE OR ALTER TRIGGER trg_Insert_Customers
ON Customers
AFTER INSERT 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Customers', 'INSERT', inserted.CustomerId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'INSERT operation logged for Customers table';
END;
GO


--2. TRIGGER for UPDATE
CREATE OR ALTER TRIGGER trg_Update_Customers
ON Customers
AFTER UPDATE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Customers', 'UPDATE', inserted.CustomerId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'UPDATE operation logged for Customers table';
END;
GO

--3. TRIGGER for DELETE
CREATE OR ALTER TRIGGER trg_Delete_Customers
ON Customers
AFTER DELETE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Customers', 'DELETE', deleted.CustomerId, SYSTEM_USER
	FROM deleted;

	--Display a message indicating that the trigger has executed
	PRINT 'DELETE operation logged for Customers table';
END;
GO


--C. Create TRIGGER for Categories Table

--1. TRIGGER for INSERT
CREATE OR ALTER TRIGGER trg_Insert_Categories
ON Categories
AFTER INSERT 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Categories', 'INSERT', inserted.CategoryId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'INSERT operation logged for Categories table';
END;
GO


--2. TRIGGER for UPDATE
CREATE OR ALTER TRIGGER trg_Update_Categories
ON Categories
AFTER UPDATE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Categories', 'UPDATE', inserted.CategoryId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'UPDATE operation logged for Categories table';
END;
GO


--3. TRIGGER for DELETE
CREATE OR ALTER TRIGGER trg_Delete_Categories
ON Categories
AFTER DELETE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Categories', 'DELETE', deleted.CategoryId, SYSTEM_USER
	FROM deleted;

	--Display a message indicating that the trigger has executed
	PRINT 'DELETE operation logged for Categories table';
END;
GO



--D. create TRIGGER for Orders table
--1. TRIGGER for INSERT
CREATE OR ALTER TRIGGER trg_Insert_Orders
ON Orders
AFTER INSERT 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Orders', 'INSERT', inserted.OrderId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'INSERT operation logged for Orders table';
END;
GO


--2. TRIGGER for UPDATE
CREATE OR ALTER TRIGGER trg_Update_Orders
ON Orders
AFTER UPDATE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Orders', 'UPDATE', inserted.OrderId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'UPDATE operation logged for Orders table';
END;
GO


--3. TRIGGER for DELETE
CREATE OR ALTER TRIGGER trg_Delete_Orders
ON Orders
AFTER DELETE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'Orders', 'DELETE', deleted.OrderId, SYSTEM_USER
	FROM deleted;

	--Display a message indicating that the trigger has executed
	PRINT 'DELETE operation logged for Orders table';
END;
GO


--E. create TRIGGER for OrderItems table
--1. TRIGGER for INSERT
CREATE OR ALTER TRIGGER trg_Insert_OrderItems
ON OrderItems
AFTER INSERT 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'OrderItems', 'INSERT', inserted.OrderItemId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'INSERT operation logged for OrderItems table';
END;
GO


--2. TRIGGER for UPDATE
CREATE OR ALTER TRIGGER trg_Update_OrderItems
ON OrderItems
AFTER UPDATE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'OrderItems', 'UPDATE', inserted.OrderItemId, SYSTEM_USER
	FROM inserted;

	--Display a message indicating that the trigger has executed
	PRINT 'UPDATE operation logged for OrderItems table';
END;
GO


--3. TRIGGER for DELETE
CREATE OR ALTER TRIGGER trg_Delete_OrderItems
ON OrderItems
AFTER DELETE 
AS
BEGIN
	--insert a log into the ChangeLog table
	INSERT INTO ChangeLog (TableName, Operation, RecordId, ChangedBy) 
	SELECT 'OrderItems', 'DELETE', deleted.OrderItemId, SYSTEM_USER
	FROM deleted;

	--Display a message indicating that the trigger has executed
	PRINT 'DELETE operation logged for OrderItems table';
END;
GO
