python -m dbt_databricks_factory.cli create-job \
    --job-name 'dbt_dp_factory_job' \
    --project-dir 'dbt_dss_demo' \
    --profiles-dir 'profiles.yml' \
    --git-provider 'gitHub' \
    --git-url 'https://github.com/kamalendubiswas-db/dbt-dss-demo' \
    --git-branch 'dev' \
    --job-cluster kb_dbt_test_cluster @dp_artefact/cluster_config.json \
    --default-task-cluster kb_dbt_test_cluster \
    --library 'dbt-databricks>=1.0.0,<2.0.0' \
    --pretty \
    target/manifest.json > workflow.json