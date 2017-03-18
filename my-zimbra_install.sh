#!/bin/bash

if [ x$1 == x--init ] ; then
  sudo rm -rf /opt/zimbra/*
  sudo mkdir /opt/zimbra/install_git
  sudo chown vagrant /opt/zimbra/install_git
fi


cd /opt/zimbra/install_git

git clone https://github.com/hernad/my-zimbra-core-components.git

cd my-zimbra-core-components

cat large/zimbra-clamav-db* > zimbra-clamav-db.deb
cat large/zimbra-openjdk* > zimbra-openjdk.deb

sudo dpkg -i *.deb
sudo apt-get install -f -y


sudo apt-get install -y libnet-ldap-perl silversearcher-ag

# zimbra pgp key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9BE6ED79
sudo apt-get install -y apt-transport-https

cat "deb https://repo.zimbra.com/apt/87 xenial zimbra" >> /etc/apt/sources.list

sudo apt-get update

cd /opt/zimbra/install_git
tar xvf /vagrant/zcs.tar.gz
cd zcs-*

#export ZM_CUR_MAJOR=8
#export ZM_CUR_MINOR=7
#export ZM_CUR_MICRO=1

unset ZM_CUR_MAJOR ZM_CUR_MINOR ZM_CUR_MICRO
sudo ./install.sh
