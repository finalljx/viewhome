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
						<h1>组织列表</h1>
						<a data-icon="home" data-role="button" href="/bridge/home.html">首页</a>
					</div><!-- /header -->
				
					<div data-role="content" align="center">
						<ul data-role="listview" data-inset="true" data-theme="d">
							<li data-role="list-divider"></li>
							<xsl:apply-templates select="//viewentry" />
							<xsl:if test="count(//viewentry)=0">
								<li><a>无组织</a></li>
							</xsl:if>
							<li data-role="list-divider"></li>
						</ul>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="viewentry">
		<li>
			<a href="/bridge/oa/orglist/indishare/addresstree.nsf/vwdepbyparentcode?readviewentries&amp;count=10000&amp;startkey={entrydata[2]/text/text()}&amp;UntilKey={entrydata[2]/text/text()}0" data-dom-cache="true">
				<xsl:if test="entrydata[3]/text/text()='1'">
					<xsl:attribute name="data-icon">
						<xsl:value-of select="'arrow-r'"/>
					</xsl:attribute>
					<xsl:attribute name="data-iconpos">
						<xsl:value-of select="'right'"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="not(entrydata[3]/text/text()='1')">
					<xsl:attribute name="href">
						<xsl:text>/bridge/oa/userlist/smartdot/addressbook.nsf/myview?openform&amp;view=vwABbyPos&amp;depid=</xsl:text>
						<xsl:value-of select="entrydata[2]/text/text()"/>
					</xsl:attribute>
				</xsl:if>
				<img src="/bridge/org.png" style="padding:15px;"/>
				<h3><xsl:value-of select="entrydata[1]/."/></h3>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
