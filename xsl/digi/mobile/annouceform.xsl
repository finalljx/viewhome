<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" indent="yes" />
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				
  
			</head>
			<body >
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<xsl:variable name="dbpath"
							select="//input[@name='DF_DbPath']/@value" />
						<input type="hidden" id="dbpath" value="{$dbpath}" />
						<div data-role="collapsible" data-collapsed="false"
							data-theme="f">
							<h1>基本信息</h1>
							<div>
								<ul data-role="listview" data-inset="true" data-theme="d"
									style="word-wrap:break-word">
									<li>
										<xsl:value-of select="//label[@for='DraftManCn']" />
										：
										<xsl:value-of select="//input[@name='DraftManCn']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='Dept']" />
										：
										<xsl:value-of select="//input[@name='showdeptname']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='DraftDate']" />
										：
										<xsl:value-of select="//input[@name='DraftDate']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='Import']" />
										:
										<xsl:value-of select="//input[@name='Import']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='PubObject']" />
										:
										<xsl:value-of select="//input[@name='PubObject']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='PubDate']" />
										:
										<xsl:value-of select="//input[@name='PubDate']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='OldDate']" />
										:
										<xsl:value-of select="//input[@name='OldDate']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='ClassName']" />
										:
										<xsl:value-of select="//input[@name='ClassName']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='TopNews']" />
										:
										<xsl:value-of select="//input[@name='TopNews']/@value" />
									</li>

								</ul>
							</div>
						</div>
						<div data-role="collapsible" data-collapsed="true" data-theme="f">
							<h1>正文内容</h1>
							<div
								style="font-weight:bold;font-size:20px;height:45px;color:#000066;padding-top:20px;text-align:center;word-break:break-all">
								<xsl:value-of
									select="//div[@style='font-weight:bold;font-size:15pt;height:60px;color:#000066;padding-top:20px;text-align:center;word-break:break-all']/text()" />
							</div>
							<div
								style="font-size:15px;height:20px;padding-top:5px;text-align:center">
								<xsl:value-of select="//input[@name='DraftDate']/@value"></xsl:value-of>
								<xsl:text> </xsl:text>
								<xsl:value-of select="//input[@name='DraftManCn']/@value"></xsl:value-of>
								<xsl:text> </xsl:text>
								<xsl:value-of select="//input[@name='showdeptname']/@value"></xsl:value-of>
							</div>
							<br />
							<div>
								<ul data-role="listview" data-inset="true" data-theme="d"
									style="word-wrap:break-word">
									<li data-role="list-divider">正文</li>
									<li id="word" data-bind="foreach: word">
										<a data-role="button" data-bind="click:viewfile1">
											<span data-bind="text: name"></span>
										</a>
									</li>
									<li data-role="list-divider">附件信息</li>
									<xsl:apply-templates
										select="//tr[@style='width:100%;display:block']/td/a" mode="a" />
								</ul>
							</div>
							<!-- <div align="left" class="message"> <xsl:value-of select="//textarea[@name='Fck_HTML']"></xsl:value-of> 
								<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word"> 
								<li data-role="list-divider">附件信息</li> <xsl:apply-templates select="//tr[@style='width:100%;display:block']/td/a" 
								mode="a"/> </ul> </div> -->
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="a" mode="a">
		<li>
			<xsl:variable name="url">
				<xsl:value-of select="@href" />
			</xsl:variable>
			<a data-role="button" href="javascript:void(0)" data-url="{$url}"
				onclick="viewfile(this)">
				<span>
					<xsl:value-of select="font" />
				</span>
			</a>

		</li>
	</xsl:template>
</xsl:stylesheet>