#!/bin/bash

set -e

if [ -e "/opt/MegaRAID/MegaCli/MegaCli64" ]; then
   MEGACLI='/opt/MegaRAID/MegaCli/MegaCli64'
elif [ -e '/opt/MegaRAID/MegaCli/MegaCli' ]; then
   MEGACLI='/opt/MegaRAID/MegaCli/MegaCli'
else
   echo "No trobo el MegaCli"
   exit 1
fi

OUT=$( ( /opt/MegaRAID/MegaCli/MegaCli64 -LDInfo -L$1 -aALL |  grep '^Default Cache Policy:\|^Current Cache Policy:' ) ) || { echo "Error al Megacli"; exit 1; }  

if [ $(echo "$OUT" | wc -l) -eq 2 ]; then
   default=$(echo "$OUT" | head -n1)
   current=$(echo "$OUT" | tail -n1)


   if [ "$current" != "$default" ]; then
      echo "ERROR - Current Cache Policy differs from Default Cache Policy. $current"
      exit 1
   fi
   
   echo $current
fi


