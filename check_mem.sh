#!/bin/bash
#
# evaluate free system memory from Linux based systems
#
# Date: 2007-11-12
# Author: Thomas Borger - ESG
# jpc tunning
# gab tunning
#
# the memory check is done with following command line:
# free -m | grep buffers/cache | awk '{ print $4 }'
# Suporta també la comanda free que no et fa una línia diferent pels buffers/caches (Centos 7)
# L'alerta de warning/critical salta sense tenir en compte els buffers/caches tal i com fan la resta de plugins
# Si fem saltar l'alerta quan l'ocupació de buffers/caches més used està al 90%, sempre saltaria

# get arguments

while getopts 'w:c:hp' OPT; do
  case $OPT in
    w)  int_warn=$OPTARG;;
    c)  int_crit=$OPTARG;;
    h)  hlp="yes";;
    p)  perform="yes";;
    *)  unknown="yes";;
  esac
done

# usage
HELP="
    usage: $0 [ -w value -c value -p -h ]

    syntax:

            -w --> Warning integer value
            -c --> Critical integer value
            -p --> print out performance data
            -h --> print this help screen
"

if [ "$hlp" = "yes" -o $# -lt 1 ]; then
  echo "$HELP"
  exit 0
fi

# get free memory after flushing buffers and caches
FREEMEMAVAIL=`free | grep buffers/cache | awk '{ print $3 }'`

if [ -z $FREEMEMAVAIL ]; then
#  FREEMEMAVAIL=$(free | grep ^Mem: | awk '{print $2-$3}')
  FREEMEMAVAIL=$(free | grep ^Mem: | awk '{print $7}')
fi

# total memory
TMEM=$(free | grep "^Mem" | awk '{print $2}')

# free memory without flushing buffers and caches
CURRENTFREEMEM=$(free | grep "^Mem" | awk '{print $4}')

# % free memory without flushing buffers and caches
FMEM=$(echo "($CURRENTFREEMEM/$TMEM)*100" | bc -l | sed 's/\..*//g')

# % free memory flushing buffers and caches
FMEM_FREEING_CACHES=$(echo "($FREEMEMAVAIL/$TMEM)*100" | bc -l | sed 's/\..*//g')
USEDMEM_FREEING_CACHES=$((100-$FMEM_FREEING_CACHES))

# % used memory withou flushing buffers and caches. So if we flush buffers we'll get more memory
USEDMEM=$((100-$FMEM))

# output with or without performance data
if [ "$perform" = "yes" ]; then
  OUTPUTP="memory usage: $USEDMEM%; memory usage w/o buffers: $USEDMEM_FREEING_CACHES% | memoryusage=$USEDMEM% mem_usage_without_buffers=$USEDMEM_FREEING_CACHES%;$int_warn;$int_crit"
else
  OUTPUT="memory usage: $USEDMEM%; memory usage w/o buffers: $USEDMEM_FREEING_CACHES%"
fi

if [ -n "$int_warn" -a -n "$int_crit" ]; then

  err=0

  if (( $USEDMEM_FREEING_CACHES >= $int_crit )); then
    err=2
  elif (( $USEDMEM_FREEING_CACHES >= $int_warn )); then
    err=1
  fi

  if (( $err == 0 )); then

    if [ "$perform" = "yes" ]; then
      echo -n "OK - $OUTPUTP"
      exit "$err"
    else
      echo -n "OK - $OUTPUT"
      exit "$err"
    fi

  elif (( $err == 1 )); then
    if [ "$perform" = "yes" ]; then
      echo -n "WARNING - $OUTPUTP"
      exit "$err"
    else
      echo -n "WARNING - $OUTPUT"
      exit "$err"
    fi

  elif (( $err == 2 )); then
    
    if [ "$perform" = "yes" ]; then
      echo -n "CRITICAL - $OUTPUTP"
      exit "$err"
    else
      echo -n "CRITICAL - $OUTPUT"
      exit "$err"
    fi

  fi
  
else
  
  echo -n "no output from plugin"
  exit 3

fi
exit  

