<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
	<script>
		<![CDATA[
			//客户端时，cookie_userstore
				/*var cookie_userstore = localStorage.getItem("cookie_userstore");
				alert(cookie_userstore);
				$("a[name='signListUser']").each(function(){
					var signListUserHref = $(this).attr('href');
					signListUserNum = signListUserHref.indexOf("data-userstore");
					signListUserHref = signListUserHref.substring(0,signListUserNum)+"data-userstore="+cookie_userstore+"')";
					$(this).attr('href', signListUserHref);
				});**/
			
		]]>
	</script>
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
			<a name="signListUser" href="javascript:userselect('/view/oa/userselect/'+$.hori.getconfig().docServer+'/indishare/addresstree.nsf/vwdepbyparentcode?readviewentries&amp;count=10000&amp;startkey={entrydata[2]/text/text()}&amp;UntilKey={entrydata[2]/text/text()}0&amp;data-userstore=')" data-dom-cache="true" style="text-align:left;">
				<xsl:if test="not(entrydata[3]/text/text()='1')">
					<xsl:attribute name="href">javascript:userselect('/view/oa/userselectuser/'+$.hori.getconfig().docServer+'/indishare/addresstree.nsf/vwUserBydepPath?readviewentries&amp;restricttocategory=_<xsl:value-of select="entrydata[2]/text/text()"/>_&amp;count=500&amp;start=1&amp;data-userstore=')</xsl:attribute>
				</xsl:if>
				<h3><xsl:value-of select="entrydata[1]/."/></h3>
			</a>
			<xsl:if test="entrydata[3]/text/text()='1'">
				<a name="signListUser">
						<xsl:attribute name="data-icon">
							<xsl:value-of select="'arrow-r'"/>
						</xsl:attribute>
						<xsl:attribute name="data-iconpos">
							<xsl:value-of select="'right'"/>
						</xsl:attribute>
					<xsl:attribute name="href">javascript:userselect('/view/oa/userselectuser/'+$.hori.getconfig().docServer+'/indishare/addresstree.nsf/vwUserBydepPath?readviewentries&amp;restricttocategory=_<xsl:value-of select="entrydata[2]/text/text()"/>_&amp;count=500&amp;start=1&amp;data-userstore=')</xsl:attribute>
				</a>
			</xsl:if>
		</li>
	</xsl:template>
</xsl:stylesheet>