--use database
USE OnlineRetailDB;
GO

--implementing index 
--it helps in optimizing performance specially for read-heavy opeations like SELECT query

--lets create index for OnlineRetailDB

--A. INDEX on Categories table
--------------------------------------

--1. CLUSTERED INDEX for CategoryId
--> Already created when we defined PRIMARY KEY
CREATE CLUSTERED INDEX Idx_Categories_CategoryId
ON Categories(CategoryId);
GO




--B. INDEX for Products table
----------------------------------


--1.CLUSTERED INDEX  for ProductId

--to create a clustered index we need to delete the clustered index
--the column related to the clustered index has foreign key reference
--so we need to remove the foreign key reference first

--drop foreign key constraint from OrderItems table (ProductId)
ALTER TABLE OrderItems DROP CONSTRAINT FK__OrderItem__Produ__5DCAEF64;

CREATE CLUSTERED INDEX Idx_Products_ProductId
ON Products(ProductId);
GO

--2. NONCLUSTERED INDEX for CategoryId: to speed up sorting and filtering by CategoryId
CREATE NONCLUSTERED INDEX Idx_Products_CategoryId
ON Products(CategoryId);
GO


--3. NONCLUSTERED INDEX for Price: to speed up sorting and filtering by Price
CREATE NONCLUSTERED INDEX Idx_Products_Price
ON Products(Price);
GO

--Recreate FOREIGN KEY Constrain on OrderItems (ProductId)
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_ProductId
FOREIGN KEY(ProductId) REFERENCES Products(ProductId);
GO




--C. INDEX on Orders table
-------------------------------

--1. CLUSTERED INDEX on OrderId

--drop foreign key constraint from OrderItems table (OrderId)
ALTER TABLE OrderItems DROP CONSTRAINT FK__OrderItem__Order__5EBF139D;

CREATE CLUSTERED INDEX Idx_Orders_OrderId
ON Orders(OrderId);
GO


--2. NONCLUSTERED INDEX on CustomerId
CREATE NONCLUSTERED INDEX Idx_Orders_CustomerId
ON Orders(CustomerId);
GO


--3. NONCLUSTERED INDEX on OrderDate
CREATE NONCLUSTERED INDEX Idx_Orders_OrderDate
ON Orders(OrderDate);
GO

--recreate foreign ke constraint for OrderItems table (OrderId)
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItem_Orders
FOREIGN KEY (OrderId) REFERENCES Orders(OrderId);
GO


--D. INDEX on OrderItems table
-------------------------------

--1. CLUSTERED INDEX on OrderId
CREATE CLUSTERED INDEX Idx_OrderItems_OrderItemId
ON OrderItems(OrderItemId);
GO


--2. NONCLUSTERED INDEX on OrderId
CREATE NONCLUSTERED INDEX Idx_OrderItems_OrderId
ON OrderItems(OrderId);
GO


--3. NONCLUSTERED INDEX on ProductId
CREATE NONCLUSTERED INDEX Idx_OrderItems_ProductId
ON OrderItems(ProductId);
GO


--E. INDEX on Customers table
-------------------------------

--1. CLUSTERED INDEX on CustomerId

--delete foreign ke reference from Orders table (CustomerId)
ALTER TABLE Orders DROP CONSTRAINT FK__Orders__Customer__5AEE82B9;

CREATE CLUSTERED INDEX Idx_Customers_CustomerId
ON Customers(CustomerId);
GO


--2. NONCLUSTERED INDEX on Email
CREATE NONCLUSTERED INDEX Idx_Customers_Email
ON Customers(Email);
GO


--3. NONCLUSTERED INDEX on Country
CREATE NONCLUSTERED INDEX Idx_Customers_Country
ON Customers(Country);
GO

--recreate foreign ke reference for Orders table (CustomerId)
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId);