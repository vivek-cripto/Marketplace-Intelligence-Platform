/* 
==================================================
Creating Database and Schema 
==================================================
Note: 
This script create a E-Commerce database and three schemas used in data warehouse following the Medallion Architecture:
Bronze — Raw, unprocessed source data
Silver — Cleaned and transformed data
Gold — Business-ready data used for analytics and reporting

Setup:
Create the database using the first SQL command.
Connect to the newly created database in SSMS.
Run the schema creation commands.
The project follows the data flow:
Source Data → Bronze → Silver → Gold

*/

USE master

GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name='ECommerce')
BEGIN
	ALTER DATABASE ECommerce SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE ECommerce;
END;
GO

CREATE DATABASE ECommerce

GO

USE ECommerce

GO

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;

