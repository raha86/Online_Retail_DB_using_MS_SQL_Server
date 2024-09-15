--use the database
USE OnlineRetailDB;
GO

--data insertion in the tables

--insert sample data into Categories Table
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Devices and Gadgets');
GO

INSERT INTO Categories (CategoryName, Description) VALUES
('Clothing', 'Apparel and accessories'),
('Books', 'Printed and Electronic books');
GO
SELECT * FROM Categories;

--insert sample data into Products Table
INSERT INTO Products (ProductName, CategoryId, Price, Stock) VALUES
('Smart Phone', 1, 699.99, 50);

INSERT INTO Products (ProductName, CategoryId, Price, Stock) VALUES
('Key Board', 1, 39.99, 0);

INSERT INTO Products (ProductName, CategoryId, Price, Stock) VALUES
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

SELECT * FROM Products;

--insert sample data into Customers Table
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country) VALUES
('Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', '123 Elm st', 'Springfield', 'IL', '62701', 'USA');

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country) VALUES
('Archan', 'Raha', 'archan.raha@example.com', '123-123-1234', 'VIP Road', 'Kolkata', 'West Bengal', '700059', 'India');

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country) VALUES
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak st', 'Madison', 'WI', '53703', 'USA'),
('Harshad', 'Patel', 'harshad.patel@example.com', '345-678-9012', '789 Dalal st', 'Mumbai', 'Maharashtra', '41520', 'India');

SELECT * FROM Customers;

--insert sample data into Orders Table
INSERT INTO Orders (CustomerId, OrderDate, TotalAmount) VALUES 
(1, GETDATE(), 719.98),
(2, GETDATE(), 49.99),
(3, GETDATE(), 44.98);

SELECT * FROM Orders;

--insert sample data into OrderItems Table
INSERT INTO OrderItems (OrderId, ProductId, Quantity, Price) VALUES
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 4, 1, 49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99);

SELECT * FROM OrderItems;