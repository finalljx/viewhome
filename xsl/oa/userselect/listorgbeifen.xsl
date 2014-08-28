<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<li data-role="list-divider"></li>
		<li data-role="list-divider">
			<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
				<a data-role="button" href="javascript:void(0)" onclick="hideuserselect()">确定</a> 
			</div>
		</li>
		<xsl:apply-templates select="//viewentry" />
		<xsl:if test="count(//viewentry)=0">
			<li><a>无组织</a></li>
		</xsl:if>
		<li data-role="list-divider"></li>
	</xsl:template>
	<xsl:template match="viewentry">
		<li>
			<a href="javascript:void(0)" onclick="userselect('/bridge/oa/userselectorg/indishare/addresstree.nsf/vwdepbyparentcode?readviewentries&amp;count=10000&amp;startkey={entrydata[2]/text/text()}&amp;UntilKey={entrydata[2]/text/text()}0')" data-dom-cache="true">
				<xsl:if test="entrydata[3]/text/text()='1'">
					<xsl:attribute name="data-icon">
						<xsl:value-of select="'arrow-r'"/>
					</xsl:attribute>
					<xsl:attribute name="data-iconpos">
						<xsl:value-of select="'right'"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="not(entrydata[3]/text/text()='1')">
					<xsl:attribute name="onclick">userselect('<xsl:text>/bridge/oa/userselectuser/smartdot/addressbook.nsf/myview?openform&amp;view=vwABbyPos&amp;depid=</xsl:text><xsl:value-of select="entrydata[2]/text/text()"/>')</xsl:attribute>
				</xsl:if>
				<img src="/bridge/org.png" style="padding:15px;"/>
				<h3><xsl:value-of select="entrydata[1]/."/></h3>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
