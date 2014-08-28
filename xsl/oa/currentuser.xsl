<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<xsl:value-of select="substring-after(//td[@class='viewtotal']/a/@href, 'restricttocategory=')"/>
	</xsl:template>
</xsl:stylesheet>
