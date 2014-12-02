<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
			<xsl:if test="count(//viewentries//viewentry)!=0">
				<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
					<li data-role="list-divider">附件信息</li>
					<xsl:apply-templates />
				</ul>
			</xsl:if>
	</xsl:template>
	<xsl:template match="a" mode="a">
			<li>
			     <xsl:variable name="url"><xsl:value-of select="@href"/></xsl:variable>
				<a href="javascript:void(0)" data-url="{$url}" onclick="viewfile(this)"><span><xsl:value-of select="font"/></span></a>
			
			</li>
	</xsl:template>
</xsl:stylesheet>