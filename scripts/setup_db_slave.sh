#!/bin/bash

# Variables


MYSQL_ROOT_PASSWORD="@dmin25"
REPLICATION_USER="user_replica"
REPLICATION_PASSWORD="user@replica"
MASTER_IP="192.168.56.13"
DB_NAME="projetdb"
MASTER_LOG_FILE="mysql-bin.000013"
MASTER_LOG_POS=962

echo "Installation de MySQL sur le serveur esclave..."
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install mysql-server -y

echo "Configuration du mot de passe root..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

echo "Configuration de MySQL pour la réplication esclave..."
CONFIG_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"
sudo sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" "$CONFIG_FILE"
sudo sed -i "/\[mysqld\]/a server-id = 2\nrelay-log = /var/log/mysql/mysql-relay-bin.log" "$CONFIG_FILE"

echo "Redémarrage de MySQL..."
sudo systemctl restart mysql

echo "Connexion au maître et configuration de la réplication..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='$MASTER_IP',
  MASTER_USER='$REPLICATION_USER',
  MASTER_PASSWORD='$REPLICATION_PASSWORD',
  MASTER_LOG_FILE='$MASTER_LOG_FILE',
  MASTER_LOG_POS=$MASTER_LOG_POS;
START SLAVE;
EOF

echo "Vérification de l'état de la réplication..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW SLAVE STATUS\G" | grep -E 'Slave_IO_Running|Slave_SQL_Running'