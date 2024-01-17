#!/bin/bash

# Configuration
DB_HOST="localhost"
DB_PORT="5432"
DB_USER="postgres"
DB_NAME="postgres"
DB_PASSWORD="yourpassword"  # Secure this appropriately
BENCHMARK_DURATION=60  # Duration of the benchmark in seconds
CLIENT_COUNT=10  # Number of concurrent clients
TRANSACTION_COUNT=100  # Number of transactions per client

# Export password to avoid password prompt
export PGPASSWORD=$DB_PASSWORD

# Initialize pgbench
echo "Initializing pgbench..."
pgbench -i -h $DB_HOST -p $DB_PORT -U $DB_USER $DB_NAME

# Run write (insert/update/delete) benchmark
echo "Running write benchmark..."
pgbench -c $CLIENT_COUNT -j $CLIENT_COUNT -T $BENCHMARK_DURATION -h $DB_HOST -p $DB_PORT -U $DB_USER $DB_NAME

# Run read (select) benchmark
echo "Running read benchmark..."
pgbench -S -c $CLIENT_COUNT -j $CLIENT_COUNT -T $BENCHMARK_DURATION -h $DB_HOST -p $DB_PORT -U $DB_USER $DB_NAME

# Cleanup
unset PGPASSWORD
