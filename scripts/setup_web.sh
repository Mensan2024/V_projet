#!/bin/bash

# Met à jour les paquets
sudo apt-get update

# Installe Apache2
sudo apt-get install -y apache2

# Active Apache au démarrage
sudo systemctl enable apache2

# Crée une page d'accueil personnalisée
echo "<html><body><h1>Bienvenue sur $(hostname)</h1></body></html>" | sudo tee /var/www/html/index.html