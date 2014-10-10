<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<li data-role="list-divider"></li>
		<li data-role="list-divider">
			<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
				<a data-role="button" href="javascript:void(0);" onclick="hideuserselect()">确定</a> 
			</div>
		</li>
		<xsl:apply-templates select="//viewentry" />
		<li data-role="list-divider"></li>
	</xsl:template>

	<xsl:template match="viewentry">
		<li>
			<input type="checkbox" name="chooseperson" value="{entrydata/.}"/>
			<label><xsl:value-of select="substring-before(substring-after(entrydata/., '^'), '^')"/></label>
		</li>
	</xsl:template>
</xsl:stylesheet>