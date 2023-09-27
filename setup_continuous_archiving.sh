#!/bin/bash

# PostgreSQL data directory
PGDATA_DIR="/var/lib/postgresql/data"

# Directory where WAL files will be archived
ARCHIVE_DIR="/path/to/your/archive/directory"

# Ensure the archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Update PostgreSQL configuration to enable continuous archiving
echo "Setting up Continuous Archiving..."

{
    # Set wal_level to replica which is sufficient for archiving and replication
    echo "wal_level = replica"

    # Enable archiving of WAL files
    echo "archive_mode = on"

    # Set archive command to copy WAL files to the archive directory
    # %p is the path to the WAL file to archive
    # %f is the filename of the WAL file to archive
    echo "archive_command = 'cp %p $ARCHIVE_DIR/%f'"

} >> "$PGDATA_DIR/postgresql.conf"

# Reload PostgreSQL configuration
pg_ctl reload

echo "Continuous Archiving setup complete."

