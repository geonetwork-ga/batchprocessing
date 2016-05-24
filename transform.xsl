<?xml version="1.0" encoding="UTF-8"?>

<!-- This XSLT will process XML records in GeoNetwork it is intended to be used
     as part of the xml.metadata.batch.processing service - the parameter -->

<!-- Include commonly used ISO19115-3 namespaces in preparation for processing these
     documents -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0"
  xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
  xmlns:mri="http://standards.iso.org/iso/19115/-3/mri/1.0"
  xmlns:mrs="http://standards.iso.org/iso/19115/-3/mrs/1.0"
  xmlns:mrd="http://standards.iso.org/iso/19115/-3/mrd/1.0"
  xmlns:mco="http://standards.iso.org/iso/19115/-3/mco/1.0"
  xmlns:msr="http://standards.iso.org/iso/19115/-3/msr/1.0"
  xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0"
  xmlns:gcx="http://standards.iso.org/iso/19115/-3/gcx/1.0"
  xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0"
  xmlns:mdq="http://standards.iso.org/iso/19157/-2/mdq/1.0"
  xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/1.0"
  xmlns:mrl="http://standards.iso.org/iso/19115/-3/mrl/1.0"
  xmlns:mmi="http://standards.iso.org/iso/19115/-3/mmi/1.0"
  xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0"
  xmlns:gml="http://www.opengis.net/gml/3.2"
	xmlns:xlink="http://www.w3.org/1999/xlink">

  <!-- We will produce an output document that is XML, so indent the elements nicely in order
       to retain readability -->
	<xsl:output method="xml" indent="yes"/>

	<!-- ================================================================= -->
  <!-- Match cit:CI_OnlineResource elements that have blank or missing cit:protocol and linkage that starts with file://.... and parent = 'mrd:onLine' -->
	    
  <xsl:template match="cit:CI_OnlineResource[normalize-space(cit:protocol/gco:CharacterString)='' and starts-with(cit:linkage/gco:CharacterString,'file://') and name(..)='mrd:onLine']">
	   <!-- start off with xsl:copy to copy the cit:CI_OnlineResource element -->
		 <!-- Can't help feeling that the file://nas../ in cit:linkage is a bit 
		      useless, Shouldn't it be something like we see in find eg:
					https://d28rz98at9flks.cloudfront.net/10001/Rec1942_005.pdf??? -->
	   <xsl:copy>
       <xsl:copy-of select="cit:linkage"/> <!-- copy the linkage as is -->
			 <cit:protocol>
			   <gco:CharacterString>WWW:LINK-1.0-http--link</gco:CharacterString>
			 </cit:protocol>
       <xsl:copy-of select="*[name()!='cit:linkage']"/> <!-- copy any others -->
		 </xsl:copy>
  </xsl:template>

	<!-- ================================================================= -->
  <!-- Match any element (node()) or attribute @* and copy it, then apply templates to the 
       children of this element ie. recursively process the entire input document -->
	<xsl:template match="@*|node()">
		 <xsl:copy>
			  <xsl:apply-templates select="@*|node()"/>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

</xsl:stylesheet>
