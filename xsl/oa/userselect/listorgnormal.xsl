<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
	<li >
			<div>
				
				<a href="" onclick="hideuserselect()" style="width:40%" class="ui-btn ui-shadow ui-btn-corner-all ui-btn-inline ui-first-child ui-last-child ui-btn-up-f" ><span class="ui-btn-inner"><span class="ui-btn-text">确定</span></span></a>

				<a   href="" onclick='$("#faqdiv").hide()' style="width:40%;float:right"  class="ui-btn ui-shadow ui-btn-corner-all ui-btn-inline ui-first-child ui-last-child ui-btn-up-f" ><span class="ui-btn-inner"><span class="ui-btn-text">取消</span></span></a>
			</div>
			
		</li>
		<li data-role="list-divider">
			
		</li>
		<xsl:apply-templates select="//viewentry//entrydata" />
		<xsl:if test="count(//viewentry//entrydata)=0">
			<li><a>无组织</a></li>
		</xsl:if>
		<li data-role="list-divider"></li>
	</xsl:template>
	<xsl:template match="entrydata">
		<li>
			<input type="radio" name="personval" value="{.}"/><label><xsl:value-of select="substring-before(.,'/')"/></label>
		</li>
	</xsl:template>
</xsl:stylesheet>
