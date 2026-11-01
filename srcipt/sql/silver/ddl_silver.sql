/* 
================================================================
DDL Script: Create Silver Table
================================================================
Script Purpose: This script create tables in the silver schema,
dropping existing tables if they already exists
================================================================
*/

IF OBJECT_ID('silver.reviews','U') IS NOT NULL
	DROP TABLE silver.reviews

GO

CREATE TABLE silver.reviews(
	review_id NVARCHAR(50),
	shipment_id NVARCHAR(50),
	order_id INTEGER,
	seller_id NVARCHAR(50),
	review_score INTEGER,
	review_creation_ts DATETIME,
	has_comment INTEGER,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

GO

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

GO

IF OBJECT_ID('silver.seller','U') IS NOT NULL
	DROP TABLE silver.seller

GO

CREATE TABLE silver.seller(
	seller_id NVARCHAR(50),
	seller_name NVARCHAR(50),
	join_date DATE,
	state NVARCHAR(50),
	primary_category NVARCHAR(50),
	second_category NVARCHAR(50),
	seller_tier NVARCHAR(50),
	fulfillment_type NVARCHAR(50),
	handling_promise_date INTEGER,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

GO

IF OBJECT_ID('silver.seller_listings','U') IS NOT NULL
	DROP TABLE silver.seller_listings

GO

CREATE TABLE silver.seller_listings(
	listing_id NVARCHAR(50),
	seller_id NVARCHAR(50),
	product_id INTEGER,
	listing_date DATE,
	delisting_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

IF OBJECT_ID('silver.order_items_enriched','U') IS NOT NULL
	DROP TABLE silver.order_items_enriched

GO

CREATE TABLE silver.order_items_enriched(
	order_id INTEGER,
	order_item_id INTEGER,
	product_id INTEGER,
	seller_id NVARCHAR(50),
	quantity INTEGER,
	unit_price FLOAT,
	discount_amount FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

GO

IF OBJECT_ID('silver.shipments','U') IS NOT NULL
	DROP TABLE silver.shipments

GO

CREATE TABLE silver.shipments(
	shipment_id NVARCHAR(50),
	order_id INTEGER,
	seller_id NVARCHAR(50),
	carrier NVARCHAR(50),
	shipped_ts DATETIME,
	delivered_ts DATETIME,
	estimated_delivery_ts DATE,
	item_count INTEGER,
	shipment_value FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)

GO


