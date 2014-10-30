<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:variable name="appdbpath"><xsl:value-of select="//input[@name='appdbpath']/@value"/></xsl:variable>
	<xsl:variable name="appformname"><xsl:value-of select="//input[@name='appformname']/@value"/></xsl:variable>
	<xsl:variable name="username">
		<xsl:value-of select="substring-before(substring-after(//input[@name='curUser']/@value,'CN='),'/O=')"/>
	</xsl:variable>
	<!-- 表单变量 <xsl:value-of select="substring-after(//input[@name='fldIframeURL']/@value, 'vwprintcld/')"/>--> 
	<xsl:variable name="dbPath">
		<xsl:value-of select="//input[@name='dbpath' or @name='dbPath' or @name='dbPath1']/@value" />
	</xsl:variable>
	<xsl:variable name="docunid">
		<xsl:value-of select="substring-after(//input[@name='fldIframeURL']/@value, 'vwprintcld/')"/>
	</xsl:variable>
	<xsl:variable name="unId">
		<xsl:choose><xsl:when test="contains(//url/text(),'/0/')"><xsl:value-of select="substring-before(substring-after(//url/text(),'/0/'),'?')" /></xsl:when><xsl:when test="contains(//url/text(),'/vwDocByDate/')"><xsl:value-of select="substring-before(substring-after(//url/text(),'/vwDocByDate/'),'?')" /></xsl:when><xsl:otherwise><xsl:value-of select="substring-before(substring-after(substring-after(//url/text(),'nsf/'),'/'),'?')" /></xsl:otherwise></xsl:choose>
	</xsl:variable>
	<xsl:template match="/">
				<html lang="zh_cn">
					<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1.0" />
					<link rel="stylesheet" href="/view/lib/jquery-mobile/jquery.mobile.min.css" />
					<link rel="stylesheet" href="/view/assets/jquery.mobile-sugon.css" />
					<script src="/view/lib/jquery/jquery.min.js"></script>
					<script src="/view/lib/hori/hori.js?tag=21369"></script>
					<script src="/view/lib/jquery-mobile/jquery.mobile.min.js"></script>
					<script src="/view/config/web/config.js"></script>
						<script>
						<![CDATA[
							$(document).ready(function(){
								var hori=$.hori;
								/*设置标题*/
								hori.setHeaderTitle("集团内部请示报告");
								$.hori.hideLoading();
							});
							//viewfile 附件函数
							function viewfile(url){
								localStorage.setItem("attachmentUrl",url);
								var fileurl = $.hori.getconfig().appServerHost+"view/html/attachmentShowForm.html";
								var xmlurl ="viewhome/xml/AttachView.xml";
								$.hori.loadPage(fileurl,xmlurl);
							}
							function submit(value){
								var sel = $("#fldAttitude").val();
								/* if(sel == null || sel==""){
									alert('请填写您的意见');
									return ;
								} **/
								//提交
								if(value=="reject"){
									var question = window.confirm("确定驳回吗?"); 
								}else if(value=="submit"){
									var question = window.confirm("确定提交吗?"); 
								}else if(value=="save"){
									var question = window.confirm("确定保存吗?"); 
								}else if(value=="sign"){
									var huiqiandanwei = $("#huiqiandanwei").val();
									if(huiqiandanwei==""||huiqiandanwei==null){
										alert("发起内请时没有选择会签流程，手机端不能处理，请到电脑上处理！");
										return false;
									}
									var question = window.confirm("确定会签吗?"); 
								}
								if(question){
									post(value);
								}
							}

							function post(type){
								$.mobile.loading('show', {  
									text: '加载中...', //加载器中显示的文字  
									textVisible: true, //是否显示文字  
									theme: 'a',        //加载器主题样式a-e
									textonly: false,   //是否只显示文字
									html: ""           //要显示的html内容，如图片等
								});
								if(type == "submit"){
									$("#querysaveagent").val("agtFlowDeal");
									$("#form").submit();
								}else if(type=="reject"){
									$("#querysaveagent").val("agtFlowDeny");
									$("#form").submit();
								}else if(type=="save"){
									$("#querysaveagent").val("agtSaveDraftNoExit");
									$("#form").submit();
									//document.location.reload();
									//$.hori.backPage(1)
								}else if(type=="sign"){
									$("#querysaveagent").val("agtExecuteAction");
									$("#hfldAction").val("huiqian");
									$("#form").submit();
								}
							}
						]]>
						</script>
						<style>
							.ui-btn-text{text-align: center;}
							.ui-listview {background: #D61800;}
						</style>
					</head>
					<body>
						<div id="notice" data-role="page">
							<form id="form" action="/view/oa/submit{//form[@name='_frmWebFlow']/@action}" method="post">
								<input type="hidden" id="querysaveagent" name="$$querysaveagent" value="{//input[@name='$$querysaveagent']/@value}" />
								<div data-role="content" align="center">
								<div class="ui-grid-c">
									<xsl:if test="//div[contains(@onclick, 'agtFlowDeal')]">
										<div class="ui-block-a" style="padding-bottom:5px;" align="center">
											<a data-role="button" value="submit" onclick="submit('submit');" data-mini='true' data-theme="f">提 交</a>
										</div>
									</xsl:if>
									<xsl:if test="//div[contains(@onclick, 'agtFlowDeny')]">
										<div class="ui-block-b" style="padding-bottom:5px;" align="center">
											<a data-role="button" value="reject" onclick="submit('reject');" data-mini='true' data-theme="f">驳 回</a>
										</div>
									</xsl:if>
									<xsl:if test="//div[contains(@onclick, 'huiqian')]">
										<div class="ui-block-c" style="padding-bottom:5px;" align="center">
											<a data-role="button" value="oprate" onclick="submit('sign');" data-mini='true' data-theme="f">会 签</a>
										</div>
									</xsl:if>
									<xsl:if test="//*[@name='fldAttitude']">
										<div class="ui-block-d" style="padding-bottom:5px;" align="center">
											<a data-role="button" value="reject" onclick="submit('save');" data-mini='true' data-theme="f">保 存</a>
										</div>
									</xsl:if>
								</div>
								<h3><xsl:value-of select="substring-after(//table[@id='table1']/tbody/tr[4]/.,':')" /></h3>
								<div data-role="collapsible" data-collapsed="false" data-theme="f" data-content-theme="d">
									<h4>附件</h4>
									<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
										 
										<xsl:if test="count(//span[@id='idxSpan']//param[@name='FileInfos'])=0">
											<li>无附件</li>
										</xsl:if>
											<xsl:call-template name="attachedFiles">
												<xsl:with-param name="FileInfosValue" select="//param[@name='FileInfos']/@value"/>
											</xsl:call-template>
									</ul>
								</div>
								<xsl:if test="count(//textarea[@name='fldAttitude'])!=0">
									<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
									<li data-role="list-divider">审批意见</li>
										<li>
											<table style="border:0;padding:0;margin:0;" width="100%" border="0">
												<tr style="width:100%">
													<td style="width:70%" align="left">
													</td>
													<td style="width:30%" align="right">
														<select onChange='$("#fldAttitude").val(this.value);' data-theme="a" data-mini='true' data-icon="gear" data-native-menu="true">
															<option selected="unselected">常用语</option>
															<option value="同意！">同意！</option>
															<option value="不同意！">不同意！</option>
															<option value="返回再议。">返回再议。</option>
															<option value="请尽快处理。">请尽快处理。</option>
															<option value="请修改后重新提交。">请修改后重新提交。</option>
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
									 </ul>
								</xsl:if>
									<div data-role="collapsible" data-theme="f" data-content-theme="d">
										<h4>领导指示</h4>
										<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
											<li>
												<xsl:if test="count(//td[@class='top']//table/tbody)=0">
													<font color="red" size="3">无领导指示</font>
												</xsl:if>
												<xsl:apply-templates select="//td[@class='top']//table/tbody" mode="leader"/>
											</li>
										</ul>
									</div>
									<div data-role="collapsible" data-theme="f" data-content-theme="d">
										<h4>基本信息</h4>
									<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
										<li>
											<xsl:if test="count(//table[@id='table1']/tbody)=0">
												<font color="red" size="3">无基本信息</font>
											</xsl:if>
											<xsl:apply-templates select="//table[@id='table1']/tbody" mode="basedata"/>
											<input type="hidden" id="huiqiandanwei" value="{substring-after(//table[@id='table1']/tbody/tr[5]/td/table/tbody/tr/td[3]/.,'：')}"/>
										</li>
									</ul>
									</div>
									<div data-role="collapsible" data-collapsed="false" data-theme="f" data-content-theme="d">
										<h4>审批意见</h4>
										<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
										<li>
											<xsl:if test="count(//table[@id='agyj']//tbody//tr)=0">
												<font color="red" size="3">无</font>
											</xsl:if>
											<xsl:apply-templates select="//table[@id='agyj']//tbody//tr" mode="mindinfo"/>
										</li>
										</ul>
									</div>
									<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
									<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
								</div>
							</form>
						</div>
					</body>
				</html>
	</xsl:template>
	
	<!-- 将隐藏控件传入 -->
	<xsl:template match="input" mode="hidden">
		<xsl:if test="@name!='$$querysaveagent'">
			<input type="hidden" id="{@name}" name="{@name}" value="{@value}"/>
		</xsl:if>
	</xsl:template>

	<!-- 字符串倒叙查找子字符串 -->
	<xsl:template name="substring-after-last">
	  <xsl:param name="string" />
	  <xsl:param name="delimiter" />
	  <xsl:choose>
		<xsl:when test="contains($string, $delimiter)">
		  <xsl:call-template name="substring-after-last">
			<xsl:with-param name="string"
			  select="substring-after($string, $delimiter)" />
			<xsl:with-param name="delimiter" select="$delimiter" />
		  </xsl:call-template>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="$string" /></xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
	<!--正文-->
	<xsl:template name="attachedFiles">
		<xsl:param name="fileunids"/>
		<xsl:param name="FileInfosValue"/>
		<xsl:variable name="fileunid" select="substring-before(substring-after($FileInfosValue,'&lt;file_unid&gt;'),'&lt;/file_unid&gt;')"/>
		<xsl:variable name="file" select="substring-before(substring-after($FileInfosValue,'&lt;file_name&gt;'),'&lt;/file_name&gt;')"/>
		<xsl:variable name="docunid" select="substring-before(substring-after($FileInfosValue,'&lt;doc_unid&gt;'),'&lt;/doc_unid&gt;')"/>
		<xsl:variable name="filetype">
			<xsl:call-template name="substring-after-last">
			    <xsl:with-param name="string" select="$file" />
			    <xsl:with-param name="delimiter" select="'.'" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="type" select="translate($filetype, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:if test="not(contains($fileunids, $fileunid))">
				<li>
					<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/doctest/{$dbPath}/0/{$docunid}/$file/{$fileunid}.{$filetype}')">
					<xsl:value-of select="$file"/></a>
				</li>
		</xsl:if>
		<xsl:if test="contains(substring-after($FileInfosValue,'/doc_unid'),'file_unid')">
			<xsl:call-template name="attachedFiles">
				<xsl:with-param name="fileunids"><xsl:value-of select="$fileunids"/>;<xsl:value-of select="$fileunid"/>;</xsl:with-param>
				<xsl:with-param name="FileInfosValue" select="substring-after($FileInfosValue,'/doc_unid')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- 处理领导审批 -->
	<xsl:template match="tbody" mode="leader">
		<div>
			<div style="width:100%;line-height:1.8;" align="left">
				指示意见:<xsl:value-of select="tr[1]/td/text()"/><br/>
				指示时间:<xsl:value-of select="tr[2]/td/text()"/><br/>
				指示领导:<xsl:value-of select="substring-before(tr[2]/td/span/text(),'/')"/>
			</div>
		</div>
		<hr/>
	</xsl:template>
	<!-- 处理基本信息 select="tr[5]/table/tbody/tr"-->
	<xsl:template match="tbody" mode="basedata">	
		<xsl:value-of select="tr[5]/td/table/tbody/tr/td[1]/." /><hr/>
		<xsl:value-of select="tr[5]/td/table/tbody/tr/td[2]/." /><hr/>
		<xsl:value-of select="tr[5]/td/table/tbody/tr/td[3]/." /><hr/>
			<xsl:apply-templates select="tr[5]/td/table/tbody/tr/td[4]/table/tbody/tr[2]" mode="yu1"/>
			<xsl:apply-templates select="tr[5]/td/table/tbody/tr/td[5]/table/tbody//tr" mode="yu9"/>
		<xsl:value-of select="tr[6]/." /><hr/>
	</xsl:template>
	<xsl:template match="tr" mode="yu1">	
		签报人：<xsl:value-of select="substring-before(td/.,'/')"/><hr/>
		签报时间：<xsl:value-of select="substring-after(td/.,'/genertec')"/><hr/>
	</xsl:template>
	<xsl:template match="tr" mode="yu9">
		<xsl:variable name="trnumber" select="position()"/>
		<xsl:choose>
				<xsl:when test="$trnumber=1">
					<xsl:value-of select="td[1]/."/><xsl:value-of select="substring-before(td[2]/.,'/')"/><hr/>
				</xsl:when>
				<xsl:when test="$trnumber!=1">
					<xsl:value-of select="td[1]/."/><xsl:value-of select="td[2]/."/><hr/>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- 处理审批意见 -->
	<xsl:template match="tr" mode="mindinfo">
		<div>
			<div style="width:100%;line-height:1.8;" align="left">
				<xsl:variable name="num" select="position()"/>
			<xsl:choose>
				<xsl:when test="$num mod 2!=0">
					<xsl:value-of select="td[1]/."/>:<xsl:value-of select="substring-before(td[2]/.,'/')"/><br/>
					<xsl:value-of select="td[3]/."/>:<xsl:value-of select="td[4]/."/><br/>
					<xsl:value-of select="td[5]/."/>:<xsl:value-of select="td[6]/."/><br/>
				</xsl:when>
				<xsl:when test="$num mod 2=0">
					意  见:<xsl:value-of select="td[2]/."/><br/><hr/>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
			</div>
		</div>
		
	</xsl:template>
</xsl:stylesheet>