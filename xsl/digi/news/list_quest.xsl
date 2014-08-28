<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="//flag/text()!='false'">
				{"success":true,"dir1":"<xsl:value-of select="//dir1"/>" , "dir2":"<xsl:value-of select="//dir2"/>", "dir3":"<xsl:value-of select="//dir3"/>"}
			</xsl:when>
			<xsl:otherwise>{"success":false,"dir1":"","dir2":"","dir3":""}</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>