<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="GBK" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates select="//div[@id='viewValue']//table/tbody/tr[position()&gt;1]" />

		<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])=0">
			<li id="more">
				<div style="width:100%;" align="center"><h3>无数据</h3></div>
			</li>
		</xsl:if>
		<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])!=0">
			<div id="pullUp" align="center">
				<span class="pullUpLabel">上划加载更多...</span>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tr">
		<li href="">
			<xsl:variable name="unid"><xsl:value-of select="td[2]/input/@value"/></xsl:variable>
			<a href="javascript:void(0)" onclick="loadPageForm('/view/oamobile/contentmobile/{$unid}');" data-icon="arrow-r" data-iconpos="right">
				<h3><xsl:value-of select="td[3]/."/><xsl:value-of select="td[2]/@value"/></h3>
				<p>
					类型:<font color="#0080FF"><xsl:value-of select="td[4]/."/></font>
					来源:<font color="#0080FF"><xsl:value-of select="td[5]/."/></font>
					状态:<font color="#0080FF"><xsl:value-of select="td[6]/."/></font>
					时间:<font color="#0080FF"><xsl:value-of select="td[7]/."/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
