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
