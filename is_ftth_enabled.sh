#!/bin/bash

BO="traceroute -In 8.8.8.8 -N1
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  172.20.0.1  0.398 ms  0.388 ms  0.408 ms
 2  194.116.240.27  1.924 ms  4.049 ms  7.955 ms
 3  194.110.201.2  1.300 ms  1.148 ms  1.137 ms
 4  10.3.3.25  1.616 ms  1.230 ms  1.163 ms
 5  213.229.187.171  1.552 ms  1.665 ms  1.283 ms
 6  72.14.218.6  15.570 ms  15.520 ms  15.470 ms
 7  209.85.254.107  15.807 ms  16.079 ms  16.463 ms
 8  8.8.8.8  15.442 ms  15.476 ms  15.527 ms
"

CURRENT=$(traceroute -In 8.8.8.8 -N1 | awk '{if (NR>1 && NR<6) print $2}' | tr '\n' ' ')

if [ -f /tmp/traceroute-google.txt ]; then
   if [ "$CURRENT" != "$(cat /tmp/traceroute-google.txt)" ]; then
      CURRENT_VERBOSE=$(traceroute -In 8.8.8.8 -N1)
      echo -e "Running traceroute from: $(hostname) \n\n $CURRENT_VERBOSE \n\n Quan va bé ha de sortir això: \n\n $BO" | mail -s "[NETWORKING] WARNING - Potser oficines Barcelona està sortint pel FTTH" sistemas@grupointercom.com
   fi
fi

echo -n "$CURRENT" > /tmp/traceroute-google.txt

