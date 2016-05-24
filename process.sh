#!/bin/bash

#
# Do a search on metadata records, select the resulting records and then process the records
# using a process XSLT.
#
#
export HOST=http://localhost:8080/geonetwork/srv/eng

# Lazy for now, this could/should be passed in as argument to this shell script
export CRED=admin:admin

# just the name of the container where the cookies are stored for reuse by curl
export COOK=cookies

# search string - don't forget escape chars that might have meaning for the shell - could be passed
# in as an argument to this shell script
export SEARCH="title=GA*\&keyword=Algebra*"

# process XSLT post file - could be passed in as an argument to this shell script
export PROCESS=@processpost.xml

# echo commands
set -x

# Search for metadata records using the supplied search search string
curl -o /dev/null --cookie-jar $COOK -i -w "%{http_code}" -H 'Accept:application/xml' -u $CRED ${HOST}/xml.search\?${SEARCH}

# Select all records returned by search
curl --cookie $COOK -w "%{http_code}" -H 'Accept:application/xml' ${HOST}/xml.metadata.select\?selected=add-all

set +x
read -p "About to process records in GeoNetwork on $HOST, OK? (y/n) " RESPONSE 
if [ "$RESPONSE" != "y" ]; then
	echo "Exiting"
	exit 1
fi

set -x

# Process the records using the supplied process XSLT name - post the file specified by $PROCESS
curl -X POST --connect-timeout 90000000 --max-time 90000000 --cookie $COOK -w "%{http_code}" -H 'Content-type: text/xml' -d ${PROCESS} ${HOST}/xml.metadata.batch.processing

exit 0
