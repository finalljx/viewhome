<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" />
	<xsl:template match="/">
<html lang="zh_cn">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
</head>
<body>
	<div id="notice" data-role="page">
		<div data-role="content" align="center">
		    <div>
		        <ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
					<li data-role="list-divider">发文办理单</li>
					<li><xsl:value-of select="//div[@id='AbstractText']" /></li>
				</ul>
			</div>
			<div data-role="collapsible" data-collapsed="false" data-theme="f">
			<h1>基础信息</h1>
			<div>
				<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
					
					<xsl:apply-templates select="//fieldset[@id='fieldSet1']/div[@class='row']//div[@class='col-xs-12 col-md-6']" mode="a"/>
				</ul>
			</div>
		</div>
		<div data-role="collapsible" data-collapsed="true" data-theme="f">
			<h1>审批流转意见</h1>
			<div>
	                 <ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
	                      <li>
	                          <xsl:apply-templates select="//table[@class='list']/tbody/tr" mode='tr'/>
	                      </li>
	                 </ul>
			</div>
		</div>
		<!-- <div data-role="collapsible" data-collapsed="true" data-theme="f">
			<h1>正文内容</h1>
			<div style="font-weight:bold;font-size:15pt;height:50px;color:#000066;padding-top:20px;text-align:center;word-break:break-all">设计院公告</div>
				<div
					style="font-size:8pt;height:20px;padding-top:5px;text-align:center">
					<xsl:value-of select="//input[@name='DraftDate']/@value"></xsl:value-of>
					<xsl:text> </xsl:text>
					<xsl:value-of select="//input[@name='DraftManCn']/@value"></xsl:value-of>
					<xsl:text> </xsl:text>
					<xsl:value-of select="//input[@name='showdeptname']/@value"></xsl:value-of>
				</div>
				<br />
			<div align="left">
				<xsl:value-of select="//textarea[@name='Fck_HTML']"></xsl:value-of>
				<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
					<li data-role="list-divider">附件信息</li>
					<xsl:apply-templates select="//tr[@style='width:100%;display:block']/td/a" mode="a"/>
				</ul>
			</div>
		</div> -->
		</div>
		</div>
	</body>
</html>
	</xsl:template>
	<!-- 处理基础信息 -->
	<xsl:template match="div" mode="a">
		<xsl:variable name="divStyle" select="@style" />
			   <xsl:choose>
			        <xsl:when test="not(contains($divStyle, 'display:none'))">
				        <li>
				             <xsl:value-of select="div[@class='input-group']/span[1][@class='input-group-addon']/label"/>:
				             <xsl:value-of select="div[@class='input-group']/div[@class='DF_MindInfo']"/>
				             <xsl:value-of select="div[@class='input-group']/div[@class='DF_QMInfo']"/>
				            <xsl:choose>
				               <xsl:when test="div[@class='input-group']/select">
				                  <xsl:value-of select="//option[@selected='selected']/."/>
				               </xsl:when>
				               <xsl:otherwise>
				                  <xsl:value-of select="div[@class='input-group']/input[1]/@value"/>
				              </xsl:otherwise>
				          </xsl:choose> 
				         </li>
			        </xsl:when>
			        <xsl:otherwise>
			        </xsl:otherwise>
			    </xsl:choose>
			   
	</xsl:template>
	<!-- 处理审批流转意见 -->
	<xsl:template match="tr" mode="tr">
		<xsl:variable name="num" select="position()"/>
		<div>
			<xsl:choose>
				<xsl:when test="$num mod 3=1">
					<xsl:value-of select="td[1]/."/><xsl:value-of select="td[2]"/><br/>
					<xsl:value-of select="td[3]/."/><xsl:value-of select="td[4]/."/><br/>
					<xsl:value-of select="td[5]/."/><xsl:value-of select="td[6]/."/><br/>
				</xsl:when>
				<xsl:when test="$num mod 3=2">
					审批意 见:<xsl:value-of select="td[2]/."/><br/>
				</xsl:when> 
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
		</div>	
	</xsl:template>
	
</xsl:stylesheet>
