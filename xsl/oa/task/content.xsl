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
					<link rel="stylesheet" href="http://lib.sinaapp.com/js/jquery-mobile/1.3.1/jquery.mobile-1.3.1.min.css" />
					<link rel="stylesheet" href="/view/assets/jquery.mobile-sugon.css" />
					<script src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
					<script src="/view/lib/json/json2.js"></script>
					<script src="/view/lib/hori/hori.js?tag=21369"></script>
					<script src="http://lib.sinaapp.com/js/jquery-mobile/1.3.1/jquery.mobile-1.3.1.min.js"></script>
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
								var xmlurl;
								if(window.navigator.userAgent.match(/android/i)){
									xmlurl ="viewhome/xml/AttachView.xml";
								}else{
									xmlurl ="viewhome/xml/AttachView4I.xml";
								}
								$.hori.loadPage(fileurl,xmlurl);
							}
							function querysubmit(value){
								$.hori.showLoading();
								if(value=="querysign"){
									var huiqiandanwei = $("#signdanwei").text();
									var signSerialNumber = $("#fldFwbh").val();
									if(huiqiandanwei==""||huiqiandanwei==null){
										alert("发起内请时没有选择会签流程，手机端不能处理，请到电脑上处理！");
										$.mobile.hidePageLoadingMsg();
										$.hori.hideLoading();
										return false;
									}else if(signSerialNumber==""||signSerialNumber==null){
										alert("请填写会签编号！");
										$.mobile.hidePageLoadingMsg();
										$.hori.hideLoading();
										return false;
									}
								}
								postForm(value);
							}

							function postForm(type){
								//客户端时，服务器通过截取当前url获取cookie_userstore
								if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)||window.navigator.userAgent.match(/android/i)){
									var locationurl=window.location.href;
									var userstorenumber = locationurl.indexOf("data-userstore=");
									var cookie_userstore= locationurl.substring(userstorenumber+15);
									localStorage.setItem("cookie_userstore",cookie_userstore)
									var formAction = $('#form').attr('action')+"&data-userstore="+cookie_userstore;
									$('#form').attr('action', formAction);
								}
								if(type == "querysubmit"){
									$("#querysaveagent").val("agtFlowDeal");
									$("#form").submit();
								}else if(type=="queryreject"){
									$("#querysaveagent").val("agtFlowDeny");
									$("#form").submit();
								}else if(type=="querysave"){
									$("#querysaveagent").val("agtSaveDraftNoExit");
									$("#form").submit();
									//document.location.reload();
									//$.hori.backPage(1)
								}else if(type=="querysign"){
									$("#querysaveagent").val("agtExecuteAction");
									$("#hfldAction").val("huiqian");
									$("#form").submit();
								}
							}
						]]>
						</script>
	<style>
		.ui-btn-text{text-align: center;}
		.ui-listview {background:
		#D61800;}
		.rightHei { border-right: 1px solid #000000} 
        .btmHei { border-bottom: 1px solid #000000} 
        .ztDx { font-size: 16px;} 
	</style>
</head>
<body>
	<div id="notice" data-role="page"><br/>
		<form id="form" action="/view/oa/submit{//form[@name='_frmWebFlow']/@action}" method="post">
		<input type="hidden" id="querysaveagent" name="$$querysaveagent" value="{//input[@name='$$querysaveagent']/@value}" />
		<input type="hidden" id="huiqiandanwei" value="{substring-after(//table[@id='table1']/tbody/tr[5]/td/table/tbody/tr/td[3]/.,'：')}"/>
	 	<div class="ui-grid-c" style="width: 90%; padding-left: 60;">
			<xsl:if test="//div[contains(@onclick, 'agtFlowDeal')]">
				<div class="ui-block-a" style="padding-bottom:5px;" align="center">
					<a data-role="button" value="submit" onclick="querysubmit('querysubmit');" data-mini='true' data-theme="c">提 交</a>
				</div>
			</xsl:if>
			<xsl:if test="//div[contains(@onclick, 'agtFlowDeny')]">
				<div class="ui-block-b" style="padding-bottom:5px;" align="center">
					<a data-role="button" value="reject" onclick="querysubmit('queryreject');" data-mini='true' data-theme="c">驳 回</a>
				</div>
			</xsl:if>
			<xsl:if test="//div[contains(@onclick, 'huiqian')]">
				<div class="ui-block-c" style="padding-bottom:5px;" align="center">
					<a data-role="button" value="oprate" onclick="querysubmit('querysign');" data-mini='true' data-theme="c">会 签</a>
				</div>
			</xsl:if>
			<xsl:if test="//*[@name='fldAttitude']">
				<div class="ui-block-d" style="padding-bottom:5px;" align="center">
					<a data-role="button" value="reject" onclick="querysubmit('querysave');" data-mini='true' data-theme="c">保 存</a>
				</div>
			</xsl:if>
		</div><br/>
			<table border="0" width="90%" cellspacing="0" cellpadding="0" id="table1" align="center">
				<tbody>
					<tr><td colspan="4"><p align="center"><b>
						<font size="5"><xsl:value-of select="//table[@id='table1']/tbody/tr[1]/." /></font></b></p></td>
					</tr>
					<xsl:if test="//div[contains(@onclick, 'huiqian')]">
					<tr><td><b><font size="4"><br/>
						请示编号：</font></b></td><td style="width: 90%;"><input name="fldFwbh" data-mini="true" id="fldFwbh" type="text" value="{//input[@name='fldFwbh']/@value}"/></td>
					</tr>
					</xsl:if>
					<!-- 领导指示 -->
					<tr>
						<td colspan="4" style="border:1px solid #000000; " class="top" height="120" valign="top"> 
							<b><br> <font class="ztDx">领导指示：</font></br></b><b></b>
							<xsl:apply-templates select="//table[@id='table1']/tbody/tr[3]/td//table" mode="leaderMind"/>
						</td>
					</tr>
					<tr><td colspan="4" class="btmHei"><font class="ztDx"><b><br />
						<xsl:value-of select="//table[@id='table1']/tbody/tr[4]/." />
						<xsl:value-of select="//input[@name='fldSubject']/@value" /></b></font></td>
					</tr>
					<tr><td colspan="4">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>
							<tr><td width="18%" height="188" valign="top" class="rightHei">
								<font class=" ztDx ">
									<br />
									<b><xsl:value-of select="substring-before(//td[@class='rightHei'][1]/.,'：')" />:</b>
									<br />
									<br />
									<font style="font-size:12pt"><xsl:value-of select="//td[@class='rightHei'][1]/font/text()" />
									<xsl:value-of select="//td[@class='rightHei'][1]/font/font/text()" />
									<xsl:value-of select="//td[@class='rightHei'][1]/font/font/select/option[@selected='selected']/." /></font>
									<xsl:if test="//td[@class='rightHei'][1]/font/font/select/option[contains(@selected,'selected')]">
										<input type="hidden" name="fldSelSPQX" value="{//td[@class='rightHei'][1]/font/font/select/option[@selected='selected']/@value}"/>
									</xsl:if>
								</font>
								</td>
								<td width="20%" height="188" valign="top" class="rightHei">
									<font class=" ztDx ">
										<br />
										<b><xsl:value-of select="substring-before(//td[@class='rightHei'][2]/.,'：')" />:</b>
										<br />
										<br />
										<font style="font-size:12pt"><xsl:value-of select="substring-after(//td[@class='rightHei'][2]/.,'：')" /></font>
									</font>
								</td>
								<td width="20%" valign="top" class="rightHei">
									<font class=" ztDx ">
										<br />
										<b><xsl:value-of select="substring-before(//td[@class='rightHei'][3]/.,'：')" />:</b>
										<br />
										<br />
										<font style="font-size:12pt" id="signdanwei"><xsl:value-of select="//td[@class='rightHei'][3]/table/tbody/tr/td[2]/."/>
										<xsl:value-of select="//textarea[@name='flddanwei']/." />
										<xsl:value-of select="tr[5]/td/table/tbody/tr/td[3]/span[2]/text()" /></font>
									</font>
								</td>
								<td width="15%" valign="top" class="rightHei">
									<font class=" ztDx ">
										<br />
										<b><xsl:value-of select="substring-before(//td[@class='rightHei'][4]/.,'：')" />:</b>
										<br />
										<br />
										<font style="font-size:12pt">
										<xsl:apply-templates select="//td[@class='rightHei'][4]//table"  mode="sinePerson"/>
										</font>
									</font>
								</td>
										<td width="31%" valign="top">
											<br />
											<table width="100%" height="130" border="0"
												cellpadding="0" cellspacing="0">
												<tbody>
													<tr>
														<td width="90" align="right">
															<font class=" ztDx ">
																<b><xsl:value-of select="substring-before(//table[@height='130' and @width='100%']/tbody/tr[1]/.,'：')" />：</b>
															</font>
														</td>
														<td>
															<span class="userName"><xsl:value-of select="substring-before(substring-after(//table[@height='130' and @width='100%']/tbody/tr[1]/.,'：'),'/')" />
															<xsl:value-of select="substring-before(//table[@height='130' and @width='100%']/tbody/tr[1]//input/@value,'/')" /></span>
															<input type="hidden" name="{//table[@height='130' and @width='100%']/tbody/tr[1]//input/@name}" value="{//table[@height='130' and @width='100%']/tbody/tr[1]//input/@value}"/>
														</td>
													</tr>
													<tr>
														<td width="90" align="right">
															<font class=" ztDx ">
																<b><xsl:value-of select="substring-before(//table[@height='130' and @width='100%']/tbody/tr[2]/.,'：')" />：</b>
															</font>
														</td>
														<td><xsl:value-of select="substring-after(//table[@height='130' and @width='100%']/tbody/tr[2]/.,'：')" />
															<xsl:value-of select="//table[@height='130' and @width='100%']/tbody/tr[2]//input/@value" />
															<input type="hidden" name="{//table[@height='130' and @width='100%']/tbody/tr[2]//input/@name}" value="{//table[@height='130' and @width='100%']/tbody/tr[2]//input/@value}"/></td>
													</tr>
													<tr>
														<td width="90" align="right">
															<font class=" ztDx ">
																<b><xsl:value-of select="substring-before(//table[@height='130' and @width='100%']/tbody/tr[3]/.,'：')" />：</b>
															</font>
														</td>
														<td><xsl:value-of select="substring-after(//table[@height='130' and @width='100%']/tbody/tr[3]/.,'：')" />
															<xsl:value-of select="//table[@height='130' and @width='100%']/tbody/tr[3]//input/@value" />
															<input type="hidden" name="{//table[@height='130' and @width='100%']/tbody/tr[3]//input/@name}" value="{//table[@height='130' and @width='100%']/tbody/tr[3]//input/@value}"/></td>
													</tr>
													<tr>
														<td width="90" align="right">
															<font class=" ztDx ">
																<b><xsl:value-of select="substring-before(//table[@height='130' and @width='100%']/tbody/tr[4]/.,'：')" />：</b>
															</font>
														</td>
														<td><xsl:value-of select="substring-after(//table[@height='130' and @width='100%']/tbody/tr[4]/.,'：')" />
															<xsl:value-of select="//table[@height='130' and @width='100%']/tbody/tr[4]//input/@value" />
															<input type="hidden" name="{//table[@height='130' and @width='100%']/tbody/tr[4]//input/@name}" value="{//table[@height='130' and @width='100%']/tbody/tr[4]//input/@value}"/></td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td class="btmHei" style="border-top:1px solid #000000; " colspan="4">
						<font class="ztDx"><b><br/>会签部门意见:</b></font><br/>
							<xsl:apply-templates select="//table[@id='table1']/tbody/tr[6]/td//table"  mode="signMind"/>
						</td>
					</tr>
				</tbody>
			</table>
			<div align="center" style="margin-top: 20px;">
				<div style="width: 100%;">
					<table style="width: 90%">
						<tr>
							<td>
								<span>
									<font face="宋体" size="4">
										<b>正文附件：</b>
									</font>
								</span>
							</td>
						</tr>
					</table>
					<TABLE class="fjTable" style="width: 90%" id="table2">
							<xsl:call-template name="attachedFiles">
								<xsl:with-param name="FileInfosValue" select="//param[@name='FileInfos']/@value"/>
							</xsl:call-template>
					</TABLE>
				</div>
				<div class="yjdiv" align="center" style="margin-top: 20px;">
					<table style="width: 90%" id="YjTable">
					<xsl:if test="count(//textarea[@name='fldAttitude'])!=0">
						<tr valign="top">
						<p style="text-align: left;padding-left: 70px;">您的意见：</p>
						<td width="227"> 
						<select onChange='$("#fldAttitude").val(this.value);' data-theme="c" data-mini='true' data-icon="false" >
							<option selected="unselected">常用语</option>
							<option value="同意">同意</option>
							<option value="不同意">不同意</option>
							<option value="通过">通过</option>
							<option value="已阅">已阅</option>
						</select>
						<textarea id="fldAttitude" name="fldAttitude" style="width:600;height:100" rows="3" cols="30">
						<xsl:value-of select="//textarea[@name='fldAttitude']/text()"/></textarea>
						 </td><td></td>
						 </tr>
					</xsl:if>
						 <tr>
							<td>审批意见：</td>
						</tr>
						<xsl:apply-templates select="//table[@id='agyj']//tbody//tr" mode="mindinfo"/>
					</table>
					<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
					<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
				</div>
			</div>
				</form>
			</div>
		</body>
	</html>
</xsl:template>
<!-- 处理领导指示 -->
<xsl:template match="table" mode="leaderMind">
	<table width="100%" border="0">
	 <tbody>
	  <tr>
	   <td style="font-size:12pt"><xsl:value-of select="tbody/tr[1]/td/text()" /></td>
	  </tr>
	  <tr>
	    <td style="font-size:12pt" align="right"><span class="userName"><xsl:value-of select="tbody/tr[2]/td/span/text()" /></span><xsl:value-of select="tbody/tr[2]/td/text()" /></td>
	  </tr>
	 </tbody>
	</table>
</xsl:template>
<!-- 处理会签审批 -->
<xsl:template match="table" mode="signMind">
	<table width="100%" border="0">
     <tbody>
      <tr>
       <td style="font-size:12pt"><xsl:value-of select="tbody/tr[1]/td/text()" /></td>
      </tr>
      <tr>
       <td style="font-size:12pt" align="right"><span class="userName"><xsl:value-of select="tbody/tr[2]/td/span/text()" /></span><xsl:value-of select="tbody/tr[2]/td/text()" /></td>
      </tr>
     </tbody>
    </table>
</xsl:template>
<!-- 签报人 -->
<xsl:template match="table" mode="sinePerson">
	<table width="100%" border="0">
     <tbody>
      <tr>
       <td style="font-size:12pt"><xsl:value-of select="tbody/tr[1]/td/text()" /></td>
      </tr>
      <tr>
       <td style="font-size:12pt" align="right"><span class="userName"><xsl:value-of select="tbody/tr[2]/td/span/text()" /></span><xsl:value-of select="tbody/tr[2]/td/text()" /></td>
      </tr>
     </tbody>
    </table>
</xsl:template>
<!-- 将隐藏控件传入 -->
<xsl:template match="input" mode="hidden">
<xsl:if test="@name!='$$querysaveagent'">
<input type="hidden" id="{@name}" name="{@name}" value="{@value}" />
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
<xsl:otherwise>
	<xsl:value-of select="$string" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<!--正文 -->
<xsl:template name="attachedFiles">
<xsl:param name="fileunids" />
<xsl:param name="FileInfosValue" />
<xsl:variable name="fileunid"
select="substring-before(substring-after($FileInfosValue,'&lt;file_unid&gt;'),'&lt;/file_unid&gt;')" />
<xsl:variable name="file"
select="substring-before(substring-after($FileInfosValue,'&lt;file_name&gt;'),'&lt;/file_name&gt;')" />
<xsl:variable name="docunid"
select="substring-before(substring-after($FileInfosValue,'&lt;doc_unid&gt;'),'&lt;/doc_unid&gt;')" />
<xsl:variable name="filetype">
<xsl:call-template name="substring-after-last">
	<xsl:with-param name="string" select="$file" />
	<xsl:with-param name="delimiter" select="'.'" />
	</xsl:call-template>
</xsl:variable>
<xsl:variable name="type"
select="translate($filetype, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
<xsl:if test="not(contains($fileunids, $fileunid))">
	<tbody><tr>
		<td bgcolor="#f0f0f0" width="100%">
			<a href="javascript:void(0)"
				onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/'+$.hori.getconfig().docServer+'/{$dbPath}/0/{$docunid}/$file/{$fileunid}.{$filetype}')">
				<xsl:value-of select="$file" />
				</a>
		</td>
		</tr>
	</tbody>

</xsl:if>
<xsl:if
	test="contains(substring-after($FileInfosValue,'/doc_unid'),'file_unid')">
<xsl:call-template name="attachedFiles">
	<xsl:with-param name="fileunids">
		<xsl:value-of select="$fileunids" />
		;
		<xsl:value-of select="$fileunid" />
		;
	</xsl:with-param>
	<xsl:with-param name="FileInfosValue"
		select="substring-after($FileInfosValue,'/doc_unid')" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!-- 处理领导审批 -->
<xsl:template match="tbody" mode="leader">
<div>
	<div style="width:100%;line-height:1.8;" align="left">
	指示意见:
	<xsl:value-of select="tr[1]/td/text()" />
	<br />
	指示时间:
	<xsl:value-of select="tr[2]/td/text()" />
	<br />
	指示领导:
	<xsl:value-of select="substring-before(tr[2]/td/span/text(),'/')" />
		</div>
	</div>
	<hr />
</xsl:template>
<!-- 处理基本信息 select="tr[5]/table/tbody/tr" -->
<xsl:template match="tbody" mode="basedata">
<xsl:value-of select="tr[5]/td/table/tbody/tr/td[1]/." />
<hr />
<xsl:value-of select="tr[5]/td/table/tbody/tr/td[2]/." />
<hr />
<xsl:value-of select="tr[5]/td/table/tbody/tr/td[3]/." />
<hr />
<xsl:apply-templates select="tr[5]/td/table/tbody/tr/td[4]/table/tbody/tr[2]"
mode="yu1" />
<xsl:apply-templates select="tr[5]/td/table/tbody/tr/td[5]/table/tbody//tr"
mode="yu9" />
<xsl:value-of select="tr[6]/." />
	<hr />
</xsl:template>
<xsl:template match="tr" mode="yu1">
签报人：
<xsl:value-of select="substring-before(td/.,'/')" />
<hr />
签报时间：
<xsl:value-of select="substring-after(td/.,'/genertec')" />
	<hr />
</xsl:template>
<xsl:template match="tr" mode="yu9">
<xsl:variable name="trnumber" select="position()" />
<xsl:choose>
	<xsl:when test="$trnumber=1">
	<xsl:value-of select="td[1]/." />
	<xsl:value-of select="substring-before(td[2]/.,'/')" />
	<hr />
</xsl:when>
<xsl:when test="$trnumber!=1">
	<xsl:value-of select="td[1]/." />
	<xsl:value-of select="td[2]/." />
			<hr />
		</xsl:when>
		<xsl:otherwise>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- 处理审批意见 -->
<xsl:template match="tr" mode="mindinfo">
	<xsl:variable name="num" select="position()" />
	<xsl:choose>
		<xsl:when test="$num mod 2!=0">
		<tr bgcolor="#E0E0E0">
			<td width="10%" class="yjLabel"><xsl:value-of select="td[1]/." /></td>
			<td width="30%" class="yjContent"><span class="userName"><xsl:value-of select="substring-before(td[2]/.,'/')" /></span></td>
			<td width="10%" class="yjLabel"><xsl:value-of select="td[3]/." /></td>
			<td width="20%" class="yjContent"><xsl:value-of select="td[4]/." /></td>
			<td width="10%" class="yjLabel"><xsl:value-of select="td[5]/." /></td>
			<td width="20%" class="yjContent"><xsl:value-of select="td[6]/." /></td>
		</tr>
		</xsl:when>
		<xsl:when test="$num mod 2=0">
		<tr bgcolor="#F0F0F0">
			<td class="yjLabel">意 见</td>
			<td colspan="5" class="yjContent"><xsl:value-of select="td[2]/." /></td>
		</tr>
		</xsl:when>
		<xsl:otherwise>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
