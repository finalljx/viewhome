<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="appdbpath"><xsl:value-of select="//input[@name='appdbpath']/@value"/></xsl:variable>
<xsl:variable name="appformname"><xsl:value-of select="//input[@name='appformname']/@value"/></xsl:variable>
<xsl:variable name="username">
	<xsl:value-of select="substring-before(substring-after(//input[@name='curUser']/@value,'CN='),'/O=')"/>
</xsl:variable>
<!-- 表单变量 --> 
<xsl:variable name="dbPath">
	<xsl:value-of select="//input[@name='dbpath' or @name='dbPath' or @name='dbPath1']/@value" />
</xsl:variable>
<xsl:variable name="panduanbiaodan">
	<xsl:value-of select="//input[@id='panduanbiaodan']/@value" />
</xsl:variable>
<xsl:variable name="unId">
	<xsl:choose><xsl:when test="contains(//url/text(),'/0/')"><xsl:value-of select="substring-before(substring-after(//url/text(),'/0/'),'?')" /></xsl:when><xsl:when test="contains(//url/text(),'/vwDocByDate/')"><xsl:value-of select="substring-before(substring-after(//url/text(),'/vwDocByDate/'),'?')" /></xsl:when><xsl:otherwise><xsl:value-of select="substring-before(substring-after(substring-after(//url/text(),'nsf/'),'/'),'?')" /></xsl:otherwise></xsl:choose>
</xsl:variable>
<xsl:template match="/">
<html lang="zh_cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1.0" />
<script type="application/javascript" src="/view/assets/iscroll.js"></script>
<link rel="stylesheet" href="/view/lib/jquery-mobile/jquery.mobile.min.css" />
<link rel="stylesheet" href="/view/assets/jquery.mobile-sugon.css" />
<link href="/view/lib/jquery-mobile/jquery-mobile-fluid960.css" rel="stylesheet"></link>
<script src="/view/lib/jquery/jquery.min.js"></script>
<script src="/view/lib/hori/hori.js?tag=21369"></script>
<script src="/view/lib/jquery-mobile/jquery.mobile.min.js"></script>
<script src="/view/config/web/config.js"></script>
<script>
<![CDATA[
	$(document).ready(function(){
		var hori=$.hori;
		/*设置标题*/
		hori.setHeaderTitle("集团文件系统会签处理单");
		$.hori.hideLoading();
	});
	//viewfile 附件函数
	function viewfile(url){
		//alert(url);
		localStorage.setItem("attachmentUrl",url);
		var fileurl = $.hori.getconfig().appServerHost+"view/html/attachmentShowForm.html";
		var xmlurl;
		if(window.navigator.userAgent.match(/android/i)){
			xmlurl ="viewhome/xml/AttachView.xml";
		}else{
			var iosVersion = localStorage.getItem("iosVersion");
			if(iosVersion=="hight"){
				xmlurl ="viewhome/xml/AttachView4I8.xml";
			}else if(iosVersion=="down"){
				xmlurl ="viewhome/xml/AttachView4I.xml";
			}
		}
		$.hori.loadPage(fileurl,xmlurl);
	}
	
	function signsubmit(value){
		postForm(value);
	}
	function signreceive(val){
		postForm(val);
	}
	function postForm(type){
		//客户端时，服务器通过截取当前url获取cookie_userstore
		if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)||window.navigator.userAgent.match(/android/i)){
			var locationurl=window.location.href;
			var userstorenumber = locationurl.indexOf("data-userstore=");
			var cookie_userstore= locationurl.substring(userstorenumber+15);
			localStorage.setItem("cookie_userstore",cookie_userstore);
			var formAction = $('#form').attr('action')+"&data-userstore="+cookie_userstore;
			$('#form').attr('action', formAction);
		}
		if(type == "signsubmit"){
			$("#querysaveagent").val("agtFlowDeal");
			$("#hfldAction").val("huiqian");
			$("#form").submit();
		}else if(type=="signreject"){
			$("#querysaveagent").val("agtFlowDeny");
			$("#hfldAction").val("huiqian");
			$("#form").submit();
		}else if(type=="signreceive"){
			$("#querysaveagent").val("agtResponse");
			$("#fldswlx").val("部门会签");
			//$("#hfldAction").val("huiqian");
			$("#form").submit();
		}else if(type=="signfankui"){
			$("#querysaveagent").val("agtExecuteAction");
			$("#hfldAction").val("fankui");
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
	<form id="form" action="/view/oa/signsubmit{//form[@name='_frmWebFlow']/@action}" method="post"><br/>
		<div class="ui-grid-b" style="width: 90%; padding-left: 95px;">
			<xsl:if test="//div[contains(@onclick, 'fankui')]">
				<div class="ui-block-a" style="padding-bottom:5px;" align="center">
					<a data-role="button"  onclick="signsubmit('signfankui');" data-mini='true' data-theme="c">部门反馈</a>
				</div>
			</xsl:if>
			<xsl:if test="//div[contains(@onclick, 'agtFlowDeal')]">
				<div class="ui-block-b" style="padding-bottom:5px;" align="center">
					<a data-role="button"  onclick="signsubmit('signsubmit');" data-mini='true' data-theme="c">提　交</a>
				</div>
			</xsl:if>
			<xsl:if test="//div[contains(@onclick, 'agtFlowDeny')]">
				<div class="ui-block-b" style="padding-bottom:5px;" align="center">
					<a data-role="button"  onclick="signsubmit('signreject');" data-mini='true' data-theme="c">驳 回</a>
				</div>
			</xsl:if>
			<xsl:if test="//div[contains(@onclick, 'agtResponse')]">
				<div class="ui-block-c" style="padding-bottom:5px;" align="center">
					<a data-role="button"  onclick="signreceive('signreceive');" data-mini='true' data-theme="c">接  收</a>
				</div>
			</xsl:if>
		</div>
		<input type="hidden" id="querysaveagent" name="$$querysaveagent" value="{//input[@name='$$querysaveagent']/@value}"/>
		<div id="daiban">
			<div align="center">
				<h2><xsl:value-of select="//div[@class='style1']/."/></h2>
			</div>
			<div align="center">
			<TABLE class="hqTable" id="table1" style="width: 85%">
			<TBODY>
				<TR bgColor="#e0e0e0">
					<TD class="hqLabel" width="10%">标题</TD>
					<TD class="hqContent" width="90%" colspan="3">
						<xsl:if test="count(//table[@class='tbl'])!=0">
							<xsl:value-of select="substring-after(//table[@class='tbl' and @width='90%']/tbody/tr[3]/.,'标　　题：')"/>
						</xsl:if>
						<xsl:if test="count(//input[@name='fldSubject'])!=0">
							<xsl:value-of select="//input[@name='fldSubject']/@value" />
						</xsl:if>
					</TD>			
				</TR>
				<xsl:choose>
					<xsl:when test="count(//input[@name='fldSubject'])!=0">
						<xsl:apply-templates select="//input[@name='fldSubject']" mode="inputbasedata"/>
					</xsl:when>
					<xsl:when test="count(//table[@class='tbl'])!=0">
						<xsl:apply-templates select="//table[@class='tbl' and @width='90%']/tbody" mode="basedata"/>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</TBODY>
		</TABLE>
		</div>
		<div align="center" style="margin-top: 20px;">
			<div style="width: 100%;">
			<table style="width: 85%">
				<tr>
					<td><span><font face="宋体" size="4"><b>正文附件：</b></font></span></td>
				</tr>
			</table>
			<TABLE class="fjTable" style="width: 85%" id="table2">
				<xsl:if test="count(//span[@id='idxSpan']//param[@name='FileInfos'])=0">
				<TR>
					<TD bgcolor="#f0f0f0" width="100%">无附件</TD>
				</TR>
				</xsl:if>
				<xsl:call-template name="attachedFiles">
					<xsl:with-param name="FileInfosValue" select="//param[@name='FileInfos']/@value"/>
				</xsl:call-template>
			</TABLE>
		</div>
	</div>

	<div class="yjdiv" align="center" style="margin-top: 20px;">
		<table style="width: 85%">
			<xsl:if test="count(//textarea[@name='fldAttitude'])!=0">
				 <tr>
					<td>您的意见：</td>
				</tr>
				<tr valign="top">
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
			<table style="width:85%" id="YjTable">
				<xsl:apply-templates select="//table[@id='agyj']//tbody//tr" mode="mindinfo"/>
			</table>
		</table>
		<xsl:apply-templates select="//input" mode="hidden"/>
	</div>
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
			<TR>
				<TD bgcolor="#f0f0f0" width="100%">
				<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/docapp/{$dbPath}/0/{$docunid}/$file/{$fileunid}.{$filetype}')">
				<xsl:value-of select="$file"/></a></TD>
			</TR>
	</xsl:if>
	<xsl:if test="contains(substring-after($FileInfosValue,'/doc_unid'),'file_unid')">
		<xsl:call-template name="attachedFiles">
			<xsl:with-param name="fileunids"><xsl:value-of select="$fileunids"/>;<xsl:value-of select="$fileunid"/>;</xsl:with-param>
			<xsl:with-param name="FileInfosValue" select="substring-after($FileInfosValue,'/doc_unid')"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>


<!-- 处理基本信息input -->
<xsl:template match="input" mode="inputbasedata">
<TR bgcolor="#f0f0f0">
	<xsl:variable name="years" select="substring-after(//input[@name='fldswrq']/@value,'/')"/>
	<xsl:variable name="year" select="substring-after($years,'/')"/>
	<xsl:variable name="day" select="substring-before($years,'/')"/>
	<xsl:variable name="month" select="substring-before(//input[@name='fldswrq']/@value,'/')"/>
	<TD class="hqLabel" width="10%">收文日期:</TD>
	<TD class="hqContent" width="40%"><xsl:value-of select="$year"/>-<xsl:value-of select="$month"/>-<xsl:value-of select="$day"/></TD>
	<TD class="hqLabel" width="10%">来文单位:</TD><TD class="hqContent" width="40%"><xsl:value-of select="//input[@name='fldLwjg']/@value"/></TD>
</TR>
<TR bgColor="#e0e0e0">
	<TD class="hqLabel" width="10%">收文类型:</TD><TD class="hqContent" width="40%"><xsl:value-of select="//input[@name='fldswlx']/@value"/></TD>
	<TD class="hqLabel" width="10%">来文份数:</TD><TD class="hqContent" width="40%"><xsl:value-of select="//input[@name='fldFs']/@value"/></TD>
</TR>
</xsl:template>
<xsl:template match="tbody" mode="basedata">
<TR bgcolor="#f0f0f0">
	<xsl:variable name="years" select="substring-after(substring-before(tr[5]/.,'收 文 号'),'：')"/>
	<xsl:variable name="yday" select="substring-after($years,'/')"/>
	<xsl:variable name="year" select="substring-after($yday,'/')"/>
	<xsl:variable name="month" select="substring-before($years,'/')"/>
	<xsl:variable name="day" select="substring-before($yday,'/')"/> 
	<TD class="hqLabel" width="10%">收文日期：</TD><TD class="hqContent" width="40%"><xsl:value-of select="$year"/>-<xsl:value-of select="$month"/>-<xsl:value-of select="$day"/></TD>
	<TD class="hqLabel" width="10%">来文单位：</TD><TD class="hqContent" width="40%"><xsl:value-of select="substring-after(substring-before(tr[6]/.,'来文字号'),'：')"/></TD>
</TR>
<TR bgColor="#e0e0e0">
	<TD class="hqLabel" width="10%">收文类型:</TD><TD class="hqContent" width="40%"><xsl:value-of select="substring-after(substring-before(tr[7]/.,'收文来源'),'：')"/></TD>
	<TD class="hqLabel" width="10%">来文份数:</TD><TD class="hqContent" width="40%"><xsl:value-of select="substring-after(tr[8]/.,'：')"/></TD>
</TR>
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