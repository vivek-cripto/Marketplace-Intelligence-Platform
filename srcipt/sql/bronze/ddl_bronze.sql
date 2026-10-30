/* 
================================================================
DDL Script: Create Bronze Table
================================================================
Script Purpose: This script create tables in the bronze schema,
dropping existing tables if they already exists
================================================================
*/

IF OBJECT_ID('bronze.payment','U') IS NOT NULL 
	DROP TABLE bronze.payment

GO

CREATE TABLE bronze.payment(
	order_id NVARCHAR(50),
	payment_type NVARCHAR(50),
	payment_installment INTEGER,
	payment_value INTEGER
)

GO

IF OBJECT_ID('bronze.reviews','U') IS NOT NULL
	DROP TABLE bronze.reviews

GO

CREATE TABLE bronze.reviews(
	review_id NVARCHAR(50),
	order_id NVARCHAR(50),
	review_score INTEGER,
	review_creation_ts DATE,
	has_comment INTEGER
)

GO

IF OBJECT_ID('bronze.order_items','U') IS NOT NULL
	DROP TABLE bronze.order_items

GO

CREATE TABLE bronze.order_items(
	order_id NVARCHAR(50),
	order_item_id INTEGER,
	product_id NVARCHAR,
	seller_id NVARCHAR(50),
	price FLOAT,
	fright_value FLOAT
)

GO

IF OBJECT_ID('bronze.orders','U') IS NOT NULL
	DROP TABLE bronze.orders

GO

CREATE TABLE bronze.orders(
	order_id INTEGER,
	customer_id NVARCHAR(50),
	seller_id NVARCHAR(50),
	order_status NVARCHAR(50),
	order_purchase_ts DATE,
	order_approved_ts DATE,
	order_shipped_ts DATE,
	order_delivered_ts DATE,
	order_estimated_delivery DATE,
	discount_pct INTEGER,
	device_name NVARCHAR(50),
	item_count INTEGER,
	order_value FLOAT,
	fright_value FLOAT
)

GO

IF OBJECT_ID('bronze.customers','U') IS NOT NULL
	DROP TABLE bronze.customers

GO

CREATE TABLE bronze.customers(
	customer_id NVARCHAR(50),
	signup_date DATE,
	city NVARCHAR(50),
	state NVARCHAR(50),
	acquisition_channel NVARCHAR(50),
	age_group NVARCHAR(50)
)

GO

If OBJECT_ID('bronze.products','U') IS NOT NULL 
	DROP TABLE bronze.products

GO

CREATE TABLE bronze.products(
	product_id NVARCHAR(50),
	seller_id NVARCHAR(50),
	category NVARCHAR(50),
	list_price FLOAT,
	weight INTEGER
)

GO

IF OBJECT_ID('bronze.seller','U') IS NOT NULL
	DROP TABLE bronze.seller

GO

CREATE TABLE bronze.seller(
	seller_id NVARCHAR(50),
	join_date DATE,
	city NVARCHAR(50),
	state NVARCHAR(50),
	primary_category NVARCHAR(50)
)
