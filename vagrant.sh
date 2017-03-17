#!/bin/bash

echo "hello vagrant world"



if ( ! mount | grep -q \/data ) ; then
   sudo mount /dev/sdb1 /data
else
   echo /data mounted
fi


echo zimbra foss monolith tree \(8.7.1\)

cd /data/zimbra-foss
cd ZimbraBuild

./buildZCS.sh
