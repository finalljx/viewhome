<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="GBK" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates select="//div[@id='viewValue']//table/tbody/tr[position()&gt;1]" />

		<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])=0">
			<li name="more">
				<div style="width:100%;" align="center"><h3>无内容</h3></div>
			</li>
		</xsl:if>
		<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])!=0">
			<li id="moredata"><div id="pullUp" align="center">
				<span class="pullUpLabel">上划加载更多...</span>
			</div></li>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tr">
		<xsl:variable name="formtime"><xsl:value-of select="td[2]/."/></xsl:variable>
        <li data-icon="false" data-time="{$formtime}">
			<xsl:variable name="unid"><xsl:value-of select="td[3]/font/a/@href"/></xsl:variable>
			<a href="javascript:void(0)" onclick="loadsignPageForm(this);" data-unid="{$unid}" data-icon="arrow-r" data-iconpos="right">
				<h3><xsl:value-of select="td[3]/."/></h3>
				<p style="font-size: 14px;line-height: 2em;">
					日期:<font color="#0080FF"><xsl:value-of select="$formtime"/></font>
					状态:<font color="#0080FF"><xsl:value-of select="td[4]/."/></font><br/>
					收文来源:<font color="#0080FF"><xsl:value-of select="td[5]/."/></font>
					处理人:<font color="#0080FF"><xsl:value-of select="substring-before(td[6]/.,'/')"/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
