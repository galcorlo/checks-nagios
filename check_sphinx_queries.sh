#!/bin/bash

# check_sphinx_queries config_files

# nagios
mysql -sN -h0 -P2555 -e 'show status' | grep '^connections\|^command_search\|^queries\|^uptime' | sed 's/\([[:graph:]]\+\)[[:blank:]]\+\([[:digit:]]\+\)/\1=\2/' | tr  '\n' ';' | sed 's/;/ | /;s/;/; /g'

# centreon
mysql -sN -h0 -P2555 -e 'show status' | grep '^connections\|^command_search\|^queries\|^uptime' | sed 's/\([[:graph:]]\+\)[[:blank:]]\+\([[:digit:]]\+\)/\1=\2/' | tr  '\n' ';' | sed 's/;/ | /;s/;/; /g;s/connections/c[connections]/;s/command_search/c[command_search]/;s/queries/c[queries]/'


#/usr/local/bin/searchd --config $1 --status | grep '^connections:\|^command_search:\|^queries:\|^uptime:' | tr '\n' ';' | sed 's/\(uptime: [0-9]\+\) ;/\1 | /g; s/: /=/g; s/ ;/; /'
