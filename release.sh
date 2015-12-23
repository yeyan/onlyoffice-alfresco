#!/bin/bash

for dir in "repo" "share"
do
    cd $dir
    gradle clean amp
    cd -
done

rm *amp
find . -iname '*amp' -type f -exec cp '{}' . \;

echo "========== AMPs =========="
ls -1 *.amp

while true; do
    read -p "do you want to install them on update server [y/N]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) exit;;
    esac
done

for host in "update" "update.parashift.com.au"
do
    echo "Deloying on $host"
    find . -maxdepth 1 -iname '*share*amp' -type f -exec echo "installing {}" \; -exec scp '{}' root@$host:/srv/salt_files/alfresco/files/amps_share/ \;
    find . -maxdepth 1 -iname '*repo*amp' -type f -exec echo "installing {}" \; -exec scp '{}' root@$host:/srv/salt_files/alfresco/files/amps/ \;
done
