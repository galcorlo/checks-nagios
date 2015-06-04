#!/bin/bash

# Si hi ha qualsevol problema al accedir al mysq, al recuperar el desfasament o al guardar la variable al memcached
# esborrem la variable del memcached per seguretat

HOST_DB=campanilla
IP=10.12.64.14
USER=root
PASSWORD=XXXXXXXXXXX
CURRENT_HOST=$(hostname)
MYSQL=/usr/local/mysql/bin/mysql
TEMPS_EXPIRACIO=120

INFO_MYSQL=$($MYSQL -h${IP} -u${USER} -p${PASSWORD} -e "show slave status\G" 2>&1)

if [ $? -ne 0 ]; then
   echo -e 'delete ${HOST_DB}_sec_bm\r' | nc localhost 11211 > /dev/null
   echo "$INFO_MYSQL" | mail -s "Problema recuperant info del slave campanilla desde $CURRENT_HOST" -b tecnics@ivoox.com sistemas@grupointercom.com
   exit -1
fi

SECONDS_BEHIND_MASTER=$(echo -n "$INFO_MYSQL" | sed -n 's/.*Seconds_Behind_Master: //p' 2>&1)

if [ $? -ne 0 ]; then
   echo -e 'delete ${HOST_DB}_sec_bm\r' | nc localhost 11211 > /dev/null
   echo "$SECONDS_BEHIND_MASTER" | mail -s "Problema parsejant info del slave campanilla desde $CURRENT_HOST" -b tecnics@ivoox.com sistemas@grupointercom.com
   exit -1
fi


GUARDA=$(echo -en "set ${HOST_DB}_sec_bm 0 $TEMPS_EXPIRACIO ${#SECONDS_BEHIND_MASTER}\r\n${SECONDS_BEHIND_MASTER}\r\n" | nc localhost 11211)


# El STORED em ve seguir d'un \n que he de tractar

if [ "$GUARDA" != $'STORED\r' ]; then
   echo -e 'delete ${HOST_DB}_sec_bm\r' | nc localhost 11211 > /dev/null
   echo "$SECONDS_BEHIND_MASTER" | mail -s "Problema guardant decalatge de campanilla desde $CURRENT_HOST" -b tecnics@ivoox.com sistemas@grupointercom.com 
   exit -1
fi

