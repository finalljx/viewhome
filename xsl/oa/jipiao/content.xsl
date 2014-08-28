<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		{"xml":[<xsl:apply-templates select="//table[@class='tableClass' and position()=1]"/>]}
	</xsl:template>
	<xsl:template match="table">
		"table":[<xsl:apply-templates />]
	</xsl:template>
	<xsl:template match="tbody">
		<xsl:apply-templates/>
		{}
	</xsl:template>

	<xsl:template match="tr">
		{
			<xsl:apply-templates />
			"fieldentry":{
			"class":"empty",
			"value":"empty"
			}
		},
	</xsl:template>
	<xsl:template match="td">
		"fieldentry":{
		"class":"<xsl:value-of select='@class'/>",
		"value":"<xsl:value-of select='.'/>"
		},
	</xsl:template>
</xsl:stylesheet>
