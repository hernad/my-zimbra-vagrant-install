#!/bin/bash

if [ x$1 == x--init ] ; then
  sudo rm -rf /opt/zimbra/*
  sudo rm -rf /opt/zimbra/.install_history
  sudo apt-get remove -y zimbra-core # na osnovu zimbra-core installer utvrdjuje da li je nova instalacija ili upgrade
  sudo mkdir -p /opt/zimbra/install_git
  sudo chown vagrant /opt/zimbra/install_git
fi


if [ ! -d /opt/zimbra/install_git ]  ; then
   echo "install_git nema"
   echo "run with --init"
   exit 1 
fi

cd /opt/zimbra/install_git

git clone https://github.com/hernad/my-zimbra-core-components.git

cd my-zimbra-core-components

cat large/zimbra-clamav-db* > zimbra-clamav-db.deb
cat large/zimbra-openjdk* > zimbra-openjdk.deb

sudo dpkg -i *.deb
sudo apt-get install -f -y


sudo apt-get install -y libnet-ldap-perl libdbi-perl silversearcher-ag

# zimbra pgp key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9BE6ED79
sudo apt-get install -y apt-transport-https

sudo su -c "echo 'deb https://repo.zimbra.com/apt/87 xenial zimbra' >> /etc/apt/sources.list"
sudo apt-get update

cd /opt/zimbra/install_git
tar xvf /vagrant/zcs.tar.gz
cd zcs-*

#export ZM_CUR_MAJOR=8  ZM_CUR_MINOR=7  ZM_CUR_MICRO=1

unset ZM_CUR_MAJOR ZM_CUR_MINOR ZM_CUR_MICRO

echo "FORCE NEW install"
sudo rm /opt/zimbra/.install_history
sudo apt-get remove -y zimbra-core
#export ZIMBRA_FORCE_NEW_INSTALL="yes" => ignore DETECTDIRS='db bin/zmcontrol redolog index store conf/localconfig.xml data'

sudo su -c "ZIMBRA_HOSTNAME=vagrant.out.ba ZIMBRA_DOMAIN=out.ba ZIMBRA_FORCE_NEW_INSTALL=yes ./install.sh"

