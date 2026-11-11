
--After Executing the Procedure we can execute the saved procedure by the command of EXEC bronze.load_bronze

--EXEC bronze.load_bronze
  
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
		PRINT 'Inserting Data Into: Customers Table'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.customers 
		FROM 'C:\Users\vivek\Desktop\E-commerce Intelligence & Predictive Analytics Platform\raw\customers.csv' 
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
		FROM 'C:\Users\vivek\Desktop\E-commerce Intelligence & Predictive Analytics Platform\raw\order_items.csv'
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
		FROM 'C:\Users\vivek\Desktop\E-commerce Intelligence & Predictive Analytics Platform\raw\orders.csv'
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
		PRINT 'Truncating Table: Products'
		PRINT '-------------------------------------------------'
		TRUNCATE TABLE bronze.products;
		PRINT '-------------------------------------------------'
		PRINT 'Inserting Data Into: Products'
		PRINT '-------------------------------------------------'
		BULK INSERT bronze.products
		FROM 'C:\Users\vivek\Desktop\E-commerce Intelligence & Predictive Analytics Platform\raw\products.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		)
		
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
