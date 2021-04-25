#!/bin/bash

# copy files to the actual paths
cp bootBenchmark /usr/bin
chmod +x /usr/bin/bootBenchmark

# make backup
cp /etc/wsl.conf /etc/wsl.conf.back

# create the boot section on wsl.conf
cat << EOF >> /etc/wsl.conf

[boot]
command=/usr/bin/bootBenchmark

EOF
