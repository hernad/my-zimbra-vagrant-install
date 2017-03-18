#!/bin/bash


if ! sudo fdisk -l  /dev/sdb1
then
  sudo parted /dev/sdb mkpart primary ext4 20.5GiB 100%
  sudo mkfs.exe /dev/sdb1 
fi

echo mount opt_zimbra.vdi -> /opt/zimbra 
sudo mkdir -p /opt/zimbra
sudo mount /dev/sdb1 /opt/zimbra

