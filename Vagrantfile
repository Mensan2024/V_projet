# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  # Machine 1 : Load Balancer
  config.vm.define "lb" do |lb|
    lb.vm.hostname = "lb.local"
    lb.vm.network "private_network", ip: "192.168.56.10"
    lb.vm.provider "virtualbox" do |vb|
      vb.name = "lb"
      vb.memory = 1024
    end
    lb.vm.provision "shell", path: "scripts/setup_lb.sh"
  end

  # Machine 2 : Serveur Web 1
  config.vm.define "web1" do |web1|
    web1.vm.hostname = "web1.local"
    web1.vm.network "private_network", ip: "192.168.56.11"
    web1.vm.provider "virtualbox" do |vb|
      vb.name = "web1"
      vb.memory = 1024
    end
    web1.vm.provision "shell", path: "scripts/setup_web.sh"
  end

  # Machine 3 : Serveur Web 2
  config.vm.define "web2" do |web2|
    web2.vm.hostname = "web2.local"
    web2.vm.network "private_network", ip: "192.168.56.12"
    web2.vm.provider "virtualbox" do |vb|
      vb.name = "web2"
      vb.memory = 1024
    end
    web2.vm.provision "shell", path: "scripts/setup_web.sh"
  end

  # Machine 4 : DB Master
  config.vm.define "db-master" do |db_master|
    db_master.vm.hostname = "db-master.local"
    db_master.vm.network "private_network", ip: "192.168.56.13"
    db_master.vm.provider "virtualbox" do |vb|
      vb.name = "db-master"
      vb.memory = 1024
    end
    db_master.vm.synced_folder "C:/Users/CODJIA/Documents/v_project", "/home/vagrant/shared"
    db_master.vm.provision "shell", path: "scripts/setup_db_master.sh"
  end

  # Machine 5 : DB Slave
  config.vm.define "db-slave" do |slave|
    slave.vm.hostname = "db-slave.local"
    slave.vm.network "private_network", ip: "192.168.56.14"
    slave.vm.provider "virtualbox" do |vb|
      vb.name = "db-slave"
      vb.memory = 1024
    end
    slave.vm.provision "shell", path: "scripts/setup_db_slave.sh"
  end

  # Machine 6 : Monitoring
  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.hostname = "monitoring.local"
    monitoring.vm.network "private_network", ip: "192.168.56.15"
    monitoring.vm.provider "virtualbox" do |vb|
      vb.name = "monitoring"
      vb.memory = 1024
    end
    monitoring.vm.provision "shell", path: "scripts/setup_monitoring.sh"
  end

  # Machine 7 : Client (interface graphique avec autologin)
  config.vm.define "client" do |client|
    client.vm.hostname = "client.local"
    client.vm.network "private_network", ip: "192.168.56.16"
    client.vm.provider "virtualbox" do |vb|
      vb.name = "client"
      vb.memory = 1024
    end
    client.vm.provision "shell", inline: <<-SHELL
      sudo apt-get -y update
      sudo apt-get -y upgrade
      sudo apt-get install -y xfce4 lightdm lightdm-gtk-greeter firefox net-tools htop

      if ! id "client" &>/dev/null; then
        sudo useradd -m -s /bin/bash client
        echo 'client:1234' | sudo chpasswd
        sudo usermod -aG sudo client
      fi

      sudo groupadd -f autologin
      sudo usermod -aG autologin client

      sudo mkdir -p /etc/lightdm/lightdm.conf.d
      echo "[SeatDefaults]
autologin-user=client
autologin-user-timeout=0
user-session=xfce
" | sudo tee /etc/lightdm/lightdm.conf.d/50-myconfig.conf

      sudo debconf-set-selections <<< "lightdm shared/default-x-display-manager select lightdm"
      sudo dpkg-reconfigure -f noninteractive lightdm
      sudo chown -R client:client /home/client
    SHELL
  end
end
