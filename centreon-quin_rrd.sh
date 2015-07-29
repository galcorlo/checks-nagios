#!/bin/bash

# Exemple d'ús: ./quin_rrd.sh nutt CPU_Usage

# ./quin_rrd.sh servidor servei

hostname=$1
servei=$2

RRD=$(mysql centreon_storage -N -s -e "select metric_id as rrd 
from metrics 
inner join index_data
on metrics.index_id = index_data.id
where index_data.host_name='$hostname' 
and index_data.service_description='$servei';")


echo "/var/lib/centreon/metrics/$RRD.rrd"

