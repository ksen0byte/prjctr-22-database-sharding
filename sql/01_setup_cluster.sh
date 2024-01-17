#!/bin/bash
set -e

# Function to add worker nodes
add_worker() {
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "SELECT * FROM master_add_node('$1', 5432);"
}

# Wait for the server to start
sleep 10

# Add worker nodes
add_worker worker1
add_worker worker2
