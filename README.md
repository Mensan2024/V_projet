# Déploiement d'une Infrastructure Multi-Machines avec Vagrant et Bash

Ce projet a pour objectif l'automatisation du déploiement d'une infrastructure réseau composée de plusieurs machines virtuelles interconnectées à l'aide de Vagrant et de scripts Bash.

## Technologies utilisées

- Vagrant
- VirtualBox
- Bash
- MySQL (réplication maître/esclave)
- NGINX (Load Balancer)
- Apache (Serveurs Web)
- Prometheus et Grafana (Monitoring)

## Description de l’infrastructure

L’infrastructure est composée de 7 machines virtuelles :

- 1 Load Balancer (NGINX)
- 2 Serveurs Web (Apache)
- 2 Bases de données MySQL (Master et Slave)
- 1 Client utilisateur
- 1 Machine de monitoring (Prometheus, Grafana, Node Exporter)

## Arborescence des fichiers

v_project/
├── Vagrantfile
├── setup_web.sh
├── setup_lb.sh
├── setup_db_master.sh
├── setup_db_slave.sh
├── setup_monitoring.sh
├── script_sql_projet.sql
└── ubuntu-bionic-18.04-cloudimg-console.log


## Instructions de déploiement

1. Cloner ce dépôt :


2. Lancer Vagrant pour créer et provisionner les machines virtuelles :


Assurez-vous que VirtualBox et Vagrant sont installés et configurés correctement sur votre système.

## Rapport de projet

Le rapport de projet détaillé, avec des captures d’écran illustrant chaque étape, est fourni séparément.

## Auteur

Mensan CODJIA  
Ingénieur IT – Virtualisation, Réseaux et Automatisation


