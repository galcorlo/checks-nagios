#!/bin/bash

# The %MEM field is the number of pages of physical memory the process is using times 100 
# divided by the total number of pages of physical memory. There is no reason it should sum to 100
# consider ten processes that are all using the very same page of physical memory.

OWNER=$1

type nproc >/dev/null 2>&1

if [ $? -eq 0 ]; then
   CORES=$(nproc)
else
   CORES=$(cat /proc/cpuinfo | grep processor | tail -n1 | awk '{print $NF+1}')
fi

#OK /usr/local/bin/searchd CPU: 503.6% MEM: 43.0% over 21 processes | proc=21 mem=43.0% cpu=503.6% rss=28982648.0KB vsz=46400516.0KB


top -u $OWNER -b -n1  | awk -v OWNER=$1 -v CORES=$CORES '{if ($2==OWNER) cpu=cpu+$9; memory=memory+$10; proc=proc+1} END {printf "%s_cpu_usage: %2.2f%% %s_memory_usage: %2.2f%% over %s proc| proc=%s cpu=%2.2f mem=%2.2f\n", OWNER, cpu/CORES, OWNER, memory, proc, proc, cpu/CORES, memory }'
