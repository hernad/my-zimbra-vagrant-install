#!/bin/bash

echo "hello vagrant world"



if ( ! mount | grep -q \/data ) ; then
   sudo mount /dev/sdb1 /data
else
   echo /data mounted
fi


cd /data/zimbra
cd ZimbraBuild
./buildZCS.sh

