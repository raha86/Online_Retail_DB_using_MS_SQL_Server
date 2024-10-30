USE OnlineRetailDB;

--Implementing security / Role Based Access Control (RBAC)
-------------------------------------------------------------

--step by step implementation

--step-1: create logins
-------------------------
--first, we need to create logins at sql server level, this is used to authenticate users
--create login with SQL server authentication

CREATE LOGIN SalesUser WITH PASSWORD = 'strongpassword';


--step2: create user
------------------------
--create user in the database for sql server login
CREATE USER SalesUser FOR LOGIN SalesUser;


---step-3: create role
---------------------------
--this is used for permission management

CREATE ROLE SalesRole;
CREATE ROLE	MarketingRole;

--step-4: Assign users to roles
-----------------------------------

--add users to roles
EXEC sp_addrolemember 'SalesRole', 'SalesUser';

--step-5: grant permissions
----------------------------
--grant the necessary permissions to the roles based on the access requirements

--GRANT SELECT permission on the Customers Table to the SalesRole

GRANT SELECT ON Customers TO SalesRole;

--GRANT INSERT permission on the Orders Table to the SalesRole

GRANT INSERT ON Orders TO SalesRole;

--GRANT UPDATE permission on the Orders Table to the SalesRole

GRANT UPDATE ON Orders TO SalesRole;

--GRANT SELECT permission on the Products Table to the SalesRole

GRANT SELECT ON Products TO SalesRole;

--step-6: Revoke permission (if needed)
----------------------------------------

--REVOKE INSERT permission on the Orders Table to the SalesRole

REVOKE INSERT ON Orders TO SalesRole;

--step-7: view effective permissions
----------------------------------------

SELECT * FROM fn_my_permissions(NULL, 'DATABASE');



--====================================================
    -- here are 20 different cases of RBAC
--====================================================

--case1: Read only access to all tables
CREATE ROLE ReadOnlyRole;
GRANT SELECT ON SCHEMA::dbo TO ReadOnlyRole;

--case2: Data Entry Clerk (Insert only on Orders and OrderItems)
CREATE ROLE DataEntryClerk;
GRANT INSERT ON Orders TO DataEntryClerk;
GRANT INSERT ON OrderItems TO DataEntryClerk;

--case3: Product Manager (full access to Products and Categories)
CREATE ROLE ProductManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Products TO ProductManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Categories TO ProductManagerRole;

--case4: Order Processor (read and update Orders)
CREATE ROLE OrderProcessorRole;
GRANT SELECT, UPDATE ON Orders TO OrderProcessorRole;

--case5: Customer Support (Read access to Customers and Orders)
CREATE ROLE CustomerSupportRole;
GRANT SELECT ON Customers TO CustomerSupportRole;
GRANT SELECT ON Orders TO CustomerSupportRole;

--case6: Marketing Analyst (Read access to all tables, no DML)
CREATE ROLE MarketingAnalystRole;
GRANT SELECT ON SCHEMA::dbo TO MarketingAnalystRole;

--case7: Sales Analyst (Read access to Orders, OrdersItems)
CREATE ROLE SalesAnalystRole;
GRANT SELECT ON OrderItems TO SalesAnalystRole;
GRANT SELECT ON Orders TO SalesAnalystRole;

--case8: Inventory Manager (Full access to Products)
CREATE ROLE InvetoryManagerRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON	Products TO InvetoryManagerRole;

--case9: Finance Manager (Read and update Orders)
CREATE ROLE FinanceManagerRole;
GRANT SELECT, UPDATE ON Orders TO FinanceManagerRole;

--case10: Database Backup Operator (Database Backup)
CREATE ROLE BackupOperatorRole;
GRANT BACKUP DATABASE TO BackupOperatorRole;

--case11: Database Developer (Full aceess to schema objects)
CREATE ROLE DatabaseDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO DatabaseDeveloper;

--case12: Restricted read access (Read only specific columns)

--case13: Reporting user (Read access to views only)
CREATE ROLE ReportingUserRole;
GRANT SELECT ON dbo.vw_CustomerOrders TO ReportingUserRole;
GRANT SELECT ON dbo.vw_ProductDetails TO ReportingUserRole;
GRANT SELECT ON dbo.vw_RecentOrders TO ReportingUserRole;

--case14: Temporary access (time-bound access)

--case15: External Auditor (Read access with no data changes)

--case16: Applicatiion Role (Access based on application)

--case17: Role based access control(RBAC) for multiple roles

--case18: Sensitive data access (column level permission)

--case19: Developer Role (full access to development database)

--case20: Security administrator (manage security previlages)