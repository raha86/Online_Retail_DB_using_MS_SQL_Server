--use the database
USE OnlineRetailDB;
GO

--Q1: Retrieve all orders from a specific customer
SELECT o.OrderId, o.OrderDate, o.TotalAmount, oi.ProductId, p.ProductName, oi.Quantity, oi.Price
FROM Orders o 
JOIN OrderItems oi ON o.OrderId = oi.OrderId
JOIN Products p ON p.ProductId = oi.ProductId 
WHERE o.CustomerId = 1;


--Q2: Find the total sales for each product
SELECT p.ProductId, p.ProductName, SUM(Quantity) as TotalQtySold, p.Price, SUM(oi.Quantity * oi.Price) AS TotalSalesAmount
FROM Products p
JOIN OrderItems oi ON p.ProductId = oi.ProductId
GROUP BY p.ProductId, p.ProductName, p.Price
ORDER BY TotalSalesAmount DESC;


--Q3: Calculate the average order value
SELECT CAST(AVG(TotalAmount) AS DECIMAL (10, 2)) AS AverageOrderValue FROM Orders;


--Q4: List the top 5 customers by total spending
SELECT CustomerId, FirstName, LastName, TotalSpending
FROM
(
	SELECT c.CustomerId, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending, 
	ROW_NUMBER() OVER(ORDER BY SUM(o.TotalAmount) DESC) row_num
	FROM Customers c
	JOIN Orders o ON c.CustomerId = o.CustomerId 
	GROUP BY c.CustomerId, c.FirstName, c.LastName 
) subQuery
WHERE row_num <= 5;


--Q5: Retrieve the most popular product category
SELECT CategoryId, CategoryName, TotalQtySold 
FROM (
	SELECT p.CategoryId, c.CategoryName, SUM(oi.Quantity) AS TotalQtySold,
	DENSE_RANK() OVER (ORDER BY SUM(oi.Quantity) DESC) popularity_rank
	FROM Products p
	JOIN Categories c ON p.CategoryId = c.CategoryId 
	JOIN OrderItems oi ON p.ProductId = oi.ProductId
	GROUP BY p.CategoryId, c.CategoryName
) subQuery
WHERE popularity_rank = 1;


--Q6: List all the products that are out of stock
SELECT p.ProductId, p.ProductName, p.CategoryId, c.CategoryName, p.Stock
FROM Products p
JOIN Categories c ON p.CategoryId = c.CategoryId
WHERE Stock = 0;


--Q7: Find customers who placed orders in the last 30 days
SELECT c.CustomerId, c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerId = o.CustomerId
WHERE o.OrderDate >= DATEADD(DAY, -30, GETDATE());


--Q8: Calculate the total number of orders placed each month
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, COUNT(OrderId) as TotalOrders
FROM Orders 
GROUP BY YEAR(OrderDate), MONTH(OrderDate);


--Q9: Retrieve the details of the most recent order
-- to show more than one orders placed at the same time
SELECT o.OrderId, o.CustomerId, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount 
FROM Orders o
JOIN Customers c ON o.CustomerId = c.CustomerId
WHERE OrderDate = (SELECT MAX(OrderDate) FROM Orders);

--to show only one recent order
SELECT TOP 1 o.OrderId, o.CustomerId, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount 
FROM Orders o
JOIN Customers c ON o.CustomerId = c.CustomerId
ORDER BY o.OrderDate DESC;


--10: Find the average price of products in each category
SELECT c.CategoryId, c.CategoryName, CAST(AVG(p.Price) AS DECIMAL(10, 2)) AS AveragePrice
FROM Products p
JOIN Categories c ON p.CategoryId = c.CategoryId 
GROUP BY c.CategoryId, c.CategoryName;


--Q11: Select customers who have never placed an order
SELECT CustomerId, FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country 
FROM Customers WHERE CustomerId NOT IN (
	SELECT DISTINCT CustomerId FROM Orders
);

--OR
SELECT c.CustomerId, c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
LEFT JOIN Orders o ON c.Customerid = o.CustomerId 
WHERE OrderId IS NULL;


--Q12: Retrieve the total quantity sold for each product
SELECT p.ProductId, p.ProductName, COUNT(oi.Quantity) AS QtySold
FROM Products p
JOIN OrderItems oi ON p.ProductId = oi.OrderId 
GROUP BY p.ProductId, p.ProductName;


--Q13: Calculate the total revenue generated from each category
SELECT p.CategoryId, c.CategoryName, SUM(oi.Quantity * oi.Price) AS TotalRevenueGenerated
FROM OrderItems oi
JOIN Products p ON p.ProductId = oi.ProductId 
JOIN Categories c ON c.CategoryId = p.CategoryId
GROUP BY p.CategoryId, c.CategoryName;


--Q14: Find the highest priced product in each category
SELECT s.CategoryId, c.CategoryName, s.ProductId, s.ProductName, s.Price FROM(
	SELECT ProductId, ProductName, CategoryId,  Price, 
	DENSE_RANK() OVER(PARTITION BY CategoryId ORDER BY Price DESC) Price_rank
	FROM Products
) s
JOIN Categories c ON s.CategoryId = c.CategoryId
WHERE Price_rank = 1;


--Q15: Retrieve orders with a total amount greater than a specific value (i.e 500)
SELECT o.OrderId, o.CustomerId, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o 
JOIN Customers c ON o.CustomerId = c.CustomerId
WHERE o.TotalAmount > 500
ORDER BY o.TotalAmount DESC;


--Q16: List products along with the number of orders they appear in
SELECT p.ProductId, p.ProductName, COUNT(oi.OrderId) as AppearedInOrder
FROM Products p
JOIN OrderItems oi ON p.ProductId = oi.ProductId
GROUP BY p.ProductId, p.ProductName
ORDER BY AppearedInOrder DESC;


--Q17: Find the top 3 frequently ordered products
SELECT TOP 3 p.ProductId, p.ProductName, COUNT(oi.OrderId) as OrderCount
FROM Products p
JOIN OrderItems oi ON p.ProductId = oi.ProductId
GROUP BY p.ProductId, p.ProductName
ORDER BY OrderCount DESC;


--Q18: Calculate total number of customers from each country
SELECT Country, COUNT(CustomerId) as CustomerCount
FROM Customers 
GROUP BY Country 
ORDER BY CustomerCount DESC;


--Q19: Retrieve the list of customers along with their total spending
SELECT c.CustomerId, c.FirstName, c.LastName, COALESCE(SUM(o.TotalAmount), 0) AS TotalSpending
FROM Customers c
LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY TotalSpending DESC;


--Q20: List orders with more than a specified number of items(e.g 5 items)
SELECT o.OrderId, c.CustomerId, c.FirstName, c.LastName, COUNT(oi.OrderItemId) AS NumberOfItems
FROM Orders o
JOIN CustomerS c ON c.CustomerId = o.CustomerId 
JOIN OrderItemS oi ON o.OrderId = oi.OrderId
GROUP BY o.OrderId, c.CustomerId, c.FirstName, c.LastName
ORDER BY NumberOfItems DESC;
