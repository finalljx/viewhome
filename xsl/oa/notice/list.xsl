<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:variable name="start"><xsl:value-of select="//input[@name='start']/@value"/></xsl:variable>
	<xsl:variable name="count"><xsl:value-of select="//input[@name='count']/@value"/></xsl:variable>
	<xsl:variable name="total"><xsl:value-of select="//input[@name='total']/@value"/></xsl:variable>
	<xsl:variable name="currentPage"><xsl:value-of select="floor($start div $count)+1"/></xsl:variable>
	<xsl:variable name="totalPage"><xsl:value-of select="floor(($total - 1) div $count)+1"/></xsl:variable>
	<xsl:variable name="nextStart"><xsl:value-of select="($currentPage * $count) + 1"/></xsl:variable>
	<xsl:variable name="preStart"><xsl:value-of select="$nextStart - $count - $count"/></xsl:variable>

	<xsl:template match="/">
		<html lang="zh_cn">
			<head></head>
			<body>
				<div data-role="page" data-iscroll="enable" class="type-home">
					<div data-role="header">
						<a data-icon="home" data-role="button" href="/bridge/home.html">返回</a>
						<h1>通知公告</h1>
					</div><!-- /header -->
				
					<div data-role="content" align="center">
						<ul data-role="listview" data-inset="true">
							<li data-role="list-divider"></li>
							<li data-role="list-divider">
								<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
									<xsl:if test="$currentPage!=1">
										<a data-role="button" href="/bridge/oa/noticelist/smartdot/reed_gstg.nsf/myview?openform&amp;view=vwPubliced&amp;count=20&amp;start={$preStart}">上一页</a> 
									</xsl:if>
									<a data-role="button"><xsl:value-of select="$currentPage"/>/<xsl:value-of select="$totalPage"/></a> 
									<xsl:if test="$currentPage&lt;$totalPage">
										<a data-role="button" href="/bridge/oa/noticelist/smartdot/reed_gstg.nsf/myview?openform&amp;view=vwPubliced&amp;count=20&amp;start={$nextStart}">下一页</a> 
									</xsl:if>
								</div>
							</li>
							<xsl:apply-templates select="//div[@id='viewValue']//table/tbody/tr[position()&gt;1]" />
							<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])=0">
								<li><a>无内容</a></li>
							</xsl:if>
							<li data-role="list-divider"></li>
						</ul>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="tr">
		<li href="">
			<a href="/bridge/oa/noticecontent{td[4]/a/@href}" data-icon="arrow-r" data-iconpos="right">
				<h3><xsl:value-of select="td[4]/."/></h3>
				<p>时间:<xsl:value-of select="td[3]/."/></p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
