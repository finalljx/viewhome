<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<li data-role="list-divider"></li>
		<li data-role="list-divider">
			<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
				<a data-role="button" href="javascript:void(0);" onclick="hideuserselect()">确定</a> 
			</div>
		</li>
		<li>
			<div data-role="fieldcontain">
			    <fieldset data-role="controlgroup">
					<xsl:apply-templates select="//table[@width='100%' and @border='0' and @cellspacing='0' and @cellpadding='0' and @align='center']" />
					<xsl:if test="count(//table[@width='100%' and @border='0' and @cellspacing='0' and @cellpadding='0' and @align='center'])=0">
						<a>无人员</a>
					</xsl:if>
				</fieldset>
			</div>
		</li>
		<li data-role="list-divider"></li>
	</xsl:template>
	<xsl:template match="table">
		<input type="checkbox" id="user{position()}" name="user" onclick="choose(this.checked, '{.//tr[1]/td[2]//span[@class='userName']/text()}')" value="{.//tr[1]/td[2]//span[@class='userName']/text()}"/>
		<label for="user{position()}"><xsl:value-of select="substring-before(.//tr[1]/td[2]//span[@class='userName']/text(), '/')"/></label>
	</xsl:template>
</xsl:stylesheet>