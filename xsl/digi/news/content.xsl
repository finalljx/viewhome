<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>							
				
				
				<style>
					pre {
						white-space: pre-wrap;
						white-space: -moz-pre-wrap;
						white-space: -pre-wrap;
						white-space: -o-pre-wrap;
						word-wrap: break-word;
					}
					
					.ui-li-desc{
						white-space:normal;;
					}
				</style>
				
				
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<script type="text/javascript">
							function viewfile(url){
								url=decodeURI(url);
								localStorage.setItem("attachmentUrl",url);
								$.hori.loadPage( $.hori.getconfig().serverBaseUrl+"viewhome/html/attachmentShowForm.html", $.hori.getconfig().serverBaseUrl+"viewhome/xml/AttachView.xml");
							}
						</script>
						<div align="center" style="width:100%">
							<strong><xsl:value-of select="//title/text()"/></strong>
						</div>
						<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
							<ul data-role="listview" data-inset="true">
							<li data-role="list-divider">正文内容</li>
							<li>
								<div style="width:100%;text-align:left" align="left">
										<xsl:apply-templates select="//div[@name='Fck_HTML']/."/>
								</div>

							</li>
							<li data-role="list-divider">附件信息</li>
							<li>
								<xsl:if test="count(//table[@style='height:100%;width2:100%;border:0']/tbody/tr[2]//a)=0">
									无附件
								</xsl:if>
								<xsl:if test="count(//table[@style='height:100%;width2:100%;border:0']/tbody/tr[2]//a)!=0">
									<xsl:apply-templates select="//table[@style='height:100%;width2:100%;border:0']/tbody/tr[2]//a" mode="file"/>
								</xsl:if>
							</li>
							</ul>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="a" mode="file">
		<xsl:if test="contains(@onclick, 'JPG')">
			<xsl:variable name="path" select="substring-before(substring-after(@onclick, '/'), 'JPG')"/>
			<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/{$path}JPG');" data-role="button"><xsl:value-of select="."/></a></li>	
		</xsl:if>
		<xsl:if test="contains(@onclick, 'jpg')">
			<xsl:variable name="path" select="substring-before(substring-after(@onclick, '/'), 'jpg')"/>
			<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/{$path}jpg');" data-role="button"><xsl:value-of select="."/></a></li>	
		</xsl:if>
		<xsl:if test="contains(@onclick, 'bmp')">
			<xsl:variable name="path" select="substring-before(substring-after(@onclick, '/'), 'bmp')"/>
			<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/{$path}bmp');" data-role="button"><xsl:value-of select="."/></a></li>	
		</xsl:if>
			<xsl:if test="contains(@onclick, 'docx')">
			<xsl:variable name="path" select="substring-before(substring-after(@onclick, '/'), 'docx')"/>
			<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/{$path}docx');" data-role="button"><xsl:value-of select="."/></a></li>	
		</xsl:if>
	
	</xsl:template>

	<xsl:template match="pre">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="br">
		<br/>
	</xsl:template>

	<xsl:template match="img">
		<div style="width:100%" align="center">
			<img src="view/oa/image{translate(@src, '&quot;', '')}" width="80%"/>
		</div>
	</xsl:template>
	<xsl:template match="p">
		<xsl:if test="contains(@style, 'text-indent:')">
			&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
		</xsl:if>
		
		<xsl:choose>
		<xsl:when test="contains(@style, 'text-align: right')">
			<div style="%100" align="right"><xsl:apply-templates /></div>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text></xsl:text><xsl:apply-templates />
		</xsl:otherwise>
		</xsl:choose>
		<br/>
	</xsl:template>

	
	
	
	<xsl:template match="table" mode="c1">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tbody" mode="c2">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tr" mode="c2">
		<xsl:if test="position()=1 or position()=2">
			<!--<div style="width:100%" align="center">
				<xsl:value-of select=".//q/." />
			</div>-->
		</xsl:if>
		<xsl:if test="not(position()=1 or position()=2)">
			<div style="width:100%" align="left">
				<xsl:attribute name="align">
					<xsl:if test="not(position()=2 or position()=4)">left</xsl:if>
				</xsl:attribute>
				<xsl:apply-templates mode="c3"/>
			</div>
		</xsl:if>
		<hr/>
	</xsl:template>

	<xsl:template match="td" mode="c3">
		<xsl:if test="not(@style) or not(contains(@style, 'display:none'))">
			<!-- 发文红色字体特殊处理 -->
			<xsl:choose>
				<xsl:when test="@class='DF_GTable_LTD_Style'">
					<span style="width:38%;display:inline-block;text-align:right"><font color="red"><xsl:value-of select="."/></font></span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="c4"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@class='DF_GTable_RTD_Style'">
				<br/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="c4">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="div" mode="c4">
		<xsl:apply-templates mode="c4"/>
	</xsl:template>	
	<xsl:template match="q" mode="c4">
		<xsl:apply-templates mode="c4"/>
	</xsl:template>
	<xsl:template match="p" mode="c4">
		
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="br" mode="c4">
		
		<br/>
	</xsl:template>
	<xsl:template match="b" mode="c4">
		<xsl:if test="normalize-space(.)!=''">
			<strong><xsl:apply-templates mode="c4"/></strong>
		</xsl:if>
	</xsl:template>
	<xsl:template match="center" mode="c4">
		<span width="100%" align="center" mode="c4">
			<xsl:apply-templates mode="c4"/>
		</span>
	</xsl:template>
	<xsl:template match="font" mode="c4">
		<font>
			<xsl:apply-templates mode="c4"/>
		</font>
	</xsl:template>
	<xsl:template match="input" mode="c4">
		<xsl:value-of select="@value"/>
	</xsl:template>
	<xsl:template match="select" mode="c4">
		<xsl:if test="starts-with(@name, 'fld')">
			<xsl:value-of select="option[@selected='selected']/text()"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="textarea" mode="c4">
		<xsl:value-of select="text()"/>
	</xsl:template>
	<xsl:template match="hr" mode="c4">
		<hr size="{@size}">
			<xsl:attribute name="color">
				<xsl:call-template name="color">
					<xsl:with-param name="name"><xsl:value-of select="@color" /></xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
		</hr>
	</xsl:template>

	<xsl:template match="img" mode="c4">
	</xsl:template>
	<xsl:template name="color">
		<xsl:param name="name" />
		<xsl:choose>
			<xsl:when test="@color='red'">
				<xsl:text>#FF0000</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>#FF0000</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
			