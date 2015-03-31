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
						<xsl:variable name="dbpath"
							select="//input[@name='DF_DbPath']/@value" />
						<input type="hidden" id="dbpath" value="{$dbpath}" />
						<!-- <div style="font-weight:bold;font-size:20px;height:45px;text-align:center;word-break:break-all">
							<xsl:value-of
								select="//div[@style='font-weight:bold;font-size:15pt;height:60px;color:#000066;padding-top:20px;text-align:center;word-break:break-all']/text()" />
						</div> -->
						<div data-role="collapsible" data-collapsed="true" data-theme="f" data-content-theme="d" class="ui-collapsible ui-collapsible-inset ui-corner-all ui-collapsible-themed-content">
							<h1 class="ui-collapsible-heading">
								<a href="#" class="ui-collapsible-heading-toggle ui-btn-up-f" style="color: white;">
									<span class="ui-btn-text" style="color: black;font-size: 16px;font-family: Microsoft YaHei;text-shadow: none;">基本信息</span>
									</a>
							</h1>
							<div>
								<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word;font-size: 15px;font-family: Microsoft YaHei;" class="ui-listview ui-listview-inset ui-corner-all ui-shadow">
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										标题
										：
										<xsl:value-of
								select="//div[@style='font-weight:bold;font-size:15pt;height:60px;color:#000066;padding-top:20px;text-align:center;word-break:break-all']/text()" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='DraftManCn']" />
										：
										<xsl:value-of select="//input[@name='DraftManCn']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='Dept']" />
										：
										<xsl:value-of select="//input[@name='showdeptname']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='DraftDate']" />
										：
										<xsl:value-of select="//input[@name='DraftDate']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='Import']" />
										:
										<xsl:value-of select="//input[@name='Import']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='PubObject']" />
										:
										<xsl:value-of select="//input[@name='PubObject']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='PubDate']" />
										:
										<xsl:value-of select="//input[@name='PubDate']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='OldDate']" />
										:
										<xsl:value-of select="//input[@name='OldDate']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='ClassName']" />
										:
										<xsl:value-of select="//input[@name='ClassName']/@value" />
									</li>
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child">
										<xsl:value-of select="//label[@for='TopNews']" />
										:
										<xsl:value-of select="//input[@name='TopNews']/@value" />
									</li>

								</ul>
							</div>
						</div>
						<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
							<!-- <li data-role="list-divider">内容</li>
							
							<div
								style="font-size:15px;padding-bottom: 20px;padding-top:20px;text-align:center">
								<xsl:value-of select="//input[@name='DraftDate']/@value"></xsl:value-of>
								<xsl:text> </xsl:text>
								<xsl:value-of select="//input[@name='DraftManCn']/@value"></xsl:value-of>
								<xsl:text> </xsl:text>
								<xsl:value-of select="//input[@name='showdeptname']/@value"></xsl:value-of>
							</div> -->
							<li data-role="list-divider" class="fontdividerstyle"> 正文</li>
							<li id="word" data-bind="foreach: word" margin-bottom="0px" class="fontstyle">
								<a data-role="button" data-bind="click:viewfile1" style="margin-bottom: 0px">
									<span text-align="center" data-bind="text: name" style="color:#265b93;"></span>
								</a>
							</li>
							
						</ul>
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
