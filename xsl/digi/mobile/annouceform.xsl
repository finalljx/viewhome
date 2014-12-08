<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
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
   function viewfile(url) {
   		var url = $(url).data("url");
   		url=url.substring(3);
   		url=$.hori.getconfig().appServerHost+'view/oa/file'+url;
   		alert(url);
		localStorage.setItem("attachmentUrl", url);
		$.hori.loadPage($.hori.getconfig().serverBaseUrl
				+ "viewhome/html/attachmentShowForm.html",
				$.hori.getconfig().serverBaseUrl
						+ "viewhome/xml/AttachView.xml");
	}
	function viewfile1(item) {
		var url = item.url();
		if(url==""){
		   return;
		}
		var size=localStorage.getItem("serverLength");
		var number=parseInt(size)+7;
		url=url.substring(number);
		url=$.hori.getconfig().appServerHost+'view/oa/file'+url;
		localStorage.setItem("attachmentUrl", url);
		$.hori.loadPage($.hori.getconfig().serverBaseUrl
				+ "viewhome/html/attachmentShowForm.html",
				$.hori.getconfig().serverBaseUrl
						+ "viewhome/xml/AttachView.xml");
	}
	function getAttach(){
  			var server = "oa-a.crsc.isc";
  			localStorage.setItem("serverLength",server.length);
	        var dbpath =$("#dbpath").val();
	        var unid=localStorage.getItem("annoucedocunid");
  		   var AttachMentUrl=$.hori.getconfig().appServerHost+"view/oa/attach/Produce/SysInterface.nsf/getAttachment?openagent&server="+server+"&dbpath="+dbpath+"&unid="+unid+"&data-result=text";
           $.hori.ajax({
				"type":"post",
				"url":AttachMentUrl,
				"success":function(res){
				var list = JSON.parse(res);
				if(list.word[0]==undefined){
					list.word[0]={"name":"无正文内容","url":""};
					
					}
					jsonData.word=list.word;
					renderDetail();
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
     ]]>
				</script>
				<style>
					img{
					display: block;
					margin: auto;
					width:100%;
					}
					div.message{
					text-indent: 34px;
					}
				</style>
			</head>
			<body onload="getAttach()">
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<xsl:variable name="dbpath"
							select="//input[@name='DF_DbPath']/@value" />
						<input type="hidden" id="dbpath" value="{$dbpath}" />
						<div data-role="collapsible" data-collapsed="false"
							data-theme="f">
							<h1>基本信息</h1>
							<div>
								<ul data-role="listview" data-inset="true" data-theme="d"
									style="word-wrap:break-word">
									<li>
										<xsl:value-of select="//label[@for='DraftManCn']" />
										：
										<xsl:value-of select="//input[@name='DraftManCn']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='Dept']" />
										：
										<xsl:value-of select="//input[@name='showdeptname']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='DraftDate']" />
										：
										<xsl:value-of select="//input[@name='DraftDate']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='Import']" />
										:
										<xsl:value-of select="//input[@name='Import']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='PubObject']" />
										:
										<xsl:value-of select="//input[@name='PubObject']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='PubDate']" />
										:
										<xsl:value-of select="//input[@name='PubDate']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='OldDate']" />
										:
										<xsl:value-of select="//input[@name='OldDate']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='ClassName']" />
										:
										<xsl:value-of select="//input[@name='ClassName']/@value" />
									</li>
									<li>
										<xsl:value-of select="//label[@for='TopNews']" />
										:
										<xsl:value-of select="//input[@name='TopNews']/@value" />
									</li>

								</ul>
							</div>
						</div>
						<div data-role="collapsible" data-collapsed="true" data-theme="f">
							<h1>正文内容</h1>
							<div
								style="font-weight:bold;font-size:20px;height:45px;color:#000066;padding-top:20px;text-align:center;word-break:break-all">
								<xsl:value-of
									select="//div[@style='font-weight:bold;font-size:15pt;height:60px;color:#000066;padding-top:20px;text-align:center;word-break:break-all']/text()" />
							</div>
							<div
								style="font-size:15px;height:20px;padding-top:5px;text-align:center">
								<xsl:value-of select="//input[@name='DraftDate']/@value"></xsl:value-of>
								<xsl:text> </xsl:text>
								<xsl:value-of select="//input[@name='DraftManCn']/@value"></xsl:value-of>
								<xsl:text> </xsl:text>
								<xsl:value-of select="//input[@name='showdeptname']/@value"></xsl:value-of>
							</div>
							<br />
							<div>
								<ul data-role="listview" data-inset="true" data-theme="d"
									style="word-wrap:break-word">
									<li data-role="list-divider">正文</li>
									<li id="word" data-bind="foreach: word">
										<a data-role="button" data-bind="click:viewfile1">
											<span data-bind="text: name"></span>
										</a>
									</li>
									<li data-role="list-divider">附件信息</li>
									<xsl:apply-templates
										select="//tr[@style='width:100%;display:block']/td/a" mode="a" />
								</ul>
							</div>
							<!-- <div align="left" class="message"> <xsl:value-of select="//textarea[@name='Fck_HTML']"></xsl:value-of> 
								<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word"> 
								<li data-role="list-divider">附件信息</li> <xsl:apply-templates select="//tr[@style='width:100%;display:block']/td/a" 
								mode="a"/> </ul> </div> -->
						</div>
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
