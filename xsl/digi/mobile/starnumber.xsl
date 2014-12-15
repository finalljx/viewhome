<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
	<xsl:if test="count(//viewentries//viewentry)!=0">
<xsl:value-of select="//viewentries/viewentry[1]/@position"/>
			
			</xsl:if>
   	
	</xsl:template>
</xsl:stylesheet>