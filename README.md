# Modern Data Warehouse using SQL Server | Medallion Architecture

This project demonstrates the design and implementation of a modern data warehouse using SQL Server, following the Medallion Architecture (Bronze, Silver, Gold) to transform raw data into analytics-ready models.

---
## 🏗️ Data Architecture

This project implements a modern data warehouse using the Medallion Architecture pattern, structured into **Bronze**, **Silver**, and **Gold** layers to ensure data reliability, transformation clarity, and analytical performance.

![Data Architecture](/data_architecture.png)

1. **Bronze Layer**  
   - Raw ingestion layer  
   - Stores source data from ERP and CRM systems as-is  
   - Serves as the single source of truth  

2. **Silver Layer**  
   - Data cleansing and standardization  
   - Data type corrections and normalization  
   - Business rule enforcement  

3. **Gold Layer**  
   - Dimensional modeling (Star Schema)  
   - Fact and dimension tables  
   - Optimized for analytical queries and reporting  

---
## 🔄 Data Flow

The following diagram illustrates how data moves from source systems through the Bronze, Silver, and Gold layers.

![Data Flow](/data_flow.png)

---
## 🔗 Source Integration Model

This diagram shows how ERP and CRM source tables are integrated and aligned before dimensional modeling.

![Integration Model](/data_integration.png)

---
## ⭐ Dimensional Model (Star Schema)

The Gold layer follows a Star Schema design consisting of a central fact table connected to dimension tables using surrogate keys.

![Star Schema](/star_schema_model.png)
---
## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics Enablement**: Preparing a business-ready data model that supports downstream analytical workloads.

## 🎯 Design Goals & Constraints

The objective of this project was to design and implement a structured data warehouse in SQL Server that consolidates sales data from multiple operational systems into a unified analytical model.

### Key Design Considerations

- **Multi-Source Integration**  
  Data was sourced from two independent systems (ERP and CRM) delivered as CSV files.

- **Data Quality Handling**  
  Raw data inconsistencies were resolved in the Silver layer through cleansing, normalization, and standardization.

- **Unified Analytical Model**  
  Both sources were integrated into a single dimensional model optimized for reporting workloads.

- **Scope Limitation**  
  The warehouse processes the latest available dataset only. Historical tracking (SCD Type 2) was intentionally excluded to focus on core modeling and performance optimization.

- **Documentation**  
  Clear schema documentation was maintained to support analytical and business interpretation.
---
## 🧰 Prerequisites

- SQL Server
- SQL Server Management Studio (SSMS)
---
## ⚙️ Setup Instructions

To reproduce this project locally:

1. Create a new database in SQL Server.
2. Execute scripts in the following order:
   - Bronze layer (table creation + load procedures)
   - Silver layer (cleaning & transformation logic)
   - Gold layer (dimensional modeling & fact population)
3. Import the provided CSV files into the Bronze layer tables.
4. Execute stored procedures to populate Silver and Gold layers.
5. Validate data in Gold schema using sample analytical queries.
