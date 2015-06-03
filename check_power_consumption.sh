#!/bin/bash

VALORS=$(/usr/sbin/ipmi-sensors -g Current --no-header-output --legacy-output 2> /dev/null)

if [ $? -ne 0 ]; then
   VALORS=$(/usr/sbin/ipmi-sensors -g Current)
   if [ $? -ne 0 ]; then
      echo "ipmi-sensors no ha funcionat $VALORS"
      exit 1
   fi
fi

echo "$VALORS" | awk '/^[0-9]+: (.+) \(Current\): (.+) A .+: \[(.+)\]/ { 
   camp=gensub(/^[0-9]+: (.+) \(Current\): (.+) A .+: \[(.+)\]/, "\\1", "g", $0);
   ampers=gensub(/^[0-9]+: (.+) \(Current\): (.+) A .+: \[(.+)\]/, "\\2", "g", $0);
   estat=gensub(/^[0-9]+: (.+) \(Current\): (.+) A .+: \[(.+)\]/, "\\3", "g", $0);
   gsub(/ /, "", camp);
   estat_total=estat_total camp"="estat" ";
   perfdata=perfdata" "camp "=" ampers"; ";
   total_ampers+=ampers;
   sortida=sortida camp"="estat" ("ampers") ";
}
END {
print total_ampers"A "sortida" | " perfdata;
}'
