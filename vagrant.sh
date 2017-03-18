#!/bin/bash

echo mount opt_zimbra.vdi -> /opt/zimbra 
sudo mkdir -p /opt/zimbra
sudo mount /dev/sdb1 /opt/zimbra

