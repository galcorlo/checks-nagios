#!/bin/bash
# Comprova l'ús que fem de la memòria dedicada al eAccelerator

curl -s http://V.X.Y.Z/control.php?sec=0 | awk '{ 
if ( NR==103 ) { 
   match($0, /\>(.+) mb/); 
   TOTAL_MEM=substr( $0, RSTART+1, RLENGTH-4 ) 
} else if (NR ==107) { 
   match($0, /\>(.+) mb/); 
   USED_MEM=substr( $0, RSTART+1, RLENGTH-4 )  
}
} END {
print "used memory: "USED_MEM*100/TOTAL_MEM"% | total_mem= "TOTAL_MEM";;; USED_MEM=" USED_MEM";;;" 
if (USED_MEM*100/TOTAL_MEM > 90){
   exit 1 
}
}'
