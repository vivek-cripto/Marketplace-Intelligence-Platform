/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/
IF OBJECT_ID('gold.dim_customers','V') IS NOT NULL
	DROP VIEW gold.dim_customers;

GO

CREATE OR ALTER VIEW gold.dim_customers AS 
	SELECT 
		ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key, --surrogate key
		customer_id,
		signup_date,
		state,
		acquisition_channel
	FROM 
		silver.customers;

GO

IF OBJECT_ID('gold.dim_products','V') IS NOT NULL
	DROP VIEW gold.dim_products

GO

CREATE OR ALTER VIEW gold.dim_products AS
	SELECT 
		ROW_NUMBER() OVER (ORDER BY product_id) AS product_key, --surrogate key
		product_id,
		product_name,
		category,
		list_price,
		unit_cost
	FROM 
		silver.products;

GO

IF OBJECT_ID('gold.fact_order_items','V') IS NOT NULL
	DROP VIEW gold.fact_order_items;

GO

CREATE OR ALTER VIEW gold.fact_order_items AS
	SELECT
		oi.order_id,
		dc.customer_key,
		dp.product_key,
		CAST(o.order_date AS date) AS order_date,
		YEAR(o.order_date) * 10000
			+ MONTH(o.order_date) * 100
			+ DAY(o.order_date)    AS date_key,
		o.status,
		o.payment_method,
		o.discount_code,
		oi.quantity,
		oi.unit_price,
		oi.discount_amount,
		oi.quantity * oi.unit_price                      AS gross_amount,
		oi.quantity * oi.unit_price - oi.discount_amount AS line_total
	FROM silver.order_items oi
	INNER JOIN silver.orders o
		ON o.order_id = oi.order_id
	INNER JOIN gold.dim_customers dc
		ON dc.customer_id = o.customer_id
	INNER JOIN gold.dim_products dp
		ON dp.product_id = oi.product_id;
GO
