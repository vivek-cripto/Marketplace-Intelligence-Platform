/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
		BEGIN TRY
			
			PRINT '-------------------------------------------------'
			PRINT 'Loading Silver Table'
			PRINT '-------------------------------------------------'
			SET @batch_start_time = GETDATE()
			SET @start_time = GETDATE()
			PRINT '-------------------------------------------------'
			PRINT 'Inserting Data Into: Customers Table'
			PRINT '-------------------------------------------------'
			-- Loading silver.customers
			INSERT INTO silver.customers (
				customer_id,
				signup_date,
				state,
				acquisition_channel
			) 
			SELECT
				customer_id,
				signup_date,
				state,
				TRIM(acquisition_channel) AS acquisition_channel
			FROM (
				SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY signup_date) AS RANKC FROM bronze.customers
				WHERE customer_id IS NOT NULL
			)t WHERE RANKC = 1
			SET @end_time = GETDATE()
			PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'


			SET @start_time = GETDATE()
			PRINT '-------------------------------------------------'
			PRINT 'Inserting Data Into: Order Items Table'
			PRINT '-------------------------------------------------'
			--Loading order_items
			INSERT INTO silver.order_items(
				order_id,
				product_id,
				quantity,
				unit_price,
				discount_amount
			)
			SELECT 
				order_id,
				product_id,
				quantity,
				unit_price,
				discount_amount
			FROM (
				SELECT * FROM bronze.order_items 
				WHERE quantity > 0 
				AND unit_price IS NOT NULL 
				AND unit_price >= 0 
				AND discount_amount <= (unit_price*quantity) 
				AND discount_amount >= 0
			)t
			SET @end_time = GETDATE()
			PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'


			SET @start_time = GETDATE()
			PRINT '-------------------------------------------------'
			PRINT 'Inserting Data Into: Orders Table'
			PRINT '-------------------------------------------------'
			-- orders
			;WITH ranked_orders AS
			(
				SELECT
					order_id,
					customer_id,
					order_date,
					status,
					payment_method,
					UPPER(TRIM(discount_code)) AS discount_code,
					shipping_fee,
					ROW_NUMBER() OVER (
						PARTITION BY order_id
						ORDER BY order_date DESC
					) AS rn
				FROM bronze.orders
				WHERE order_id IS NOT NULL
				  AND customer_id IS NOT NULL
				  AND order_date IS NOT NULL
				  AND status IS NOT NULL
				  AND payment_method IS NOT NULL
				  AND shipping_fee IS NOT NULL
				  AND shipping_fee >= 0
			)
			INSERT INTO silver.orders (
				order_id,
				customer_id,
				order_date,
				status,
				payment_method,
				discount_code,
				shipping_fee
			)
			SELECT
				order_id,
				customer_id,
				order_date,
				status,
				payment_method,
				discount_code,
				shipping_fee
			FROM ranked_orders
			WHERE rn = 1;
			SET @end_time = GETDATE()
			PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'

			
		    SET @start_time = GETDATE()
			PRINT '-------------------------------------------------'
			PRINT 'Inserting Data Into: Product Table'
			PRINT '-------------------------------------------------'
			-- products
			INSERT INTO silver.products (
				product_id,
				product_name,
				category,
				list_price,
				unit_cost
			)
			SELECT
				product_id,
				TRIM(product_name) AS product_name,
				UPPER(TRIM(category)) AS category,
				list_price,
				unit_cost
			FROM bronze.products
			WHERE product_id IS NOT NULL
			  AND product_name IS NOT NULL
			  AND category IS NOT NULL
			  AND list_price IS NOT NULL
			  AND unit_cost IS NOT NULL
			  AND list_price >= 0
			  AND unit_cost >= 0;
			 
			SET @end_time = GETDATE()
			PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
			SET @batch_end_time = GETDATE()
			PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds'
		END TRY
		BEGIN CATCH
			PRINT '==========================================='
			PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
			PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
			PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '==========================================='
		END CATCH
END
