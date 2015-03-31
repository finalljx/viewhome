<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" indent="yes" />
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<style>
					.ui-bar-b{border: 0px;background-image: linear-gradient( #c4d9ef , #c4d9ef );}
					.ui-collapsible-heading-toggle {
						border: 1px solid #c4d9ef /*{c-bup-border}*/;
						background-image: linear-gradient( #c4d9ef /*{c-bup-background-start}*/, #c4d9ef /*{c-bup-background-end}*/);
					}
				</style>
			</head>
			<body >
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<!-- 附件隐藏域 -->
						<!-- <h2>
							<xsl:value-of select="//input[@name='StSubject']/@value" />
						</h2> -->
						<xsl:variable name="unid"
							select="//input[@name='StMaindocUnid_Att']/@value" />
						<input type="hidden" id="unid" value="{$unid}" />
						<div>
							<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word" class="ui-listview ui-listview-inset ui-corner-all ui-shadow">
								<div data-role="collapsible" data-collapsed="true" data-theme="f" data-content-theme="d" class="ui-collapsible ui-collapsible-inset ui-corner-all ui-collapsible-themed-content">
							<h1 class="ui-collapsible-heading">
								<a href="#" class="ui-collapsible-heading-toggle ui-btn-up-f" >
									<span class="ui-btn-text" style="color: black;font-size: 16px;font-family: Microsoft YaHei;text-shadow: none;">基本信息</span>
									</a>
							</h1>
								<div>
									<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word" class="ui-listview ui-listview-inset ui-corner-all ui-shadow">
										<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child" style="font-size: 15px;font-family: Microsoft YaHei;">
											标题：<xsl:value-of select="//input[@name='StSubject']/@value" />
										</li>
										<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child" style="font-size: 15px;font-family: Microsoft YaHei;">
											<xsl:value-of select="//fieldset[@id='Abstract']/h3" />
										</li>
										<xsl:apply-templates select="//fieldset[@id='fieldSet1']/div[@class='row']/descendant::div[@class='input-group']" mode="b" />
									</ul>
									</div>
								</div>
								<!--  <li data-role="list-divider">审批流转意见</li>
								<xsl:if test="//table[@id='Approval_Tabel']/tbody/tr">
									<li>
										<xsl:apply-templates select="//table[@id='Approval_Tabel']/tbody/tr"
											mode='tr' />
									</li>
								</xsl:if>
								<xsl:if test="not(//table[@id='Approval_Tabel']/tbody/tr)">
									<li>无审批流转意见</li>
								</xsl:if>
                                                -->

								<li data-role="list-divider" class="fontdividerstyle">正文内容</li>
								<li data-bind="foreach: word" id="word">
									<a data-role="button" data-bind="click:viewfile">
										<span text-align="center" data-bind="text: name" style="color:#265b93;font-size: 15px;font-family: Microsoft YaHei;"></span>
									</a>
								</li>

								<li data-role="list-divider" class="fontdividerstyle">附件</li>
								<li data-bind="foreach: attachment" id="attachment" data-icon="false" style="background: #ffffff;">
								<a data-bind="click:viewfile">
									<span  data-bind="text: number" style="color:#265b93;font-size: 15px;font-family: Microsoft YaHei;"/>
									<span id="filenumber" style="color:#265b93;">.</span>
									<span  data-bind="text: name" style="white-space: pre-wrap;color:#265b93;font-size: 15px;font-family: Microsoft YaHei;"></span>
								</a>
							</li>
							</ul>
						</div>

					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<!-- 处理基础信息 -->
	<xsl:template match="div" mode="b">
		<xsl:variable name="divStyle" select="parent::div/@style" />
		<xsl:choose>
			<xsl:when test="not(contains($divStyle, 'display:none'))">
				<li style="font-size: 15px;font-family: Microsoft YaHei;">
					<xsl:if test="span[@class='input-group-area']">
					<xsl:value-of select="span[1][@class='input-group-addon']/label" />
						:
						<xsl:apply-templates select="span[@class='input-group-area']/div" mode="div"></xsl:apply-templates>
					</xsl:if>
					<xsl:if test="not(div[@class='DF_MindInfo'])and not(span[@class='input-group-area']/div[@class='DF_MindInfo'])">
						<xsl:value-of select="span[1][@class='input-group-addon']/label" />
						:
						<xsl:choose>
							<xsl:when test="select">
								<xsl:value-of select="//option[@selected='selected']/." />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="input[1]/@value" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</li>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="div" mode="div">
		<xsl:value-of select="."></xsl:value-of>
		<xsl:text> </xsl:text>

	</xsl:template>
	
	<!-- 处理审批流转意见 -->
	<xsl:template match="tr" mode="tr">
		<xsl:variable name="num" select="position()" />
		<div>
			<xsl:choose>
				<xsl:when test="$num mod 3=1">
					<xsl:value-of select="td[1]/." />
					<xsl:value-of select="td[2]" />
					<br />
					<xsl:value-of select="td[3]/." />
					<xsl:value-of select="td[4]/." />
					<br />
					<xsl:value-of select="td[5]/." />
					<xsl:value-of select="td[6]/." />
					<br />
				</xsl:when>
				<xsl:when test="$num mod 3=2">
					审批意 见:
					<xsl:value-of select="td[2]/." />
					<hr/>
				</xsl:when>
			</xsl:choose>
		</div>

	</xsl:template>

</xsl:stylesheet>
