
--After Executing the Procedure we can execute the saved procedure by the command of EXEC bronze.load_bronze


  
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME

	BEGIN TRY
		PRINT '-------------------------------------------------'
		PRINT 'Loading Bronze Table'
		PRINT '-------------------------------------------------'

		SET @batch_start_time = GETDATE()
		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Customers Table'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.customers;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Cuomers Table'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.customers 
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\customers.csv' 
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'

		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: order_items Table'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.order_items;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: order_items Table'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.order_items 
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\order_items.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		

		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Orders Table'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.orders;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Orders Table'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.orders 
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\orders.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'	

		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Order Items Enriched'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.order_items_enriched;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Order Items Enriched'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.order_items_enriched
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\seller_side_dataset\order_items_enriched.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'

		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Products'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.products;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Products'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.products
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\products.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'

		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Reviews'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.reviews;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Reviews'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.reviews
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\seller_side_dataset\seller_reviews.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'

		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Seller'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.seller;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Seller'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.seller
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\seller_side_dataset\sellers.csv'
		WITH ( 
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'

		SET @start_time =GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Seller Listings'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.seller_listings;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Seller Listings'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.seller_listings
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\seller_side_dataset\seller_listings.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + 'seconds'

		SET @start_time = GETDATE()
		PRINT '-------------------------------------------------'
		PRINT 'Truncating Table: Shipments'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.shipments;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Shipments'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.shipments
		FROM 'C:\Users\vivek\Downloads\ecommerce-sales-analysis-datasets\ecommerce-sales-analysis\seller_side_dataset\shipments.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		SET @end_time = GETDATE()
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds'

		SET @batch_end_time = GETDATE()
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds'

		END TRY

		BEGIN CATCH
			PRINT '========================================='
			PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
			PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
			PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '========================================='
		END CATCH
END
