<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<li data-role="list-divider"></li>
		<li data-role="list-divider">
			<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
				<a data-role="button" href="javascript:void(0);" onclick="hideuserselect()">确定</a> 
			</div>
		</li>
		<xsl:apply-templates select="//viewentry" />
		<li data-role="list-divider"></li>
	</xsl:template>

	<xsl:template match="viewentry">
		<li>
			<a href="javascript:userselect('/view/oa/userselect/docapp/indishare/addresstree.nsf/vwdepbyparentcode?readviewentries&amp;count=10000&amp;startkey={entrydata[2]/text/text()}&amp;UntilKey={entrydata[2]/text/text()}0')" data-dom-cache="true" style="text-align:left;">
				<xsl:if test="not(entrydata[3]/text/text()='1')">
					<xsl:attribute name="href">javascript:userselect('/view/oa/userselectuser/docapp/indishare/addresstree.nsf/vwUserBydepPath?readviewentries&amp;restricttocategory=_<xsl:value-of select="entrydata[2]/text/text()"/>_&amp;count=500&amp;start=1')</xsl:attribute>
				</xsl:if>
				<h3><xsl:value-of select="entrydata[1]/."/></h3>
			</a>
			<xsl:if test="entrydata[3]/text/text()='1'">
				<a >
						<xsl:attribute name="data-icon">
							<xsl:value-of select="'arrow-r'"/>
						</xsl:attribute>
						<xsl:attribute name="data-iconpos">
							<xsl:value-of select="'right'"/>
						</xsl:attribute>
					<xsl:attribute name="href">javascript:userselect('/view/oa/userselectuser/docapp/indishare/addresstree.nsf/vwUserBydepPath?readviewentries&amp;restricttocategory=_<xsl:value-of select="entrydata[2]/text/text()"/>_&amp;count=500&amp;start=1')</xsl:attribute>
				</a>
			</xsl:if>
		</li>
	</xsl:template>
</xsl:stylesheet>