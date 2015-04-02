<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="startNumber"><xsl:value-of select="//viewentries/viewentry[1]/@position"/></xsl:variable>
<xsl:variable name="endNumber"><xsl:value-of select="//viewentries/viewentry[last()]/@position"/></xsl:variable>
<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
	        <xsl:apply-templates select="//viewentries//viewentry" />
			<xsl:if test="count(//viewentries//viewentry)=0">
				<li name="nodata" class="ui-li-static ui-body-inherit ui-first-child ui-last-child">
					<div style="width:100%;" align="center"><span>无更多内容</span></div>
				</li>
			</xsl:if>
			<xsl:if test="count(//viewentries//viewentry)=10">
				<li id="moredata" name="nodata"><div id="pullUp" align="center">
					<span class="pullUpLabel">上划加载更多...</span>
				</div></li>
			</xsl:if>
	</xsl:template>
	<xsl:template match="viewentry">
		<xsl:variable name="unid"><xsl:value-of select="@unid"/></xsl:variable>
		<li name="lilist" href="#" data-icon="true" class="ui-first-child ui-last-child" style="height: 75px;">
			<a href="javascript:void(0)" style="line-height: 16px;height: 60px;padding-top: 4px;" onclick="loadPageForm(this);" data-unid="{$unid}" data-startNumber="{$startNumber}" data-endNumber="{$endNumber}" class="ui-btn">
				<h3 style="white-space: normal;">
						<xsl:value-of select="entrydata[4]/."/>
				</h3>
				<p style="font-size: 14px;">
					发布日期:<font ><xsl:value-of select="substring(entrydata[1]/.,1,10)"/></font>
					起草人:<font><xsl:value-of select="entrydata[6]/."/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>