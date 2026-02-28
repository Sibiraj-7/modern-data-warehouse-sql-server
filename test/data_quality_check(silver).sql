--crm_cust_info
SELECT cst_id,COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

SELECT cst_key
FROM bronze.crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT cst_firstname,cst_lastname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) OR cst_lastname != TRIM(cst_lastname);

SELECT DISTINCT cst_marital_status,cst_gndr
FROM bronze.crm_cust_info;

SELECT cst_create_date
FROM bronze.crm_cust_info
WHERE cst_create_date > GETDATE();

--crm_prd_info

SELECT prd_id,COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1;


SELECT prd_key
FROM bronze.crm_prd_info
WHERE SUBSTRING(prd_key,7,LEN(prd_key)) IN (
SELECT sls_prd_key FROM bronze.crm_sales_details
);

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;

SELECT prd_id, prd_start_dt,prd_end_dt
FROM bronze.crm_prd_info
WHERE prd_start_dt > prd_end_dt OR prd_start_dt IS NULL;

--crm_sales_details

SELECT sls_prd_key
FROM bronze.crm_sales_details
WHERE sls_prd_key != TRIM(sls_prd_key);

SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;


SELECT sls_sales
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price OR sls_sales < 0 OR sls_sales IS NULL;

--erp_cust_az12

SELECT cid 
FROM bronze.erp_cust_az12
WHERE cid NOT IN (
SELECT cst_key FROM bronze.crm_cust_info);

SELECT bdate
FROM bronze.erp_cust_az12
WHERE bdate > GETDATE();

SELECT DISTINCT gen
FROM bronze.erp_cust_az12;

--erp_loc_a101

SELECT cid
FROM bronze.erp_loc_a101
WHERE cid NOT IN (
SELECT cst_key FROM bronze.crm_cust_info);

SELECT DISTINCT cntry
FROM bronze.erp_loc_a101;

--erp_px_cat_g1v2

SELECT id
FROM bronze.erp_px_cat_g1v2
WHERE id NOT IN (
SELECT prd_cat_id FROM silver.crm_prd_info
);

SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat);

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;