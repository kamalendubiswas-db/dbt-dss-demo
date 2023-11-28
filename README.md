# Introduction

Welcome to the **dbt-dss-demo** repository! This project combines the power of dbt (Data Build Tool) with the robust capabilities of Databricks to orchestrate efficient data transformations, analytics, and insights generation.


## Project Overview

In this repository, we harness the strengths of dbt for:

- **Data Modeling**: Utilizing dbt to define, test, and deploy data transformation logic in a version-controlled, SQL-based environment.
- **Testing and Validation**: Implementing tests within dbt to ensure the quality and accuracy of transformed data.
- **Databricks Integration**: Leveraging Databricks' scalable computing power and collaborative environment for executing dbt transformations at scale.


## Goals and Objectives

Our primary objectives with this integrated dbt-Databricks project are:

- **Scalable Transformations**: Harness the distributed computing capabilities of Databricks to execute dbt transformations efficiently on large datasets.
- **Collaboration and Productivity**: Enable collaboration among data engineers, analysts, and data scientists within the Databricks environment while maintaining version control and documentation standards through dbt.
- **Optimized Analytics Pipeline**: Create a streamlined analytics pipeline by combining the strengths of dbt for data modeling and Databricks for scalable computation.
- **Unifying Batch and Streaming workloads**: Leveraging Databricks Streaming Tables and Materialized Views to unify Batch and Streaming workloads


## Getting Started

To begin exploring this integrated dbt-Databricks project, refer to the instructions in the Installation section below. Dive into the dbt models, explore the integration with Databricks, and contribute to enhancing our data transformation and analytics capabilities.


## dbt-databricks Adapter

The [dbt-databricks](https://github.com/databricks/dbt-databricks) adapter contains all of the code enabling dbt to work with Databricks. This adapter is based off the amazing work done in [dbt-spark](https://github.com/dbt-labs/dbt-spark). Some key features include:

- **Easy setup**. No need to install an ODBC driver as the adapter uses pure Python APIs.
- **Open by default**. For example, it uses the the open and performant [Delta](https://delta.io/) table format by default. This has many benefits, including letting you use `MERGE` as the the default incremental materialization strategy.
- **Support for Unity Catalog**. dbt-databricks>=1.1.1 supports the 3-level namespace of Unity Catalog (catalog / schema / relations) so you can organize and secure your data the way you like.
- **Performance**. The adapter generates SQL expressions that are automatically accelerated by the native, vectorized [Photon](https://databricks.com/product/photon) execution engine.


## Project Structure

```bash
.
├── Pipfile
├── Pipfile.lock
├── README.md
├── analyses
├── bundle_config_schema.json   #Databricks Asset Bundles config
├── data        #sample dataset used
├── databricks.yml #Databricks Asset Bundles yml
├── databricks_notebook
│   └── Databricks_Environment_Setup.py #Databricks notebook for initial bronze layer
├── dbt_project.yml
├── macros
├── models
│   ├── bronze_layer
│   ├── silver_layer
│   └── gold_layer
├── packages.yml
├── profiles.yml.example    #rename to `profiles.yml` and fill the connection details
├── resources
│   ├── dbt_dss_job.yml     #dbt job config
│   └── setup_job.yml       #initial setup job config
├── seeds                    
├── snapshots               
└── tests
```

We're excited to have you onboard and explore the fusion of dbt and Databricks within our data analytics ecosystem.
