#!/bin/bash

DEV_SERVER=onlyoffice
INSTALL_DIR=/var/lib/tomcat7/webapps/alfresco/WEB-INF/lib

gradle clean build
find build -iname '*jar' -type f -exec scp '{}' root@$DEV_SERVER:$INSTALL_DIR \;
docker exec onlyoffice service tomcat7 restart
