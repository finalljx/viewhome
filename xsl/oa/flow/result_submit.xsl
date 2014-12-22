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
						<h1>操作提示</h1>
					</div>
					<div data-role="content" align="center">
						<ul data-role="listview" data-inset="true">
							<li data-role="list-divider"></li>
							<li>
								<div style="100%;text-align:center;" align="center">
									<div align="center">
										<xsl:if test="contains(//h2/., 'Form processed')">表单已处理</xsl:if>
										<xsl:if test="contains(//td[@class='msgok_msg']/.,'/')">
											<xsl:value-of select="//td[@class='msgok_msg']/."/>
										</xsl:if>
										<xsl:if test="not(contains(//td[@class='msgok_msg']/.,'/'))">
											<xsl:value-of select="//td[@class='msgok_msg']/."/>
										</xsl:if>
									</div>
								</div>
								<input id="nextItcode" name="nextItcode" type="hidden" value="{//input[@name='users']/@value}"/>
								<input id="smsCont" name="smsCont" type="hidden" value="{//input[@name='cont']/@value}"/>
							</li>
							<li data-role="list-divider"></li>
						</ul>
						<div class="ui-grid-a">
							<div class="ui-block-a"></div>
							<div class="ui-block-b">
								<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">返回</a>
							</div>
							<script>
								<![CDATA[
									//base64
									var Base64 = {
									_keyStr : "keQrdSlyaZJ7c4FXBWGLuhbRtpAi8C_MPn69IVO0Hm2TK5qwxszgUjDYf13voEN-",
									// public method for encoding
									encode : function (input, _keyStr) {
									var output = "";
									var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
									var i = 0;
									input = Base64._utf8_encode(input);
									while (i < input.length) {
									chr1 = input.charCodeAt(i++);
									chr2 = input.charCodeAt(i++);
									chr3 = input.charCodeAt(i++);
									enc1 = chr1 >> 2;
									enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
									enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
									enc4 = chr3 & 63;
									if (isNaN(chr2)) {
									enc3 = enc4 = 64;
									} else if (isNaN(chr3)) {
									enc4 = 64;
									}
									output = output +
									this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
									this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);
									}
									return output;
									},
									decode : function (input) {
									var output = "";
									var chr1, chr2, chr3;
									var enc1, enc2, enc3, enc4;
									var i = 0;
									input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
									while (i < input.length) {
									enc1 = this._keyStr.indexOf(input.charAt(i++));
									enc2 = this._keyStr.indexOf(input.charAt(i++));
									enc3 = this._keyStr.indexOf(input.charAt(i++));
									enc4 = this._keyStr.indexOf(input.charAt(i++));
									chr1 = (enc1 << 2) | (enc2 >> 4);
									chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
									chr3 = ((enc3 & 3) << 6) | enc4;
									output = output + String.fromCharCode(chr1);
									if (enc3 != 64) {
									output = output + String.fromCharCode(chr2);
									}
									if (enc4 != 64) {
									output = output + String.fromCharCode(chr3);
									}
									}
									output = Base64._utf8_decode(output);
									return output;
									},
									_utf8_encode : function (string) {
									string = string.replace(/\r\n/g,"\n");
									var utftext = "";
									for (var n = 0; n < string.length; n++) {
									var c = string.charCodeAt(n);
									if (c < 128) {
									utftext += String.fromCharCode(c);
									}
									else if((c > 127) && (c < 2048)) {
									utftext += String.fromCharCode((c >> 6) | 192);
									utftext += String.fromCharCode((c & 63) | 128);
									}
									else {
									utftext += String.fromCharCode((c >> 12) | 224);
									utftext += String.fromCharCode(((c >> 6) & 63) | 128);
									utftext += String.fromCharCode((c & 63) | 128);
									}
									}
									return utftext;
									},
									_utf8_decode : function (utftext) {
									var string = "";
									var i = 0;
									var c = c1 = c2 = 0;
									while ( i < utftext.length ) {
									c = utftext.charCodeAt(i);
									if (c < 128) {
									string += String.fromCharCode(c);
									i++;
									}
									else if((c > 191) && (c < 224)) {
									c2 = utftext.charCodeAt(i+1);
									string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
									i += 2;
									}
									else {
									c2 = utftext.charCodeAt(i+1);
									c3 = utftext.charCodeAt(i+2);
									string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
									i += 3;
									}
									}
										return string;
									}
									}
									var taskTitle = localStorage.getItem("taskTitle");
									var users =$("#nextItcode").val();
									$(document).ready(function() {
										sendSms();
										//pushMsg(users, taskTitle)
									});
									//发送短信
									function sendSms() {
										var sms = localStorage.getItem("sms");
										var cont =$("#smsCont").val();
										//alert(cont);
										cont = Base64.encode(cont);
										var url = $.hori.getconfig().appServerHost+"view/sendSmsTask/sendNews/sms/user?sms="+sms+"&users="+users+"&cont="+cont;
										//alert(url);
										$.hori.ajax({
											"type" : "get",
											"url" : url,
											"success" : function(res) {
												//alert("==="+res);
												//var json = JSON.parse(res);
											},
											"error" : function(res) {
												alert("发送短信失败" + res);
											}
										})
									}
									//消息推送
									function pushMsg(userId, msg) {
										if (userId == undefined || userId == '') {
											alert("没有有效的用户id");
											return;
										}
										if (msg == undefined || msg == '') {
											alert("没有有效的消息内容");
											return;
										}
										var url = $.hori.getconfig().appServerHost
												+ "view?data-action=push&data-channel=mobileapp&data-userid="
												+ userId ;
										//alert(url);
										$.hori.ajax({
											"type" : "post",
											"url" : url,
											"data" : "data-message=" + escape(msg),
											"success" : function(res) {
												//alert("++++:"+res);
												var json = JSON.parse(res);

											},
											"error" : function(res) {
												alert("推送错误" + res);
											}
										})
									}
									function cancelSubmit(){
										//document.location.reload();
										$.hori.backPage(1);
									}
									
								]]>
							</script>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
