# Databricks notebook source
dbutils.widgets.text("Catalog Name", "dbt_example_catalog")
dbutils.widgets.text("Schema Prefix", "")

# COMMAND ----------

# DBTITLE 1,Create catalog, schemas and volume
import os

catalog_name = dbutils.widgets.getArgument("Catalog Name")
schema_prefix = dbutils.widgets.getArgument("Schema Prefix")

schema_prefix = f"{schema_prefix}_" if schema_prefix else ""

os.environ['catalog_name'] = catalog_name
os.environ['schema_prefix'] = schema_prefix

print(f"Creating or using catalog: {catalog_name}")
print(f"Using schema prefix: {schema_prefix}")

spark.sql(f"CREATE CATALOG IF NOT EXISTS {catalog_name}")

spark.sql(f"CREATE SCHEMA IF NOT EXISTS {catalog_name}.bronze") #Only one bronze schema per catalog is needed
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {catalog_name}.{schema_prefix}silver")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {catalog_name}.{schema_prefix}gold")

spark.sql(f"CREATE VOLUME IF NOT EXISTS {catalog_name}.bronze.raw_data;")
spark.sql(f"CREATE VOLUME IF NOT EXISTS {catalog_name}.bronze.dbt_artefacts;")

spark.sql(f"GRANT ALL PRIVILEGES ON SCHEMA {catalog_name}.bronze TO `account users`;")

# COMMAND ----------

# DBTITLE 1,Download data files to volume
# MAGIC %sh
# MAGIC rm -rf dbt-dss-demo-dev.zip \
# MAGIC   && curl -LJO https://github.com/kamalendubiswas-db/dbt-dss-demo/archive/dev.zip \
# MAGIC   && unzip -jo dbt-dss-demo-dev.zip 'dbt-dss-demo-dev/data/*.csv' -d /Volumes/$catalog_name/bronze/raw_data \
# MAGIC   && rm -rf dbt-dss-demo-dev.zip

# COMMAND ----------

# DBTITLE 1,UC Volume path for the raw data
raw_data = f"/Volumes/{catalog_name}/bronze/raw_data"

# COMMAND ----------

# DBTITLE 1,Customer data load from the UC Volume
raw_customers = (spark.read
  .format("csv")
  .option("header", "false")
  .option("inferSchema", "true")
  .option("delimiter", "|")
  .load(f"{raw_data}/customer.csv")
)
cleaned_customers = raw_customers.withColumnsRenamed(
                                                    {"_c0": "customer_id",
                                                     "_c1": "customer_name",
                                                     "_c2": "address",
                                                     "_c3": "nation_id",
                                                     "_c4": "phone_number",
                                                     "_c5": "account_balance",
                                                     "_c6": "mktsegment",
                                                     "_c7": "comment",
                                                     "_c8": "extra"}
                                                  )
cleaned_customers.write.saveAsTable(f"{catalog_name}.bronze.raw_customers", mode="overwrite")


# COMMAND ----------

# DBTITLE 1,Orders data load from the UC Volume
raw_orders = (spark.read
  .format("csv")
  .option("header", "false")
  .option("inferSchema", "true")
  .option("delimiter", "|")
  .load(f"{raw_data}/order.csv")
)
cleaned_orders = raw_orders.withColumnsRenamed(
                                                    {"_c0": "order_id",
                                                     "_c1": "customer_id",
                                                     "_c2": "order_status",
                                                     "_c3": "total_price",
                                                     "_c4": "order_date",
                                                     "_c5": "order_priority",
                                                     "_c6": "clerk",
                                                     "_c7": "ship_priority",
                                                     "_c8": "comment",
                                                     "_c9": "extra"}
                                                  )
cleaned_orders.write.saveAsTable(f"{catalog_name}.bronze.raw_orders", mode="overwrite")


# COMMAND ----------

# DBTITLE 1,Parts data load from the UC Volume
raw_parts = (spark.read
  .format("csv")
  .option("header", "false")
  .option("inferSchema", "true")
  .option("delimiter", "|")
  .load(f"{raw_data}/part.csv")
)
cleaned_parts = raw_parts.withColumnsRenamed(
                                                    {"_c0": "part_id",
                                                     "_c1": "part_name",
                                                     "_c2": "manufacturer",
                                                     "_c3": "brand",
                                                     "_c4": "type",
                                                     "_c5": "size",
                                                     "_c6": "container",
                                                     "_c7": "retail_price",
                                                     "_c8": "comment",
                                                     "_c9": "extra"}
                                                  )
cleaned_parts.write.saveAsTable(f"{catalog_name}.bronze.raw_parts", mode="overwrite")


# COMMAND ----------

# DBTITLE 1,Supplier data load from the UC Volume
raw_suppliers = (spark.read
  .format("csv")
  .option("header", "false")
  .option("inferSchema", "true")
  .option("delimiter", "|")
  .load(f"{raw_data}/supplier.csv")
)
cleaned_suppliers = raw_suppliers.withColumnsRenamed(
                                                    {"_c0": "supplier_id",
                                                     "_c1": "supplier_name",
                                                     "_c2": "address",
                                                     "_c3": "nation_id",
                                                     "_c4": "phone",
                                                     "_c5": "account_balance",
                                                     "_c6": "comment",
                                                     "_c7": "extra"}
                                                  )
cleaned_suppliers.write.saveAsTable(f"{catalog_name}.bronze.raw_suppliers", mode="overwrite")


# COMMAND ----------

# DBTITLE 1,Order Line_items data load from the UC Volume
raw_lineitems = (spark.read
  .format("csv")
  .option("header", "false")
  .option("inferSchema", "true")
  .option("delimiter", "|")
  .load(f"{raw_data}/lineitem.csv")
)
cleaned_lineitems = raw_lineitems.withColumnsRenamed(
                                                    {"_c0": "order_id",
                                                     "_c1": "part_id",
                                                     "_c2": "supplier_id",
                                                     "_c3": "line_number",
                                                     "_c4": "quantity",
                                                     "_c5": "extended_price",
                                                     "_c6": "discount",
                                                     "_c7": "tax",
                                                     "_c8": "return_flag",
                                                     "_c9": "line_status",
                                                     "_c10": "ship_date",
                                                     "_c11": "commit_date",
                                                     "_c12": "receipt_date",
                                                     "_c13": "ship_instruct",
                                                     "_c14": "shipmode",
                                                     "_c15": "comment",
                                                     "_c16": "extra"}
                                                  )
cleaned_lineitems.write.saveAsTable(f"{catalog_name}.bronze.raw_lineitems", mode="overwrite")


# COMMAND ----------

# DBTITLE 1,Nation data load from the UC Volume
raw_nations = (spark.read
  .format("csv")
  .option("header", "false")
  .option("inferSchema", "true")
  .option("delimiter", "|")
  .load(f"{raw_data}/nation.csv")
)
cleaned_nations = raw_nations.withColumnsRenamed(
                                                    {"_c0": "nation_id",
                                                     "_c1": "nation_name",
                                                     "_c2": "comment",
                                                     "_c3": "extra"}
                                                  )
cleaned_nations.write.saveAsTable(f"{catalog_name}.bronze.raw_nations", mode="overwrite")


# COMMAND ----------


