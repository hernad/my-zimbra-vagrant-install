#!/bin/bash


if [ ! -f data_zimbra_dev.vdi ] ;  then
    VBoxManage clonemedium ~/data_zimbra_dev.vdi data_zimbra_dev.vdi
else
	echo "data_zimbra_dev.vdi already exists"
fi


