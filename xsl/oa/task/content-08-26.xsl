<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:variable name="appdbpath"><xsl:value-of select="//input[@name='appdbpath']/@value"/></xsl:variable>
	<xsl:variable name="appformname"><xsl:value-of select="//input[@name='appformname']/@value"/></xsl:variable>
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
				<script>
					$(document).ready(function(){
						var hori=$.hori;
						/*设置标题*/
						hori.setHeaderTitle("单据内容");
					});
				</script>
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<style>
							.ui-listview {
								background: #D61800;
							}
						</style>
						<script>
							<![CDATA[
							//viewfile 附件函数
							function viewfile(url){
								alert(url);return;
								localStorage.setItem("attachmentUrl",url);
								$.hori.loadPage( $.hori.getconfig().serverBaseUrl+"viewhome/html/attachmentShowForm.html", $.hori.getconfig().serverBaseUrl+"viewhome/xml/AttachView.xml");
							}
							
							function post(){
								var appserver = $("#appserver").val();
								
								//将回车变为换行
								FlowMindInfo = FlowMindInfo.replace(/\n/g," ");
								FlowMindInfo = FlowMindInfo.replace(/\r/g," ");
								FlowMindInfo = escape(FlowMindInfo);
								FlowMindInfo = FlowMindInfo.replace(/%20/g," ");
								FlowMindInfo = encodeURI(FlowMindInfo);
								
								var soap =;
								var url = $.hori.getconfig().appServerHost+"view/oa/request/Produce/ProInd.nsf/THFlowBackTraceAgent?openagent&login";
								var data = "data-xml="+soap;
								
								$.hori.ajax({
									type: "post", url: url, data:data,
									success: function(response){
											var result = response;
											$.mobile.hidePageLoadingMsg();
											alert(result+"CUCCESS");
											setTimeout("$.hori.backPage(1)",2000);
									},
									error:function(response){
										$.mobile.hidePageLoadingMsg();
										alert(result);
										setTimeout("$.hori.backPage(1)",1000);
									}
								});
							}

							function submit(value){
								var sel = $("#FlowMindInfo").val();
								if(sel == null || sel==""){
									alert('请填写您的意见');
									return ;
								}
								//提交
								if(value=="reject"){
									var question = window.confirm("确定驳回吗?"); 
								}else{
									var question = window.confirm("确定提交吗?"); 
								}
								post(value, toflownodeid);
							}
						]]>
						</script>
						
						<div class="ui-grid-b">
							<div class="ui-block-a" style="padding-bottom:5px;" align="center">
								<a data-role="button" value="submit" onclick="submit('submit');" data-mini='true' data-theme="f">提 交</a>
							</div>
							<div class="ui-block-b" style="padding-bottom:5px;" align="center">
								<a data-role="button" value="reject" onclick="submit('reject');" data-mini='true' data-theme="f">驳 回</a>
							</div>
							<div class="ui-block-c" style="padding-bottom:5px;" align="center">
								<a data-role="button" value="oprate" onclick="" data-mini='true' data-theme="f">会 签</a>
							</div>
						</div>
						<h3><xsl:value-of select="//p[@align='center']//font/text()"/></h3>
						<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
							<li data-role="list-divider">审批意见</li>
								<li>
									<table style="border:0;padding:0;margin:0;" width="100%" border="0">
										<tr style="width:100%">
											<td style="width:70%" align="left">
												
											</td>
											<td style="width:30%" align="right">
												<select onChange='$("#FlowMindInfo").val(this.value);' data-theme="a" data-mini='true' data-icon="gear" data-native-menu="true">
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
												<textarea id="FlowMindInfo" name="FlowMindInfo"></textarea>
											</td>
										</tr>
									</table>
								</li>
								
								<li data-role="list-divider">领导指示</li>
								<li>
									<xsl:if test="count(//td[@class='top']//table/tbody)=0">
										<font color="red" size="3">无领导指示</font>
									</xsl:if>
									<xsl:apply-templates select="//td[@class='top']//table/tbody" mode="leader"/>
								</li>
								
								<li data-role="list-divider">基本信息</li>
								<li>
									<xsl:if test="count(//table[@id='table1']/tbody)=0">
										<font color="red" size="3">无基本信息</font>
									</xsl:if>
									<xsl:apply-templates select="//table[@id='table1']/tbody" mode="basedata"/>
								</li>

							<li data-role="list-divider">附件信息</li>
							<li>
								<xsl:if test="count(//span[@id='idxSpan']//file_name)=0">
									无附件
								</xsl:if>
								<xsl:apply-templates select="//span[@id='idxSpan']/object[@id='IndiDocX']" mode="file"/>
							</li>
							<li data-role="list-divider">审批意见</li>
							<li>
								<xsl:if test="count(//table[@id='agyj']//tbody//tr)=0">
									<font color="red" size="3">无</font>
								</xsl:if>
								<xsl:apply-templates select="//table[@id='agyj']//tbody//tr" mode="mindinfo"/>
							</li>
							
						</ul>
					</div>
				</div>
			</body>
		</html>
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
		<xsl:value-of select="tr[4]/." /><hr/>
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
					<xsl:value-of select="td[1]/."/>:<xsl:value-of select="td[2]/."/><br/><hr/>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
			</div>
		</div>
		
	</xsl:template>

	<!-- 处理 附件 目前支持到5个附件-->	
	<xsl:template match="object" mode="file">
		<xsl:variable name="str" select="substring-after(param[@name='Nodelfiles']/@value,'\')"/>
		<xsl:choose>
			<xsl:when test="contains($str,'\')">
				<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="substring-before($str,'\')"/></a></li>
				
				<xsl:variable name="str2" select="substring-after($str,'\')"/>
				<xsl:choose>
					<xsl:when test="contains($str2, '\')">
						<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="file_name[2]/."/></a></li>
						<xsl:variable name="str3" select="substring-after($str2,'\')"/>
						<xsl:choose>
							<xsl:when test="contains($str3, '\')">
								<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="substring-before($str3,'\')"/></a></li>
								<xsl:variable name="str4" select="substring-after($str3,'\')"/>
								<xsl:choose>
									<xsl:when test="contains($str4, '\')">
										<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="substring-before($str4,'\')"/></a>
										<xsl:variable name="str5" select="substring-after($str4,'\')"/>
										<xsl:choose>
											<xsl:when test="contains($str5, '\')">
												<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="substring-before($str5,'\')"/></a>
											</xsl:when>
											<xsl:otherwise>
												<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="$str5"/></a>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="$str4"/></a>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="$str3"/></a></li>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="$str2"/></a>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{param[@name='DbPath']/@value}/0/{doc_unid[1]/.}/$file/{file_unid[1]/.}.{substring-after(file_name[1]/.,'.')}');" data-role="button"><xsl:value-of select="$str"/></a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>