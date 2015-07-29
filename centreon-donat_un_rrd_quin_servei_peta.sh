#!/bin/bash

#Et retorna el host i el servei que donen problemes

rrd_id=$1

mysql centreon_storage -N -s -e "select host_name, service_description, metric_name
from index_data
inner join metrics
on index_data.id = metrics.index_id
where metrics.metric_id=$rrd_id"

