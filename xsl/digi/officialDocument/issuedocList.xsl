<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="endNumber"><xsl:value-of select="//viewentries/viewentry[last()]/@position"/></xsl:variable>
<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
			<xsl:apply-templates select="//viewentries//viewentry" />
			<xsl:if test="count(//viewentries//viewentry)=0">
				<li id="linodata" name="nodata" class="ui-li-static ui-body-inherit ui-first-child ui-last-child">
					<div align="center"><span>无更多内容</span></div>
				</li>
			</xsl:if>
			<xsl:if test="count(//viewentries//viewentry)=10">
				<li id="moredata"><div id="pullUp" align="center">
					<span class="pullUpLabel">上划加载更多...</span>
				</div></li>
			</xsl:if>
	</xsl:template>
	<xsl:template match="viewentry">
		<xsl:variable name="unid"><xsl:value-of select="@unid"/></xsl:variable>
		<li name="lilist" href="#" data-icon="true" class="ui-first-child ui-last-child">
			<a href="javascript:void(0)" onclick="loadIssuedocPage(this);" data-unid="{$unid}" data-endNumber="{$endNumber}" class="ui-btn">
				<h3 style="white-space: normal;">
						<xsl:value-of select="entrydata[4]/."/>
				</h3>
				<p style="font-size: 14px;line-height: 2em;">
					拟稿日期:<font color="#0080FF"><xsl:value-of select="entrydata[2]/."/></font>
					拟稿单位:<font color="#0080FF"><xsl:value-of select="entrydata[3]/."/></font><br/>
					发文字号:<font color="#0080FF"><xsl:value-of select="entrydata[5]/."/></font>
					<!-- 当前环节名称:<font color="#0080FF"><xsl:value-of select="entrydata[8]/."/></font> -->
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
