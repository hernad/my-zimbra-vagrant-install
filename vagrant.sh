#!/bin/bash

echo "hello vagrant world"

echo zimbra 8.7.1 - jdk7 is mandatory

export JAVA_HOME=/usr/lib/jvm/java-7-oracle


sudo update-alternatives --set java /usr/lib/jvm/java-7-oracle/bin/java


if ( ! mount | grep -q \/data ) ; then
   sudo mount /dev/sdb1 /data
else
   echo /data mounted
fi


echo zimbra foss monolith tree \(8.7.1\)

cd /data/zimbra-foss
cd ZimbraBuild

./buildZCS.sh
