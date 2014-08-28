<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<xsl:if test="contains(//envelope/., '/')">
			<xsl:value-of select="translate(substring-after(//envelope/., '/'), '/', '-')"/>
		</xsl:if>
		<xsl:if test="not(contains(//envelope/., '/'))">
			<xsl:value-of select="translate(//envelope/., '/', '-')"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
