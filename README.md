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
├── data #sample data
├── databricks_notebook
│   └── Databricks_Environment_Setup.py  #initial setup of bronze layer
├── dbt_project.yml
├── profiles.yml.example #rename to `profiles.yml`
├── macros
│   └── generate_schema_name.sql #macro of custom schema
├── models
│   ├── bronze_layer
│   ├── silver_layer
│   └── gold_layer
├── packages.yml
├── seeds
│   ├── properties.yml
│   └── raw_region_seed.csv #seed data for regions
├── snapshots
└── tests
```

We're excited to have you onboard and explore the fusion of dbt and Databricks within our data analytics ecosystem.

## Deploying

This project uses Databricks Asset bundles to deploy two jobs:
* dbt_dss_job - Used to execute the DBT project stored in GIT
* dbt_dss_setup_job - Used to run the setup scripts to create Catalogs, Volumes and Schemas

To deploy these jobs you first need to configure the `Databricks.yml` file to point to the workspace(s) you want to deploy the project to.

You also need to configure the two variables `catalog_name` and `warehouse_id`

To deploy the jobs using bundles, you need to run two commands:

```bash
databricks bundle deploy #Deploys artefacts to the workspace
databricks bundle run #Starts one of the jobs
```

Read more about Databricks Asset bundles and how to install it [here](https://docs.databricks.com/en/dev-tools/bundles/index.html)

## CI/CD

We have chosen to show an example using Github Actions, but it is of course possible to implement a CI/CD process in the tool of your choice. For this example you, need to provide a PAT as `SP_TOKEN` secret variable in github.

## Additional model configs
For data warehousing, the following tblproperties are the most common for performance of incremental models that are highly flexible:

- `delta.feature.allowColumnDefaults`: `supported` — This property allows us to use generated and default columns on our delta tables.
- `delta.columnMapping.mode` : `name` — This property allows users to alter, rename, and reorder columns in existing Delta tables.
- `delta.enableDeletionVectors`: `true` — This property allows for up to 10x merge performance improvement by writing deletion vectors instead of re-writing entire files under the hood.

In newer Databricks runtimes (and in DBSQL), these are usually enabled by default. In addition to these properties there are few other properties that can be set for the underlying Delta tables as part of model config - [Delta table properties reference](https://docs.databricks.com/en/delta/table-properties.html).