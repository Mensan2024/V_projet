#!/bin/bash

echo "Installation de NGINX sur le load balancer..."

# Mise à jour et installation de NGINX
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Nettoyage de la configuration par défaut
sudo rm -f /etc/nginx/sites-enabled/default

# Configuration du Load Balancer
cat <<EOF | sudo tee /etc/nginx/conf.d/load_balancer.conf
upstream backend_servers {
    server 192.168.56.11;
    server 192.168.56.12;
}

server {
    listen 80;

    location / {
        proxy_pass http://backend_servers;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Vérifier que le fichier a bien été créé
if [ ! -f /etc/nginx/conf.d/load_balancer.conf ]; then
    echo "Erreur: le fichier de configuration n'a pas été créé."
    exit 1
fi


# Tester la configuration
echo "=== Test de configuration NGINX ==="
sudo nginx -t

# Redémarrer le service
echo "=== Redémarrage de NGINX ==="
sudo systemctl restart nginx

echo "=== NGINX Load Balancer opérationnel ==="

 
