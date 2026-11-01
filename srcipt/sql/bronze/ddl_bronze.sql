/* 
================================================================
DDL Script: Create Bronze Table
================================================================
Script Purpose: This script create tables in the bronze schema,
dropping existing tables if they already exists
================================================================
*/

IF OBJECT_ID('bronze.reviews','U') IS NOT NULL
	DROP TABLE bronze.reviews

GO

CREATE TABLE bronze.reviews(
	review_id NVARCHAR(50),
	shipment_id NVARCHAR(50),
	order_id INTEGER,
	seller_id NVARCHAR(50),
	review_score INTEGER,
	review_creation_ts DATETIME,
	has_comment INTEGER
)

GO

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

IF OBJECT_ID('bronze.seller','U') IS NOT NULL
	DROP TABLE bronze.seller

GO

CREATE TABLE bronze.seller(
	seller_id NVARCHAR(50),
	seller_name NVARCHAR(50),
	join_date DATE,
	state NVARCHAR(50),
	primary_category NVARCHAR(50),
	second_category NVARCHAR(50),
	seller_tier NVARCHAR(50),
	fulfillment_type NVARCHAR(50),
	handling_promise_date INTEGER
)

GO

IF OBJECT_ID('bronze.seller_listings','U') IS NOT NULL
	DROP TABLE bronze.seller_listings

GO

CREATE TABLE bronze.seller_listings(
	listing_id NVARCHAR(50),
	seller_id NVARCHAR(50),
	product_id INTEGER,
	listing_date DATE,
	delisting_date DATE
)

IF OBJECT_ID('bronze.order_items_enriched','U') IS NOT NULL
	DROP TABLE bronze.order_items_enriched

GO

CREATE TABLE bronze.order_items_enriched(
	order_id INTEGER,
	order_item_id INTEGER,
	product_id INTEGER,
	seller_id NVARCHAR(50),
	quantity INTEGER,
	unit_price FLOAT,
	discount_amount FLOAT
)

GO

IF OBJECT_ID('bronze.shipments','U') IS NOT NULL
	DROP TABLE bronze.shipments

GO

CREATE TABLE bronze.shipments(
	shipment_id NVARCHAR(50),
	order_id INTEGER,
	seller_id NVARCHAR(50),
	carrier NVARCHAR(50),
	shipped_ts DATETIME,
	delivered_ts DATETIME,
	estimated_delivery_ts DATE,
	item_count INTEGER,
	shipment_value FLOAT
)

GO

