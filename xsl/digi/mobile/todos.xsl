<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
			<xsl:apply-templates select="//viewentries//viewentry" />
			<xsl:if test="count(//viewentries//viewentry)=0">
				<li name="nodata" class="ui-li-static ui-body-inherit ui-first-child ui-last-child">
					<div style="width:100%;" align="center"><span>无更多内容</span></div>
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
		<xsl:variable name="dbpath"><xsl:value-of select="entrydata[5]/."/></xsl:variable>
		<xsl:variable name="mobile"><xsl:value-of select="entrydata[7]/."/></xsl:variable>
		<li name="lilist" href="#" data-icon="true" class="ui-first-child ui-last-child">
			<a href="javascript:void(0)" onclick="loadTodoPageForm(this);" data-unid="{$unid}" data-mobile="{$mobile}" data-dbpath="{$dbpath}" class="ui-btn" style="line-height: 14px;">
				<xsl:if test="$mobile='yes'">
					<img style="width: 50px;height: 50px;margin-top: 3px;" src="../assets/home/items/module-res/phone.png"/>
				</xsl:if>
				<xsl:if test="$mobile!='yes'">
					<img style="width: 50px;height: 50px;margin-top: 3px;" src="../assets/home/items/module-res/PC.png"/>
				</xsl:if>
				<h3 style="white-space: normal;margin-left: -3.5em;">
					<span>
						<xsl:value-of select="entrydata[2]/."/>
					</span>
				</h3>
				<p style="font-size: 14px;margin-left:-3.5em;">
					时间:<font><xsl:value-of select="entrydata[1]/."/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
