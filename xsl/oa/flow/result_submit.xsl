<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" encoding="gb2312"/>
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
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1.0" />
			<script type="application/javascript" src="/view/assets/iscroll.js"></script>
			<link rel="stylesheet" href="/view/lib/jquery-mobile/jquery.mobile.min.css" />
			<link rel="stylesheet" href="/view/assets/jquery.mobile-sugon.css" />
			<script src="/view/lib/jquery/jquery.min.js"></script>
			<script src="/view/lib/hori/hori.js?tag=21369"></script>
			<script src="/view/lib/jquery-mobile/jquery.mobile.min.js"></script>
			<script src="/view/config/web/config.js"></script>
			</head>
			<body>
				<div data-role="dialog" class="type-home">
					<div data-role="header">
						<style>.ui-dialog .ui-header .ui-btn-icon-notext { display:none;} </style>
						<!-- <a data-role="button" href="javascript:void(0);" onclick="window.history.go(-3)">确定</a> -->
						<h1>操作提示</h1>
					</div>
					<div data-role="content" align="center">
						<ul data-role="listview" data-inset="true">
							<li data-role="list-divider"></li>
							<li>
								<div style="100%;text-align:center;" align="center">
									<div align="center">
										<xsl:value-of select="//td[@class='msgok_msg']/."/>
									</div>
								</div>
							</li>
							<li data-role="list-divider"></li>
						</ul>
						<div class="ui-grid-a">
							<div class="ui-block-a"></div>
							<div class="ui-block-b">
								<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="window.history.go(-3)">确认</a>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
