--crm_cust_info
DROP INDEX IF EXISTS ix_cst_key ON silver.crm_cust_info;
GO
CREATE CLUSTERED INDEX ix_cst_key ON silver.crm_cust_info(cst_key);
GO
DROP INDEX IF EXISTS ix_cst_id ON silver.crm_cust_info;
GO
CREATE NONCLUSTERED INDEX ix_cst_id ON silver.crm_cust_info(cst_id);
GO

--erp_cust_az12
DROP INDEX IF EXISTS ix_cid ON silver.erp_cust_az12;
GO
CREATE CLUSTERED INDEX ix_cid ON silver.erp_cust_az12(cid);
GO

--erp_loc_a101
DROP INDEX IF EXISTS ix_cid_loc ON silver.erp_loc_a101;
GO
CREATE CLUSTERED INDEX ix_cid_loc ON silver.erp_loc_a101(cid);

--crm_prd_info
DROP INDEX IF EXISTS ix_prd_cat_id ON silver.crm_prd_info;
GO
CREATE CLUSTERED INDEX ix_prd_cat_id ON silver.crm_prd_info(prd_cat_id);
GO

DROP INDEX IF EXISTS ix_prd_key ON silver.crm_prd_info;
GO
CREATE NONCLUSTERED INDEX ix_prd_key ON silver.crm_prd_info(prd_key);
GO

--erp_px_cat_g1v2
DROP INDEX IF EXISTS ix_id ON silver.erp_px_cat_g1v2;
GO
CREATE CLUSTERED INDEX ix_id ON silver.erp_px_cat_g1v2(id);

--crm_sales_details
DROP INDEX IF EXISTS ix_cust_id ON silver.crm_sales_details;
GO
CREATE NONCLUSTERED INDEX ix_cust_id ON silver.crm_sales_details(sls_cust_id);
GO

DROP INDEX IF EXISTS ix_prd_key ON silver.crm_sales_details;
GO
CREATE NONCLUSTERED INDEX ix_prd_key ON silver.crm_sales_details(sls_prd_key);
