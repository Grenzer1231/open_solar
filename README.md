# open_solar dbt + DuckDB starter

This repository contains a minimal dbt project configured to run against a local DuckDB file. Install dependencies, adjust the profile if needed, and run dbt commands to build the example models.

## Quickstart

1. Create and activate a virtual environment.
2. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Confirm dbt can find the DuckDB profile:

   ```bash
   dbt debug --profiles-dir .
   ```

4. Run and test the project:

   ```bash
   dbt run --profiles-dir .
   dbt test --profiles-dir .
   ```

The DuckDB database will be created at `data/warehouse.duckdb` by default; you can update `profiles.yml` to change the location or schema.

## Assumptions

### Set-up
1. We have an ingestion pipeline that dumps data in our data warehouse


### Data
1. **id** is the identifier for the proposal entity. Multiple occurences of the same **id** refers to the revisions/updates
2. **created_date** refers to the creation if the  proposal entity in the system. If **proposal_date** < **created_date**, then the proposal was created and sent outside the system
before it was created in the system.

