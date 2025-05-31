#!/bin/bash
set -e

# Variables
MYSQL_ROOT_PASSWORD="@dmin25"
DB_NAME="projetdb"
SLAVE_USER="user"
SLAVE_HOST="192.168.56.14"
REMOTE_PATH="/tmp"
DUMP_FILE="${DB_NAME}_dump.sql"

echo "Dump de la base $DB_NAME avec informations de réplication..."
mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --databases "$DB_NAME" --master-data=2 > "$DUMP_FILE"

echo "Transfert du dump vers l'esclave ($SLAVE_HOST)..."
scp "$DUMP_FILE" "$SLAVE_USER@$SLAVE_HOST:$REMOTE_PATH/"

echo "Dump transféré avec succès."
echo "Sur le slave, importe le dump :"
echo "  mysql -u root -p $DB_NAME < $REMOTE_PATH/$DUMP_FILE"
echo "La réplication sera configurée automatiquement par les informations dans le dump."