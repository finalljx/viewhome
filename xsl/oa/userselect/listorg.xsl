<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<li data-icon="false">
			<!-- <div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
				<a data-role="button" href="" onclick="hideuserselect()" data-theme="f">确定</a>
			</div> -->
			<a data-role="button" href="" onclick="hideuserselect()" data-theme="f" style="padding-left: 300;">确定</a>
		</li>
		<li data-role="fieldcontain" style="" class="ui-field-contain ui-body ui-br ui-li ui-li-static ui-btn-up-c ui-last-child">
			<fieldset data-role="controlgroup">
				<legend></legend>
				<xsl:apply-templates select="//select[@id='EntryList_1']//option" />
			</fieldset>
		</li>
		<xsl:if test="count(//select[@id='EntryList_1']//option)=0">
			<li><a>无组织</a></li>
		</xsl:if>
		<li data-role="list-divider"></li>
	</xsl:template>
	<xsl:template match="option">
		<li>
			<input type="radio" name="personval" id="{.}" value="{.}"/><label for="{.}"><xsl:value-of select="substring-before(.,'/')"/></label>
		</li>
	</xsl:template>
</xsl:stylesheet>
