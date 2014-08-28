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
				<div data-role="page" class="type-home">
					<div data-role="header">
						<a data-icon="home" data-role="button" data-rel="back">返回</a>
						<h1>人员列表</h1>
						<a data-icon="home" data-role="button" href="/bridge/home.html">首页</a>
					</div><!-- /header -->
				
					<div data-role="content" align="center">
						<ul data-role="listview" data-inset="true" data-theme="d">
							<li data-role="list-divider"></li>
							<xsl:apply-templates select="//table[@width='100%' and @border='0' and @cellspacing='0' and @cellpadding='0' and @align='center']" />
							<xsl:if test="count(//table[@width='100%' and @border='0' and @cellspacing='0' and @cellpadding='0' and @align='center'])=0">
								<li><a>无人员</a></li>
							</xsl:if>
							<li data-role="list-divider"></li>
						</ul>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="table">
		<li>
			<img src="/bridge/person.png" style="padding:15px;"/>
			<h3>
				<xsl:if test="contains(.//tr[1]/td[2]//span[@class='userName']/text(), '/')">
					<xsl:value-of select="substring-before(.//tr[1]/td[2]//span[@class='userName']/text(), '/')"/>
				</xsl:if>
				<xsl:if test="not(contains(.//tr[1]/td[2]//span[@class='userName']/text(), '/'))">
					<xsl:value-of select=".//tr[1]/td[2]//span[@class='userName']/text()"/>
				</xsl:if>
			</h3>
			<p>
				<xsl:if test="not(contains(.//tr[2]/td[1]/., 'null'))">
					<xsl:value-of select=".//tr[2]/td[1]/."/>
				</xsl:if>
				<xsl:if test="not(contains(.//tr[3]/., 'null'))">
					<xsl:value-of select=".//tr[3]/."/>	
				</xsl:if>
			</p>
		</li>
	</xsl:template>
</xsl:stylesheet>
