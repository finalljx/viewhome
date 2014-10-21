<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
	<div id="wrapper" style="overflow: scroll;">
		<div id="scroller">
		<ul  data-role="listview" data-inset="true" class="ui-listview ui-listview-inset ui-corner-all ui-shadow" style="margin-top: 30px;">
			
			<xsl:apply-templates select="//div[@id='viewValue']//table/tbody/tr[position()&gt;1]" />
			<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])=0">
				<li><a>无内容</a></li>
			</xsl:if>
			<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])!=0">
				<li id="moredata" class="ui-li-static ui-body-inherit ui-last-child">
				<div id="pullUp" align="center" class="">
				<span class="pullUpLabel">上拉加载更多...</span>
				</div></li>
				<li class="ui-li-static ui-body-inherit ui-last-child"></li>
			</xsl:if>
		</ul>
		</div>
	</div>
	</xsl:template>
	<xsl:template match="tr">
		<xsl:variable name="unid"><xsl:value-of select="td[2]/input/@value"/></xsl:variable>
		<xsl:variable name="type"><xsl:value-of select="td[4]/."/></xsl:variable>
		<xsl:variable name="state"><xsl:value-of select="td[6]/."/></xsl:variable>
		<xsl:if test="$state!='正在起草'">
			<li href="#" data-icon="false" class="ui-first-child ui-last-child">
				<a href="javascript:void(0)" onclick="loadPageForm(this);" data-unid="{$unid}"	data-type="{$type}" class="ui-btn">
					<h3 style="white-space: normal;">
						<span data-bind="text: contentTitle">
							<xsl:value-of select="td[3]/."/><xsl:value-of select="td[2]/@value"/>
						</span>
					</h3>
					<p>
						类型:<font color="#0080FF"><xsl:value-of select="td[4]/."/></font>
						来源:<font color="#0080FF"><xsl:value-of select="td[5]/."/></font>
						状态:<font color="#0080FF"><xsl:value-of select="td[6]/."/></font>
						时间:<font color="#0080FF"><xsl:value-of select="td[7]/."/></font>
					</p>
				</a>
			</li>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
