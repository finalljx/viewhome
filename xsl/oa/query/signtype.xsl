<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="GBK" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates select="//table[@id='sub2']//tbody//tr//td" />
		<xsl:if test="count(//table[@id='sub2']//tbody//tr)=0">
			no
		</xsl:if>
	</xsl:template>
	<xsl:template match="td">
		<xsl:variable name="signStr"><xsl:value-of select="a/@href"/></xsl:variable>
			<xsl:if test="a[contains(@href, 'hqk')]">
				<xsl:value-of select="$signStr"/>
			</xsl:if>
	</xsl:template>
</xsl:stylesheet>
