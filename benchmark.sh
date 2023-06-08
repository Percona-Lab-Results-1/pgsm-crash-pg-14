#!/bin/bash

# Set the database connection parameters
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="your_database"
DB_USER="your_username"
DB_PASSWORD="your_password"

# Set the number of concurrent clients and total transactions
CLIENTS=10
TRANSACTIONS=1000

# Set the duration of the benchmark (in seconds)
DURATION=300

# Create the monitoring extension in the database
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "CREATE EXTENSION IF NOT EXISTS pg_stat_monitor;"

# Run the benchmark with pgbench
pgbench -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c $CLIENTS -T $DURATION -f pg_stat_monitor.sql -j $CLIENTS -M prepared -P 1 -n -r -s 100 -C -j $CLIENTS -N -P $TRANSACTIONS -q

# Print the benchmark results
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "SELECT * FROM pg_stat_monitor;"

