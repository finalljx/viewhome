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
			<xsl:when test="contains(//div[@class='Toolbar']/., '编') and (contains(//uri/text(), '?OpenDocument') or contains(//uri/text(), '?opendocument'))">
				<html lang="zh_cn">
					<head></head>
					<body>
						<div data-role="page" class="type-home">
							<div data-role="header">
								<a data-icon="home" data-role="button" data-rel="back">返回</a>
								<h1>请假管理</h1>
							</div><!-- /header -->
							<div data-role="content" align="center">
								<script>
									var id = '<xsl:value-of select="substring-before(substring-after(substring-after(//uri/text(), '.nsf/'), '/'), '?')"/>';
									var url= '/bridge/oa/qjglcontent/smartdot/kaoqin.nsf/vwLeavebydate/' + id + '?editdocument';
									$( document ).delegate("#ccgllist", "pagebeforecreate", function() {
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
					<head></head>
					<body>
						<div id="ccgllist" data-role="page" class="type-home">
							<div data-role="header">
								<a data-icon="home" data-role="button" data-rel="back">返回</a>
								<h1>请假管理</h1>
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
								<form action="/bridge/oa/submit{//form[1]/@action}" method="post">
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
													<li><xsl:apply-templates select="//table[@class='tableClass']" mode="c1"/></li>
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

	<!-- 表单批量格式化模版 -->
	<!-- variable of $mini and $aliasname at mdp.xsl -->
	<xsl:template match="table" mode="c1">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tbody" mode="c2">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tr" mode="c2">
		<div style="width:100%" align="left">
			<xsl:attribute name="align">
				<xsl:if test="position()=2 or position()=4">center</xsl:if>
				<xsl:if test="not(position()=2 or position()=4)">left</xsl:if>
			</xsl:attribute>
			<xsl:apply-templates mode="c3"/>
		</div>
		<hr/>
	</xsl:template>

	<xsl:template match="td" mode="c3">
		<xsl:variable name="pos" select="position()"/>
		<!-- 发文红色字体特殊处理 -->
		<xsl:choose>
			<xsl:when test="@class='tdLabel'">
				<span style="width:38%;display:inline-block;text-align:right"><font color="red"><xsl:value-of select="."/></font></span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="c4"/>
				<br/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="text()" mode="c4">
		<xsl:value-of select="."/>
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
		<xsl:if test="starts-with(@name, 'fld')">
			<xsl:value-of select="@value"/>
		</xsl:if>
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
	<xsl:template match="div" mode="c4">
		<xsl:apply-templates mode="c4" />
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
