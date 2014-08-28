<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:variable name="start"><xsl:value-of select="//input[@name='start']/@value"/></xsl:variable>
	<xsl:variable name="count"><xsl:value-of select="//input[@name='count']/@value"/></xsl:variable>
	<xsl:variable name="total"><xsl:value-of select="//input[@name='total']/@value"/></xsl:variable>
	<xsl:variable name="currentPage"><xsl:value-of select="floor($start div $count)+1"/></xsl:variable>
	<xsl:variable name="totalPage"><xsl:value-of select="floor(($total - 1) div $count)+1"/></xsl:variable>
	<xsl:variable name="nextStart"><xsl:value-of select="($currentPage * $count) + 1"/></xsl:variable>
	<xsl:variable name="preStart"><xsl:value-of select="$nextStart - $count - $count"/></xsl:variable>

	<xsl:template match="/">
		<html lang="zh_cn">
			<head>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
				<meta name="format-detection" content="telephone=no" />
				<meta name="apple-mobile-web-app-capable" content="yes" />
				<meta name="apple-mobile-web-app-status-bar-style" content="black" />
				<link rel="apple-touch-icon-precomposed" href="icon.png" />
				<link rel="apple-touch-startup-image" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)" href="loading_1024_748.png"/>
				<link rel="apple-touch-startup-image" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)" href="loading_768_1004.png"/>
				<link rel="apple-touch-startup-image" media="screen and (max-device-width: 320px)" href="loading_320_480.png"/>
				<link rel="stylesheet" href="/cssjs/jquery.mobile-1.0.min.css" />
				<link rel="stylesheet" href="/cssjs/stanford.css" />
				<script src="/cssjs/jquery.js"></script>
				<script>
					window.scrollTo(0,1);
					$(document).bind("mobileinit", function(){
						$.mobile.loadingMessage = "载入中...";
						$.mobile.page.prototype.options.backBtnText = "后退";
						//if(window.navigator.userAgent.match(/android/i)){
						$.mobile.defaultPageTransition = "none";
						//}
					});
				</script>
				<script src="/cssjs/jquery.mobile-1.0.min.js"></script>
			</head>
			<body>
				<div data-role="page" class="type-home">
					<div data-role="header">
						<a data-icon="home" data-role="button" href="/bridge/home.html">返回</a>
						<h1>请假管理</h1>
					</div><!-- /header -->
				
					<div data-role="content" align="center">
						<ul data-role="listview" data-inset="true">
							<li data-role="list-divider"></li>
							<li data-role="list-divider">
								<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
									<xsl:if test="$currentPage!=1">
										<a data-role="button" href="/bridge/oa/ccgllist/smartdot/kaoqin.nsf/myview?openform&amp;view=vwleavebydate&amp;count=20&amp;start={$preStart}">上一页</a> 
									</xsl:if>
									<a data-role="button"><xsl:value-of select="$currentPage"/>/<xsl:value-of select="$totalPage"/></a> 
									<xsl:if test="$currentPage&lt;$totalPage">
										<a data-role="button" href="/bridge/oa/ccgllist/smartdot/kaoqin.nsf/myview?openform&amp;view=vwleavebydate&amp;count=20&amp;start={$nextStart}">下一页</a> 
									</xsl:if>
								</div>
							</li>
							<xsl:apply-templates select="//div[@id='viewValue']//table/tbody/tr[position()&gt;1]" />
							<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])=0">
								<li><a>无内容</a></li>
							</xsl:if>
							<li data-role="list-divider"></li>
						</ul>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="tr">
		<li href="">
			<a href="/bridge/oa/qjglcontent{td[4]/a/@href}" data-icon="arrow-r" data-iconpos="right">
				<img src="/bridge/flag.png" style="padding:15px;"/>
				<h3><xsl:value-of select="td[4]/."/></h3>
				<p>
					创建日期:<font color="#0080FF"><xsl:value-of select="td[3]/."/></font>
					假类:<font color="#0080FF"><xsl:value-of select="td[6]/."/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
