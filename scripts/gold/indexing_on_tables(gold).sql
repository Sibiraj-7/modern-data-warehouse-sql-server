--indexing on gold layer tables
DROP INDEX IF EXISTS ix_customer_key ON gold.fact_sales;
GO
CREATE NONCLUSTERED INDEX ix_customer_key ON gold.fact_sales(customer_key);
GO

DROP INDEX IF EXISTS ix_product_key ON gold.fact_sales;
GO

CREATE NONCLUSTERED INDEX ix_product_key ON gold.fact_sales(product_key);
GO

DROP INDEX IF EXISTS ix_order_date ON gold.fact_sales;
GO

CREATE NONCLUSTERED INDEX ix_order_date ON gold.fact_sales(order_date);