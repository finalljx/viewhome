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
		<xsl:apply-templates select="//viewentry" />
		<li data-role="list-divider"></li>
	</xsl:template>

	<xsl:template match="viewentry">
		<li>
			<input type="checkbox" name="chooseperson" value="{substring-before(substring-after(substring-after(entrydata/.,'^'),'^'),'^')}"/>
			<label><xsl:value-of select="substring-before(substring-after(entrydata/., '^'), '^')"/></label>
		</li>
	</xsl:template>
</xsl:stylesheet>