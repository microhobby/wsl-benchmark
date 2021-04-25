#!/bin/bash

echo "📝 COPYING SCRIPTS"
# copy files to the actual paths
cp bootBenchmark /usr/bin
chmod +x /usr/bin/bootBenchmark

echo "🔙 BACKUP wsl.conf"
# make backup
cp /etc/wsl.conf /etc/wsl.conf.back

echo "🔥 CREATING BOOT SECTION"
# create the boot section on wsl.conf
cat << EOF >> /etc/wsl.conf

[boot]
command=/usr/bin/bootBenchmark

EOF
