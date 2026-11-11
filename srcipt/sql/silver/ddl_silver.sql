/* 
================================================================
DDL Script: Create Silver Table
================================================================
Script Purpose: This script create tables in the silver schema,
dropping existing tables if they already exists
================================================================
*/

IF OBJECT_ID('silver.order_items','U') IS NOT NULL
	DROP TABLE silver.order_items

GO

CREATE TABLE silver.order_items(
	order_id INTEGER,
	product_id INTEGER,
	quantity INTEGER,
	unit_price FLOAT,
	discount_amount FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

GO

IF OBJECT_ID('silver.orders','U') IS NOT NULL
	DROP TABLE silver.orders

GO

CREATE TABLE silver.orders(
	order_id INTEGER,
	customer_id INTEGER,
	order_date DATETIME,
	status NVARCHAR(50),
	payment_method NVARCHAR(50),
	discount_code NVARCHAR(50),
	shipping_fee FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()

)

GO

IF OBJECT_ID('silver.customers','U') IS NOT NULL
	DROP TABLE silver.customers

GO

CREATE TABLE silver.customers(
	customer_id NVARCHAR(50),
	signup_date DATE,
	state NVARCHAR(50),
	acquisition_channel NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

GO

If OBJECT_ID('silver.products','U') IS NOT NULL 
	DROP TABLE silver.products

GO

CREATE TABLE silver.products(
	product_id INTEGER,
	product_name NVARCHAR(50),
	category NVARCHAR(50),
	list_price FLOAT,
	unit_cost FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()

)



