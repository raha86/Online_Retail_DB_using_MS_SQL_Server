--create database
CREATE DATABASE OnlineRetailDB;
GO

--use the database
USE OnlineRetailDB;
GO

--create Customers Table
CREATE TABLE Customers (
	CustomerId	INT PRIMARY KEY IDENTITY(1, 1),
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Email NVARCHAR(100),
	Phone NVARCHAR(50),
	Address NVARCHAR(250),
	City NVARCHAR(50),
	State NVARCHAR(50),
	ZipCode NVARCHAR(50),
	Country NVARCHAR(50),
	CreatedAt DATETIME DEFAULT GETDATE()
);
GO

--create the Product Table
CREATE TABLE Products (
	ProductId INT PRIMARY KEY IDENTITY(1, 1),
	ProductName NVARCHAR(100),
	CategoryId INT,
	Price DECIMAL(10, 2),
	Stock INT,
	CreatedAt DATETIME DEFAULT GETDATE()
);
GO

--create Categories Table

CREATE TABLE Categories (
	CategoriesId INT PRIMARY KEY IDENTITY(1, 1),
	CategoryName NVARCHAR(100),
	Description NVARCHAR(250)
);
GO

exec sp_rename 'OnlineRetailDB.dbo.Categories.CategoriesId', 'CategoryId', 'column';

--create Orders Table
CREATE TABLE Orders (
	OrderId INT PRIMARY KEY IDENTITY(1, 1),
	CustomerId INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10, 2),
	FOREIGN KEY(customerId) REFERENCES Customers(customerId)
);
GO

--create OrderItems Table
CREATE TABLE OrderItems (
	OrderItemId INT PRIMARY KEY IDENTITY(1, 1),
	OrderId INT,
	ProductId INT, 
	Quantity INT, 
	Price DECIMAL(10,2),
	FOREIGN KEY(ProductId) REFERENCES Products(ProductId),
	FOREIGN KEY(OrderId) REFERENCES Orders(OrderId)
);





