<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head></head>
			<body>
				<div id="notice" data-role="page" class="type-home">
					<div data-role="header">
						<a data-icon="home" data-role="button" data-rel="back" data-direction="reverse">返回</a>
						<h1>公告内容</h1>
					</div><!-- /header -->
					<div data-role="content" align="center">
						<style>
							.tableClass {
								border-bottom: #555555 1px solid; border-left: #555555 1px solid; border-collapse: collapse; border-top: #555555 1px solid; border-right: #555555 1px solid; width:100%;
							}
							.tdTitle {
								border-bottom: #555555 1px solid; text-align: center; border-left: #555555 1px solid; background-color: #e4e4e4; font: bold 14pt "宋体"; height: 27px; vertical-align: middle; border-top: #555555 1px solid; border-right: #555555 1px solid
							}
							.tdLabel {
								border-bottom: #555555 1px solid; text-align: right; border-left: #555555 1px solid; background-color: #e4e4e4; font: 9pt 宋体; height: 25px; vertical-align: middle; border-top: #555555 1px solid; border-right: #555555 1px solid
							}
							.tdLabeld {
								border-bottom: #555555 1px solid; text-align: left; border-left: #555555 1px solid; background-color: #e4e4e4; font: 9pt 宋体; height: 25px; vertical-align: middle; border-top: #555555 1px solid; border-right: #555555 1px solid
							}
							.tdContent {
								border-bottom: #555555 1px solid; border-left: #555555 1px solid; background-color: #fafafa; font: 9pt 宋体; WORD-WRAP: break-word; height: 25px; vertical-align: middle; WORD-BREAK: break-all; border-top: #555555 1px solid; border-right: #555555 1px solid
							}
						</style>
						<script>
							<![CDATA[
							$( document ).delegate("#notice", "pagebeforecreate", function() {
								$('#notice ul').html($('#notice ul').html().replace(new RegExp("&amp;","gm"),"&"));
								var atts = $('#notice a[mark="att"]');
								for(var i=0; i<atts.length; i++){
									if($(atts[i]).attr("href").indexOf("javascript:void(0);")==-1){
										$(atts[i]).attr("onclick", "mj.viewfile('" + $(atts[i]).attr("href") + "');");
										$(atts[i]).attr("href", "javascript:void(0);");
										$(atts[i]).removeAttr("target");
									}
								}
								var scris = $('#notice script');
								for(var i=0; i<scris.length; i++){
									$(scris[i]).removeAttr("src");
								}
							});
							]]>
						</script>
						<ul data-role="listview" data-inset="true">
							<li data-role="list-divider"></li>
							<li>
								<div style="100%;text-align:center;">
									<div align="left" style="background-color:#424142;color:#FFFFFF;padding:5px;">
										<strong>基本信息</strong>
									</div>
									<div style="width:100%">
										<div align="center">
											<xsl:copy-of select="//table[@class='tableClass']"/>
										</div>
									</div>
									<div align="left" style="background-color:#424142;color:#FFFFFF;padding:5px;">
										<strong>正文</strong>
									</div>
									<div style="width:100%">
										<div align="center">
											<xsl:copy-of select="//table[@id='tabsContent' and @width='90%' and @align='center']"/>
										</div>
									</div>
								</div>
							</li>
						</ul>
						<script>
							$("#tabsContent").css("width", "100%");
							$("#tabsContent").css("width", "100%");
							$("#tabsContent").css("word-wrap", "break-word");
							$("#tabsContent").css("border", "#555555 1px solid");
						</script>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="tr">
		<div align="left" style="text-align:left;width:100%;padding:8px;">
			<xsl:apply-templates />
		</div>
	</xsl:template>
	<xsl:template match="th">
		<div align="left" style="text-align:left;width:100%;">
			<xsl:apply-templates />
		</div>
	</xsl:template>
	<xsl:template match="td">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="a">
		<xsl:choose>
			<xsl:when test="@mark='att'">
				<a href="/bridge/oa/attachedfile/smartdot/reed_gstg.nsf/{substring-before(substring-after(//uri/text(), '.nsf/'),'/')}{@href}" rel="external"><xsl:value-of select="."/></a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>
</xsl:stylesheet>
