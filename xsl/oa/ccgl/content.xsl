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
		<xsl:choose>
			<xsl:when test="contains(//div[@class='Toolbar']/., '编辑') and (contains(//uri/text(), '?OpenDocument') or contains(//uri/text(), '?opendocument'))">
				<html lang="zh_cn">
					<head></head>
					<body>
						<div data-role="page" class="type-home">
							<div data-role="header" data-position="fixed">
								<a data-icon="home" data-role="button" data-rel="back">返回</a>
								<h1>出差管理</h1>
							</div><!-- /header -->
							<div data-role="content" align="center">
								<script>
									var id = '<xsl:value-of select="substring-before(substring-after(substring-after(//uri/text(), '.nsf/'), '/'), '?')"/>';
									var url= '/bridge/oa/ccglcontent/smartdot/kaoqin.nsf/vwTrip/' + id + '?editdocument';
									$( document ).delegate("#ccglcontent", "pagebeforecreate", function() {
										var b = $("table.tableClass input");
										for(var i=0; i&lt;b.length; i++){
											$(b[i]).attr('data-role', 'none');
											$(b[i]).attr('readonly', 'true');
											$(b[i]).css('border', '0');
											if($(b[i]).attr('type')!='button' &amp;&amp; $(b[i]).attr('type')!='radio' &amp;&amp; $(b[i]).attr('type')!='checkbox' ){
												$(b[i]).css('width', '80%');
											}
											
											if($(b[i]).attr('type')=='button'){
												$(b[i]).hide();
											}
										}
										var s = $("table.tableClass select");
										for(var i=0; i&lt;s.length; i++){
											$(s[i]).attr('data-role', 'none');
											$(s[i]).hide();
										}
									});
									$.mobile.changePage(url, {
										reverse: false,
										changeHash: false
									});
								</script>
								<ul data-role="listview" data-inset="true">
									<li data-role="list-divider"></li>
									<li>
										<div style="width:100%" align="center">
											<h3>编辑页面跳转</h3>
										</div>
									</li>
									<li data-role="list-divider"></li>
								</ul>
							</div>
						</div>
					</body>
				</html>
			</xsl:when>
			<xsl:otherwise>
				<html lang="zh_cn">
					<head>
						<title>慧点办公</title>
						<meta http-equiv="Content-Type" content="text/html; charset=utf8"/>
						<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=6.0, user-scalable=1;"/>
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
								//$.mobile.page.prototype.options.keepNative = "select, input, textarea";
								//}
							});
							function MJ(){
								this.path = '';
							}
							MJ.prototype.viewfile = function(url){
								this.path = url;
								$.mobile.changePage('/bridge/file.html', {
									reverse: false,
									changeHash: false
								});
							}
							MJ.prototype.getpath  = function(){
								return this.path;
							}
							var mj = new MJ();
						</script>
						<script src="/cssjs/jquery.mobile-1.0.min.js"></script>
					</head>
					<body>
						<div id="ccglcontent" data-role="page" class="type-home">
							<div data-role="header">
								<a data-icon="home" data-role="button" data-rel="back">返回</a>
								<h1>出差管理</h1>
							</div><!-- /header -->
							<div data-role="content" align="center">
								<style>
									.tableClass {
										border:0; 
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
								<form action="/bridge/oa/submit{//form[@name='_frmTrip']/@action}" method="post">
									<div>
										<ul data-role="listview">
											<li data-role="list-divider">
												<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
													<xsl:if test="//div[@class='Toolbar' and contains(., '提交')]">
														<button type="submit" data-theme="b" name="$$querysaveagent" value="agtFlowDeal" data-rel="dialog">提交</button>
													</xsl:if>
													<!--
													<xsl:if test="//div[@class='Toolbar' and contains(., '撤&amp;nbsp;回')]">
														<button type="submit" data-theme="b" name="$$querysaveagent" value="agtFlowDeal">撤回</button>
													</xsl:if>
													-->
													<xsl:if test="//div[@class='Toolbar' and contains(., '驳回')]">
														<button type="submit" data-theme="b" name="$$querysaveagent" value="agtFlowDeny" data-rel="dialog">驳回</button>
													</xsl:if>
													
													<xsl:if test="//div[@class='Toolbar' and contains(., '退出')]">
														<a data-role="button" data-rel="back">退出</a>
													</xsl:if>
												</div>
											</li>
										</ul>
									</div>
									<br/>
									<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
										<div data-role="collapsible" data-collapsed="false">
											<h1>基本信息</h1>
											<p>
												<ul data-role="listview" data-inset="true" data-theme="d"> 
													<li><xsl:copy-of select="//table[@class='tableClass']"/></li>
													<xsl:if test="//textarea[@name='fldAttitude']">
														<li>
															<table style="border:0;" width="100%" border="0">
																<tr style="width:100%">
																	<td style="width:50%" align="left">
																		<span><strong>您的意见:</strong></span>
																	</td>
																	<td style="width:50%" align="left">
																		<select onChange='$("#fldAttitude").val($("#fldAttitude").val()+this.value);' data-theme="a" data-icon="gear" data-native-menu="false">
																			<option selected="selected">常用语</option>
																			<xsl:apply-templates select="//select[@name='fldCyy']/option" mode="cyy"/>
																		</select>
																	</td>
																</tr>
																<tr style="width:100%">
																	<td colspan="2" style="width:100%" align="center">
																		<textarea id="fldAttitude" name="fldAttitude"><xsl:value-of select="//textarea[@name='fldAttitude']/text()"/></textarea>
																	</td>
																</tr>
															</table>
														</li>
													</xsl:if>
												</ul>
											</p>
										</div>
										<div data-role="collapsible">
											<h1>正文</h1>
										</div>
										<div data-role="collapsible">
											<h1>审批意见</h1>
											<p>
												<xsl:if test="//table[@class='yjTable']//tr">
													<xsl:apply-templates select="//table[@class='yjTable']" mode="o1"/>
												</xsl:if>
											</p>
										</div>
										<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
										<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
									</div>
								</form>
							</div><!-- /content -->
						</div>
					</body>
				</html>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- 将隐藏控件传入 -->
	<xsl:template match="input" mode="hidden">
		<input type="hidden" name="{@name}" value="{@value}"/>
	</xsl:template>

	<xsl:template match="option" mode="cyy">
		<option value="{text()}"><xsl:value-of select="text()"/></option>
	</xsl:template>

	<xsl:template match="table" mode="o1">
		<!--
		<span width="100%" bgcolor="#414246"><span width="10"/><font color="#FFFFFF" size="{$size}"><strong>审批意见</strong></font></span>
		
		<span width="100%" id="moreoptions" href="script:showAndHide('viewoptions', 'moreoptions');">
			<span width="100%" height="15"></span>
			<span width="100%" align="center"><font size="{$size}">更 多</font></span>
			<span width="100%" height="15"></span>
			<hr/>
		</span>
		<span width="100%" id="viewoptions" visible="false">
			<span width="100%" href="script:showAndHide('moreoptions', 'viewoptions');">
				<span width="100%" height="15"></span>
				<span width="100%" align="center"><font size="{$size}">隐 藏</font></span>
				<span width="100%" height="15"></span>
				<hr/>
			</span>
			<xsl:apply-templates mode="o2"/>
			<span width="100%" href="script:showAndHide('moreoptions', 'viewoptions');">
				<span width="100%" height="15"></span>
				<span width="100%" align="center"><font size="{$size}">隐 藏</font></span>
				<span width="100%" height="15"></span>
				<hr/>
			</span>
		</span>
		-->
		<ul data-role="listview" data-inset="true" data-theme="d"> 
			<xsl:apply-templates mode="o2"/>
		</ul>
	</xsl:template>
	<xsl:template match="tbody" mode="o2">
		<xsl:apply-templates mode="o2"/>
	</xsl:template>
	<xsl:template match="tr" mode="o2">
		<xsl:variable name="pos" select="position()"/>
		<xsl:choose>
			<xsl:when test="contains(td[1],'处 理 人')">
				<li>
					<div>
						<div width="100%" align="left">
							<h3><xsl:value-of select="./following::tr/td[2]/." /></h3>
						</div>
						<div width="100%" align="right">
							<xsl:apply-templates mode="o3">
								<xsl:with-param name="pos"><xsl:value-of select="$pos"/></xsl:with-param>
							</xsl:apply-templates>
						</div>
					</div>
				</li>
			</xsl:when>
			<xsl:when test="contains(td[1],'意见')">
				意见
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="td" mode="o3">
		<xsl:variable name="username" select="substring-after(img/@src,'=')"/>
		<xsl:if test="@class='yjLabel'">
			<xsl:value-of select="." />:
		</xsl:if>
		<xsl:if test="@class='yjContent'">
			<xsl:choose>
				<xsl:when test="img">
					<xsl:value-of select="substring-after(img/@src, 'username=')" />
				</xsl:when>
				<xsl:when test="contains(., '/')">
					<xsl:value-of select="substring-before(., '/')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="br" mode="o4">
		<br/>
	</xsl:template>
	<xsl:template match="text()" mode="o4">
		<xsl:value-of select="." />
	</xsl:template>
</xsl:stylesheet>
