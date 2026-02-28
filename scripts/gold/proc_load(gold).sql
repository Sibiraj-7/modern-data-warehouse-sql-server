--Execute this procedure with "EXEC gold.load_gold"

CREATE OR ALTER PROCEDURE gold.load_gold AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME ;
	
	SET @batch_start_time = GETDATE();
	BEGIN TRY
		PRINT '================================================';
		PRINT 'Loading Gold layer';
		PRINT '================================================';

		PRINT '>> Truncating table: gold.dim_customers';
		SET @start_time = GETDATE();
		TRUNCATE TABLE gold.dim_customers;

		PRINT '>> Inserting data into: gold.dim_customers';
		INSERT INTO gold.dim_customers(
			customer_id,
			customer_number,
			first_name,
			last_name,
			country,
			marital_status,
			gender,
			birthdate,
			create_date
		)

		SELECT 
			c1.cst_id AS customer_id,
			c1.cst_key AS customer_number,
			c1.cst_firstname AS first_name,
			c1.cst_lastname AS last_name,
			c3.cntry AS country,
			c1.cst_marital_status AS marital_status,
			REPLACE(c1.cst_gndr,'Unknown',COALESCE(c2.gen,'Unknown')) AS gender,
			c2.bdate AS birthdate,
			c1.cst_create_date AS create_date
		FROM silver.crm_cust_info AS c1
		LEFT JOIN silver.erp_cust_az12 AS c2
		ON c1.cst_key = c2.cid
		LEFT JOIN silver.erp_loc_a101 AS c3
		ON c1.cst_key = c3.cid;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '--------------------------------'

		PRINT '>> Truncating table: gold.dim_products';
		SET @start_time = GETDATE();
		TRUNCATE TABLE gold.dim_products;

		PRINT '>> Inserting data into: gold.dim_products';
		INSERT INTO gold.dim_products(
			product_id,
			product_number,
			product_name,
			category_id,
			category,
			subcategory,
			maintenance,
			cost,
			product_line,
			start_date
		)

		SELECT 
			pr.prd_id AS product_id,
			pr.prd_key AS product_number,
			pr.prd_nm AS product_name,
			pr.prd_cat_id AS category_id,
			pc.cat AS category,
			pc.subcat AS subcategory,
			pc.maintenance AS maintenance,
			pr.prd_cost AS cost,
			pr.prd_line AS product_line,
			pr.prd_start_dt AS start_date
		FROM silver.crm_prd_info AS pr
		LEFT JOIN silver.erp_px_cat_g1v2 AS pc
		ON pr.prd_cat_id = pc.id
		WHERE pr.prd_end_dt IS NULL; -- Filtering the historical data with the recent one
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '--------------------------------'

		PRINT '>> Truncating table: gold.fact_sales';
		SET @start_time = GETDATE();
		TRUNCATE TABLE gold.fact_sales;

		PRINT '>> Inserting data into: gold.fact_sales';
		INSERT INTO gold.fact_sales(
			order_number,
			product_key,
			customer_key,
			order_date,
			shipping_date,
			due_date,
			sales_amount,
			quantity,
			price
		)

		SELECT 
			s.sls_ord_num AS order_number,
			p.product_key,
			c.customer_key,
			s.sls_order_dt AS order_date,
			s.sls_ship_dt AS shipping_date,
			s.sls_due_dt AS due_date,
			s.sls_sales AS sales_amount,
			s.sls_quantity AS quantity,
			s.sls_price AS price
		FROM silver.crm_sales_details AS s
		LEFT JOIN gold.dim_products AS p
		ON s.sls_prd_key = p.product_number
		LEFT JOIN gold.dim_customers AS c
		ON c.customer_id = s.sls_cust_id;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '--------------------------------'

		SET @batch_end_time = GETDATE();
		PRINT '=========================================================';
		PRINT 'Gold layer is loaded'
		PRINT 'Load duration of Gold layer: '+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '=========================================================';
	END TRY
	BEGIN CATCH
		PRINT '=========================================================';
		PRINT 'ERROR OCCURED DURING LOADING GOLD LAYER';
		PRINT 'ERROR message: '+ ERROR_MESSAGE();
		PRINT 'ERROR number: '+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR message: '+ CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================================';
	END CATCH
END