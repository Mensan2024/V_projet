#!/bin/bash
set -e

# Variables
MYSQL_ROOT_PASSWORD="@dmin25"
REPLICATION_USER="user_replica"
REPLICATION_PASSWORD="user@replica"
BIND_ADDRESS="0.0.0.0"
DB_NAME="projetdb"
CONFIG_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"

echo " Mise à jour du système..."
sudo apt-get update 
sudo apt-get upgrade -y

echo " Installation de MySQL Server..."
sudo DEBIAN_FRONTEND=noninteractive apt install mysql-server -y

# Vérification si MySQL est installé
if ! command -v mysql &> /dev/null; then
    echo "❌ MySQL n'est pas installé !"
    exit 1
fi

# Configuration du mot de passe root si nécessaire
if ! mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" &> /dev/null; then
  echo " Configuration du mot de passe root MySQL..."
  sudo mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
fi

# Test de la connexion root
if ! mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1;" &> /dev/null; then
    echo " Échec de la connexion MySQL avec le mot de passe root."
    exit 1
fi

echo " Configuration de MySQL comme serveur maître..."

# Préparer le dossier pour les fichiers binlogs
sudo mkdir -p /var/log/mysql
sudo chown mysql:mysql /var/log/mysql

# Mise à jour du fichier de config MySQL
if ! grep -q "\[mysqld\]" "$CONFIG_FILE"; then
    echo " La section [mysqld] n'a pas été trouvée dans $CONFIG_FILE"
    exit 1
fi

sudo sed -i "s/^bind-address\s*=.*/bind-address = $BIND_ADDRESS/" "$CONFIG_FILE"

if ! grep -q "server-id" "$CONFIG_FILE"; then
  sudo sed -i "/\[mysqld\]/a server-id = 1" "$CONFIG_FILE"
fi

if ! grep -q "log_bin" "$CONFIG_FILE"; then
  sudo sed -i "/\[mysqld\]/a log_bin = /var/log/mysql/mysql-bin.log" "$CONFIG_FILE"
fi

if ! grep -q "binlog_do_db = $DB_NAME" "$CONFIG_FILE"; then
  sudo sed -i "/\[mysqld\]/a binlog_do_db = $DB_NAME" "$CONFIG_FILE"
fi

echo " Redémarrage de MySQL..."
sudo systemctl restart mysql

echo " Création de la base $DB_NAME si elle n'existe pas..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

echo " Création de l'utilisateur de réplication..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "
CREATE USER IF NOT EXISTS '$REPLICATION_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$REPLICATION_PASSWORD';
GRANT REPLICATION SLAVE ON *.* TO '$REPLICATION_USER'@'%';
FLUSH PRIVILEGES;
"

echo " Serveur maître configuré avec succès."
echo " N'oublie pas d'exécuter ensuite :"
echo "    - FLUSH TABLES WITH READ LOCK;"
echo "    - SHOW MASTER STATUS;"
echo "    - mysqldump de la base"
echo "    - scp vers le serveur slave"