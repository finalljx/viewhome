<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" />
	<xsl:template match="/">
<html lang="zh_cn">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="/view/lib/jquery-mobile/jquery.mobile.min.css" />
	<link rel="stylesheet" href="/view/assets/jquery.mobile-sugon.css" />
	<script src="/view/lib/jquery/jquery.min.js"></script>
	<script src="/view/lib/encrypt/encrypt.js"></script>
	<script src="/view/lib/json/json2.js"></script>
	<script src="/view/lib/knockout/knockout.js"></script>
    <script src="/view/lib/knockout/knockout.mapping.js"></script>
	<script src="/view/lib/hori/hori.js?tag=21369"></script>
	<script src="/view/lib/jquery-mobile/jquery.mobile.min.js"></script>
	<script src="/view/config/web/config.js"></script>
  	<script>
  	<![CDATA[
  	    var jsonData = new Object();
  		function getAttach(){
  			var server = "oa-a.crsc.isc";
	        var dbpath = localStorage.getItem("receivedoc");
	        var unid=$("#unid").val();
  			var AttachMentUrl=$.hori.getconfig().appServerHost+"view/oa/attach/Produce/SysInterface.nsf/getAttachment?openagent&server="+server+"&dbpath="+dbpath+"&unid="+unid+"&data-result=text";
             $.hori.ajax({
				"type":"post",
				"url":AttachMentUrl,
				"success":function(res){
					var list = JSON.parse(res);
					if(list.word[0]=='undefined'){
					list.word[0]={"name":"无正文内容","url":""};
					
					}
					jsonData.word=list.word;
					renderDetail();
					if(list.attachment[0]==undefined){
					list.attachment[0]={"name":"无附件","url":""};
					
					}
					jsonData.attachment=list.attachment;
					renderDetail2();
				},
				"error":function(res){
					$.hori.hideLoading();
				}
			});
  		}
  	function renderDetail() {
		var viewModelDetail = ko.mapping.fromJS(jsonData);
		console.log(viewModelDetail);
		ko.applyBindings(viewModelDetail, document.getElementById("word"));
	}
	function renderDetail2() {
		var viewModelDetail = ko.mapping.fromJS(jsonData);
		console.log(viewModelDetail);
		ko.applyBindings(viewModelDetail, document.getElementById("attachment"));
	}
	   function viewfile(item) {
	   
		var url = item.url();
		if(url==""){
		   return;
		}
		localStorage.setItem("attachmentUrl", url);
		$.hori.loadPage($.hori.getconfig().serverBaseUrl
				+ "viewhome/html/attachmentShowForm.html",
				$.hori.getconfig().serverBaseUrl
						+ "viewhome/xml/AttachView.xml");
	}
  	]]>
  	</script>
</head>
<body onload="getAttach()">
	<div id="notice" data-role="page">
		<div data-role="content" align="center">
			<!-- 附件隐藏域 -->
			<xsl:variable name="unid" select="//input[@name='StMaindocUnid_Att']/@value"/>
			<input type="hidden" id="unid" value="{$unid}"/>
		    <div>
		        <ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
					<li data-role="list-divider">收文办理单</li>
					<li><xsl:value-of select="//fieldset[@id='Abstract']/h3" /></li>
				</ul>
			</div>
			<div data-role="collapsible" data-collapsed="false" data-theme="f">
			<h1>基础信息</h1>
			<div>
				<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
					<xsl:apply-templates select="//fieldset[@id='fieldSet1']/div[@class='row']/descendant::div[@class='input-group']" mode="b"/>
				</ul>
			</div>
		</div>
		<div data-role="collapsible" data-collapsed="true" data-theme="f">
			<h1>审批流转意见</h1>
			<div>
	                 <ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
	                    <xsl:if test="not(//table[@class='list']/tbody/tr)">
								    <li>无审批流转意见</li>
						</xsl:if>
						<xsl:if test="//table[@class='list']/tbody/tr">
	                          <xsl:apply-templates select="//table[@class='list']/tbody/tr" mode='tr'/>
	                    </xsl:if>
	                 </ul>
			</div>
		</div>
		<div data-role="collapsible" data-collapsed="true" data-theme="f">
			<h1>正文</h1>
			<div>
	                 <ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word" data-bind="foreach: word" id="word">
	                      <li> <a data-bind="click:viewfile"><span data-bind="text: name"></span></a></li>  
							  
	                 </ul>
			</div>
		</div>
		<div data-role="collapsible" data-collapsed="true" data-theme="f">
			<h1>附件</h1>
			<div>
	                 <ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word" data-bind="foreach: attachment" id="attachment">
	                      <li> <a data-bind="click:viewfile"><span data-bind="text: name"></span></a></li>  
							  
	                 </ul>
			</div>
		</div>
		</div>
		
		
		</div>
	</body>
</html>
	</xsl:template>
	<!-- 处理基础信息 -->
	<xsl:template match="div" mode="b">
		<xsl:variable name="divStyle" select="parent::div/@style" />
			   <xsl:choose>
			        <xsl:when test="not(contains($divStyle, 'display:none'))">
			          <li>
			          <xsl:if test="div[@class='DF_MindInfo']">
				         <xsl:value-of select="span[1][@class='input-group-addon']/label"/>:
				             <xsl:value-of select="div[@class='DF_MindInfo']"/>-----------------
				             <xsl:value-of select="div[@class='DF_QMInfo']"/>
				      </xsl:if>
				     <xsl:if test="not(div[@class='DF_MindInfo'])">
				            <xsl:value-of select="span[1][@class='input-group-addon']/label"/>:
				            <xsl:choose>
				               <xsl:when test="select">
				                  <xsl:value-of select="//option[@selected='selected']/."/>
				               </xsl:when>
				               <xsl:otherwise>
				                  <xsl:value-of select="input[1]/@value"/>
				              </xsl:otherwise>
				          </xsl:choose> 
				     </xsl:if>
				       </li>
			        </xsl:when>
			        <xsl:otherwise>
			        </xsl:otherwise>
			    </xsl:choose>
	</xsl:template>
	<!-- 处理审批流转意见 -->
	<xsl:template match="tr" mode="tr">
		<xsl:variable name="num" select="position()"/>
			<xsl:choose>
				<xsl:when test="$num mod 3=1">
					<li><xsl:value-of select="td[1]/."/><xsl:value-of select="td[2]"/></li>
					<li><xsl:value-of select="td[3]/."/><xsl:value-of select="td[4]/."/></li>
					<li><xsl:value-of select="td[5]/."/><xsl:value-of select="td[6]/."/></li>
				</xsl:when>
				<xsl:when test="$num mod 3=2">
					<li>审批意 见:<xsl:value-of select="td[2]" disable-output-escaping="yes"/><br/></li>
				</xsl:when> 
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
