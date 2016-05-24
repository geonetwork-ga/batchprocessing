* Files:
--------

process.sh - will process the xslt transform.xsl in GeoNetwork on the host 
specified (edit process.sh to find out) - bash script run it on linux machine
This script searches for and selects a set of records, then runs the 
xml.batch.processing service - which applies transform.xsl to all selected
records.

transform.xsl - can be run in this directory or as part of GeoNetwork.
Basically it is the same as identity.xsl in that it copies all elements from
the input record to the output record. The difference is that transform.xsl
looks for cit:CI_OnlineResource without a protocol and does some processing
on it.

* To test transform.xsl outside of GeoNetwork:
----------------------------------------------

java -jar saxon.jar -i test-metadata.xml -o output.xml transform.xsl

* To use transform.xsl in GeoNetwork with process.sh:
-----------------------------------------------------

Copy transform.xsl to this path in your checked out source tree:

schemaPlugins/iso19115-3/process 

Then rebuild and re-deploy your web application.

Otherwise copy it directly toyour deployed webapp (if you can):

web/geonetwork/WEB-INF/data/config/schema_plugins/iso19115-3/process 

You will need to restart your webapp if you make changes to transform.xsl.

Best to test outside of GeoNetwork many times and be sure you have it right!
----------------------------------------------------------------------------
----------------------------------------------------------------------------
