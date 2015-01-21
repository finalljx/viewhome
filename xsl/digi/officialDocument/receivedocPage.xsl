<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" indent="yes" />
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
					<h2>
						<xsl:value-of select="//input[@name='StSubject']/@value" />
					</h2>
						<!-- 附件隐藏域 -->
						<xsl:variable name="unid"
							select="//input[@name='StMaindocUnid_Att']/@value" />
						<input type="hidden" id="unid" value="{$unid}" />
						<div>
							<ul data-role="listview" data-inset="true" data-theme="d"
								style="word-wrap:break-word">
								<li data-role="list-divider">收文办理单</li>
								<li>
									<xsl:value-of select="//fieldset[@id='Abstract']/h3" />
								</li>
								<li data-role="list-divider">基础信息</li>
								<xsl:apply-templates
									select="//fieldset[@id='fieldSet1']/div[@class='row']/descendant::div[@class='input-group']"
									mode="b" />
								<!-- <li data-role="list-divider">审批流转意见</li>
								<xsl:if test="not(//table[@class='list']/tbody/tr)">
									<li>无审批流转意见</li>
								</xsl:if>
								<xsl:if test="//table[@class='list']/tbody/tr">
								  <li>
									<xsl:apply-templates select="//table[@class='list']/tbody/tr"
										mode='tr' />
								 </li>
								</xsl:if> -->


								<li data-role="list-divider">正文内容</li>
								<li data-bind="foreach: word" id="word">
									<a data-role="button" data-bind="click:viewfile">
										<span data-bind="text: name"></span>
									</a>
								</li>

								<li data-role="list-divider">附件</li>
								<li data-bind="foreach: attachment" id="attachment">
									<a data-role="button" data-bind="click:viewfile">
										<span data-bind="text: name"></span>
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
				<li>
					<xsl:if test="div[@class='DF_MindInfo']">
						<xsl:value-of select="span[1][@class='input-group-addon']/label" />
						:
						<xsl:if test="div[@class='DF_MindInfo']!='' and div[@class='DF_QMInfo']!=''">
						<xsl:value-of select="div[@class='DF_MindInfo']" />/
						<xsl:value-of select="div[@class='DF_QMInfo']" />
						</xsl:if>
						<xsl:if test="div[@class='DF_MindInfo']='' or div[@class='DF_QMInfo']=''">
						<xsl:value-of select="div[@class='DF_MindInfo']" />
						<xsl:value-of select="div[@class='DF_QMInfo']" />
						</xsl:if>
						
					</xsl:if>
					<xsl:if test="not(div[@class='DF_MindInfo'])">
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
	<!-- 处理审批流转意见 -->
	<xsl:template match="tr" mode="tr">
		<xsl:variable name="num" select="position()" />
	<div>
		<xsl:choose>
			<xsl:when test="$num mod 3=1">
				
					<xsl:value-of select="td[1]/." />
					<xsl:value-of select="td[2]" />
			        	<br/>
					<xsl:value-of select="td[3]/." />
					<xsl:value-of select="td[4]/." />
			         	<br/>
					<xsl:value-of select="td[5]/." />
					<xsl:value-of select="td[6]/." />
				    	<br/>
			</xsl:when>
			<xsl:when test="$num mod 3=2">
				
					审批意 见:
					<xsl:value-of select="td[2]" disable-output-escaping="yes" />
					<hr/>
				
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</div>
	</xsl:template>
</xsl:stylesheet>
