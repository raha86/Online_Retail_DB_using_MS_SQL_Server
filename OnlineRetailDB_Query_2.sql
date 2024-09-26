--Q21: Retrieve all product details with category name
SELECT * FROM vw_ProductDetails;

--Q22: Retrive Products within a specific price range i.e 300 and 800
SELECT * FROM vw_ProductDetails WHERE Price BETWEEN 300 AND 800;

--Q23: count the number of products in each category
SELECT CategoryName, COUNT(DISTINCT ProductId) as ProductCount
FROM vw_ProductDetails
GROUP BY CategoryName;

--Q24: Retrieve customers with more than 1 orders
SELECT CustomerId, FirstName, LastName, TotalOrders
FROM vw_CustomerOrders 
WHERE TotalOrders > 1;

--Q25: Retrieve the total amount spent by each customer
SELECT CustomerId, FirstName, LastName, TotalAmount 
FROM vw_CustomerOrders
ORDER BY TotalAmount DESC;

--Q26: Retrieve recent orders above a certain amount i.e 500
SELECT OrderId, OrderDate, CustomerId, FirstName, LastName, OrderAmount
FROM vw_RecentOrders 
WHERE OrderAmount > 500;

--Q27: Retrieve the latest order placed by each customer
SELECT ro.CustomerId, ro.FirstName, ro.LastName, ro.OrderId, ro.OrderDate, ro.OrderAmount 
FROM vw_RecentOrders ro
INNER JOIN
(SELECT CustomerId, MAX(OrderDate) as LatestOrderDate FROM vw_RecentOrders GROUP BY CustomerId)
latest
ON ro.CustomerId = latest.CustomerId AND ro.OrderDate = latest.LatestOrderDate;

--Q28: Retrieve products in a specific category i.e electronics
SELECT ProductId, ProductName, Price, Stock
FROM vw_ProductDetails
WHERE CategoryName = 'Electronics';

--Q29: Retrieve total sales for each category
SELECT pd.CategoryName, SUM(oi.Quantity * pd.Price) as TotalSales
FROM vw_ProductDetails pd
INNER JOIN OrderItems oi ON pd.ProductId = oi.ProductId
GROUP BY pd.CategoryName
ORDER BY TotalSales DESC;

--Q30: Retrieve customer orders with product details
SELECT c.CustomerId, c.FirstName, c.LastName, o.OrderDate, p.ProductId, p.ProductName, p.Price
FROM vw_CustomerOrders c
INNER JOIN Orders o ON c.CustomerId = o.CustomerId 
INNER JOIN OrderItems oi ON o.OrderId = oi.OrderId 
INNER JOIN vw_ProductDetails p ON oi.ProductId = p.ProductId;

--Q31: Retrieve top 5 customers by total spending
select CustomerId, FirstName, LastName, TotalAmount FROM (
	SELECT CustomerId, FirstName, LastName, TotalAmount, 
	RANK() OVER( ORDER BY TotalAmount DESC) AS SpendRank
	FROM vw_CustomerOrders 
) spend
WHERE SpendRank <=5;

--Q32: Retrieve prouct with low stock i.e < 10
SELECT * FROM vw_ProductDetails
WHERE Stock <= 20;

--Q33: Retrieve Orders placed in the last 7 days
SELECT * FROM vw_RecentOrders WHERE OrderDate >= DATEADD(DAY, -30, GETDATE());

--Q34: Retrieve products sold in the last month
SELECT p.ProductId, p.ProductName, ro.OrderDate, SUM(oi.Quantity) AS TotalSold
FROM Products p
INNER JOIN OrderItems oi ON oi.ProductId = p.ProductId
INNER JOIN vw_RecentOrders ro ON oi.OrderId = ro.OrderId 
WHERE MONTH(ro.OrderDate) = MONTH(DATEADD(MONTH, -1, GETDATE()))
AND ro.OrderDate >= DATEADD(YEAR, -1, GETDATE())
GROUP BY p.ProductId, p.ProductName, ro.OrderDate
ORDER BY TotalSold DESC;

