/* 
================================================================
DDL Script: Create Bronze Table
================================================================
Script Purpose: This script create tables in the bronze schema,
dropping existing tables if they already exists
================================================================
*/


IF OBJECT_ID('bronze.order_items','U') IS NOT NULL
	DROP TABLE bronze.order_items

GO

CREATE TABLE bronze.order_items(
	order_id INTEGER,
	product_id INTEGER,
	quantity INTEGER,
	unit_price FLOAT,
	discount_amount FLOAT
)

GO

IF OBJECT_ID('bronze.orders','U') IS NOT NULL
	DROP TABLE bronze.orders

GO

CREATE TABLE bronze.orders(
	order_id INTEGER,
	customer_id INTEGER,
	order_date DATETIME,
	status NVARCHAR(50),
	payment_method NVARCHAR(50),
	discount_code NVARCHAR(50),
	shipping_fee FLOAT
)

GO

IF OBJECT_ID('bronze.customers','U') IS NOT NULL
	DROP TABLE bronze.customers

GO

CREATE TABLE bronze.customers(
	customer_id NVARCHAR(50),
	signup_date DATE,
	state NVARCHAR(50),
	acquisition_channel NVARCHAR(50),
)

GO

If OBJECT_ID('bronze.products','U') IS NOT NULL 
	DROP TABLE bronze.products

GO

CREATE TABLE bronze.products(
	product_id INTEGER,
	product_name NVARCHAR(50),
	category NVARCHAR(50),
	list_price FLOAT,
	unit_cost FLOAT
)

GO


