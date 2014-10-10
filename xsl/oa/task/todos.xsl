<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
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
			<![CDATA[
			function loadPageForm(str){
				var template ="todoscontent";
				var unid = $(str).data("unid");
				var type = $(str).data("type");
				if(type=="会签库"){
					template="signcontent";
				}
				var itcode=localStorage.getItem("Chinesename");
				localStorage.setItem("contemplate",template);
				localStorage.setItem("unid",unid);
				var loadurl= $.hori.getconfig().appServerHost+"view/oa/"+template+"/docapp/genertec/persontasks.nsf/agtUrlRef?openagent&unid="+unid+"&user="+itcode;
				$.hori.loadPage(loadurl);
			}
			]]>
		</script>
		<script type="text/javascript">
		<![CDATA[
			var myScroll,pullUpEl, pullUpOffset,generatedCount = 0;
			var start=1;
			function pullUpAction () {
				setTimeout(function () {
					$.hori.showLoading();
					var itcode=localStorage.getItem("itcode");
					start=start+20;
					var url = $.hori.getconfig().appServerHost+"viewhome/oa/todossub/docapp/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+start+"&count=20";
					$.ajax({
						type: "get", url: url,
						success: function(response){
							//alert(response);return;
							$("#moredata").remove();
							//$("#more").remove();
							$("ul").append(response);
							$("ul").listview('refresh');
							$.hori.hideLoading();
						},
						error:function(response){
							//$.mobile.hidePageLoadingMsg();
							$.hori.hideLoading();
							alert("错误:"+response.responseText);
						}
					});
					myScroll.refresh();
				}, 1000);
			}
			function loaded() {
				pullUpEl = document.getElementById('pullUp');	
				pullUpOffset = pullUpEl.offsetHeight;
				
			myScroll = new iScroll('wrapper', {
				useTransition: true,
				topOffset: pullUpOffset,
				onRefresh: function () {
				if (pullUpEl.className.match('loading')) {
						pullUpEl.className = '';
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
					}
				},
			onScrollMove: function () {
				if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
					pullUpEl.className = 'flip';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
					this.maxScrollY = this.maxScrollY;
				} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
					this.maxScrollY = pullUpOffset;
				}
			},
			onScrollEnd: function () {
				if (pullUpEl.className.match('flip')) {
					pullUpEl.className = 'loading';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
					pullUpAction();
				}
			}
		});
			setTimeout(function () { document.getElementById('wrapper').style.left = '0'; }, 800);
		}
			document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
			document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 200); }, false);
	]]>
	</script>
	</head>
	<body>
		<div data-role="page" data-iscroll="enable" class="type-home">
			<div data-role="content" align="center" id="wrapper">
				<div id="scroller">
					<div id="pullDown">
					</div>
					<ul data-role="listview" data-inset="true">
						<xsl:apply-templates select="//div[@id='viewValue']//table/tbody/tr[position()&gt;1]" />
						<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])=0">
							<li><a>无内容</a></li>
						</xsl:if>
						<xsl:if test="count(//div[@id='viewValue']//table/tbody/tr[position()&gt;1])!=0">
							<li id="moredata"><div id="pullUp" align="center">
								<span class="pullUpLabel">上划加载更多...</span>
							</div></li>
						</xsl:if>
					</ul>
				</div>
			</div>
		</div>
	</body>
	</html>
	</xsl:template>
	<xsl:template match="tr">
		<xsl:variable name="unid"><xsl:value-of select="td[2]/input/@value"/></xsl:variable>
		<xsl:variable name="type"><xsl:value-of select="td[4]/."/></xsl:variable>
		<xsl:variable name="state"><xsl:value-of select="td[6]/."/></xsl:variable>
		<xsl:if test="$state!='正在起草'">
			<li href="#" data-icon="false">
				<a href="javascript:void(0)" onclick="loadPageForm(this);" data-unid="{$unid}"	data-type="{$type}">
					<h3><xsl:value-of select="td[3]/."/><xsl:value-of select="td[2]/@value"/></h3>
					<p>
						类型d:<font color="#0080FF"><xsl:value-of select="td[4]/."/></font>
						来源:<font color="#0080FF"><xsl:value-of select="td[5]/."/></font>
						状态d:<font color="#0080FF"><xsl:value-of select="td[6]/."/></font>
						时间:<font color="#0080FF"><xsl:value-of select="td[7]/."/></font>
					</p>
				</a>
			</li>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
