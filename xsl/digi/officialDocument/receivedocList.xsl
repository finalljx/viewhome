<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
			<xsl:apply-templates select="//viewentries//viewentry" />
			<xsl:if test="count(//viewentries//viewentry)=0">
				<li id="linodata" name="nodata" class="ui-li-static ui-body-inherit ui-first-child ui-last-child">
					<div align="center"><h3>无内容</h3></div>
				</li>
			</xsl:if>
			<xsl:if test="count(//viewentries//viewentry[position()&gt;1])!=0">
				<li id="moredata"><div id="pullUp" align="center">
					<span class="pullUpLabel">上划加载更多...</span>
				</div></li>
			</xsl:if>
	</xsl:template>
	<xsl:template match="viewentry">
		<xsl:variable name="unid"><xsl:value-of select="@unid"/></xsl:variable>
		<li name="lilist" href="#" data-icon="true" class="ui-first-child ui-last-child">
			<a href="javascript:void(0)" onclick="loadReceivedocPage(this);" data-unid="{$unid}" class="ui-btn">
				<h3 style="white-space: normal;">
					<xsl:value-of select="entrydata[4]/."/>
				</h3>
				<p style="font-size: 14px;line-height: 2em;">
					收文日期:<font color="#0080FF"><xsl:value-of select="entrydata[2]/."/></font>
					来文单位:<font color="#0080FF"><xsl:value-of select="entrydata[3]/."/></font><br/>
					当前处理人:<font color="#0080FF"><xsl:value-of select="entrydata[6]/."/></font>
					当前环节名称:<font color="#0080FF"><xsl:value-of select="entrydata[7]/."/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
