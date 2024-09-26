--use the database
USE OnlineRetailDB;

--implementing VIEW
----------------------
--view for Product details: view combining products details and category names
CREATE VIEW vw_ProductDetails AS
SELECT p.ProductId, p.ProductName, p.Price, p.Stock, c.CategoryName
FROM Products p INNER JOIN Categories c
ON p.CategoryId = c.CategoryId;
GO

--view for Custemore Orders: a view to get summary of orders placed by each customer
CREATE VIEW vw_CustomerOrders AS
SELECT c.CustomerId, c.FirstName, c.LastName, COUNT(o.OrderId) AS TotalOrders, 
SUM(oi.Quantity * p.Price) AS TotalAmount
From Customers C 
INNER JOIN Orders o ON c.CustomerId = o.CustomerId
INNER JOIN OrderItems oi ON o.OrderId = oi.OrderId
INNER JOIN Products p ON oi.ProductId = p.ProductId
GROUP BY c.CustomerId, c.FirstName, c.LastName;
GO

--view for Recent Orders: a view to display summary of each order
CREATE VIEW vw_RecentOrders AS
SELECT o.OrderId, o.OrderDate, c.CustomerId, c.FirstName, c.LastName,
SUM(oi.Quantity * oi.Price) AS OrderAmount
From Customers C 
INNER JOIN Orders o ON c.CustomerId = o.CustomerId
INNER JOIN OrderItems oi ON o.OrderId = oi.OrderId
GROUP BY o.OrderId, o.OrderDate, c.CustomerId, c.FirstName, c.LastName;
GO



