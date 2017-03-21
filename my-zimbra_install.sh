#!/bin/bash

if [ x$1 == x--init ] ; then
  sudo rm -rf /opt/zimbra/*
  sudo rm -rf /opt/zimbra/.install_history
  sudo apt-get remove -y zimbra-core # na osnovu zimbra-core installer utvrdjuje da li je nova instalacija ili upgrade
  sudo mkdir -p /opt/zimbra/install_git
  sudo chown vagrant /opt/zimbra/install_git


  sudo apt-get install -y libnet-ldap-perl libdbi-perl silversearcher-ag

  # zimbra pgp key
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9BE6ED79
  sudo apt-get install -y apt-transport-https

  sudo su -c "echo 'deb https://repo.zimbra.com/apt/87 xenial zimbra' >> /etc/apt/sources.list"
  sudo apt-get update

  cd /opt/zimbra/install_git
  git clone https://github.com/hernad/my-zimbra-core-components.git

  cd my-zimbra-core-components
  cat large/zimbra-clamav-db* > zimbra-clamav-db.deb
  cat large/zimbra-openjdk* > zimbra-openjdk.deb

  sudo dpkg -i *.deb
  sudo apt-get install -f -y
  #sudo dpkg -i zimbra-memcached*.deb zimbra-libevent-lib*
  #sudo apt-get install -f -y
fi


if [ ! -d /opt/zimbra/install_git ]  ; then
   echo "install_git nema"
   echo "run with --init"
   exit 1 
fi

cd /opt/zimbra/install_git
tar xvf /vagrant/zcs.tar.gz
cd zcs-*

echo "FORCE NEW install"
sudo apt-get remove -y zimbra-core

ZIMBRA_HOSTNAME=vagrant.out.ba
ZIMBRA_DOMAIN=out.ba

sudo su -c "echo $ZIMBRA_HOSTNAME > /etc/hostname"
sudo su -c "hostname $ZIMBRA_HOSTNAME"
sudo su -c "sed -i -e s/vagrant.vm/$ZIMBRA_HOSTNAME/ /etc/hosts"
sudo su -c "ZIMBRA_HOSTNAME=$ZIMBRA_HOSTNAME ZIMBRA_DOMAIN=$ZIMBRA_DOMAIN ZIMBRA_FORCE_NEW_INSTALL=yes ./install.sh"
