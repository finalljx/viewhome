$(document).ready(function() {
	// 加载新闻详情
	getWcmNewsData();
});
// 加载新闻详情
function getWcmNewsData() {
	try {
		$.hori.showLoading();
		var currentContentName = localStorage.getItem("currentContentName");
		var currentGT_HomePage = localStorage.getItem("moreCurrentName");
		var url = $.hori.getconfig().appServerHost
				+ "view/news/newsDetail/accsyWcmNews/services/WcmNewsData";
		// var temp = "$lt;?xml version='1.0'
		// encoding='utf-8'?$gt;$lt;root$gt;$lt;newslist$gt;$lt;type$gt;GT_HomePage_SiteArea_jttz$lt;/type$gt;$lt;userid$gt;fangyonghong$lt;/userid$gt;$lt;pageSize$gt;10$lt;/pageSize$gt;$lt;parent$gt;1$lt;/parent$gt;$lt;pageNow$gt;1$lt;/pageNow$gt;$lt;/newslist$gt;$lt;/root$gt;";
		var temp = "$lt;root$gt;$lt;newslist$gt;$lt;type$gt;"
				+ currentGT_HomePage + "$lt;/type$gt;$lt;contentName$gt;"
				+ currentContentName
				+ "$lt;/contentName$gt;$lt;/newslist$gt;$lt;/root$gt;";
		var soap = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
		soap += '<soapenv:Header/><soapenv:Body>';
		soap += '<web:getWcmNewsData>';
		soap += '<web:in0>' + temp + '</web:in0>';
		soap += '</web:getWcmNewsData>';
		soap += ' </soapenv:Body></soapenv:Envelope>';
		var data = "data-xml=" + soap;

	$.hori.ajax({
		"type" : "post",
		"url" : url,
		"data" : data,
		"headers" : {
			"Authorization" : "Basic d3BzYWRtaW46R1RBZG1pbg=="
		},
		"success" : function(res) {
			var widthImg=document.documentElement.clientWidth*0.3;
			var url=$.hori.getconfig().appServerHost2+"view/tpxw/file";
			var key=$.hori.getconfig().appKey;
			res=res.replace(/http:\/\/webseal.genertec.com.cn/g,url).replace(/&amp;amp;/g,"&");
			var r = /<.*table/g;
			console.log('1: ' + res);
			if (!(r.test(res))) {
				res = res.replace(/CACHEID=.*?\\/g,
						'data-result=file&data-thumb=650&data-application='
								+ key + '\\\" width=\\\"'
								+ widthImg + '\\');
				res=res.replace(/style=.*?\\"/g,"");
			} else {
				res = res.replace(/CACHEID=.*?\\/g,
						'data-result=file&data-thumb=650&data-application='
								+ key + '\\\" width=\\\"'
								+ '40px' + '\\');
			}
			var data = JSON.parse(res);
			$("#rightContent").load("news/newsDetail.html", function(a, b, c) {
				document.getElementById('rightContent').style.dispaly = 'dispay';
				$.hori.hideLoading();
				if (data.attachmentSource!=undefined) {
					document.getElementById("fujian").style.display = "inline";
					var attachmentNameLength = data.attachment.length;
					var attachmentSourceLength = data.attachmentSource.length;
					if(data.attachment.charAt(attachmentNameLength - 1) === "|"){
						data.attachment = data.attachment.substring(0,attachmentNameLength -1);
					}
					if(data.attachmentSource.charAt(attachmentSourceLength - 1) === "|"){
						data.attachmentSource = data.attachmentSource.substring(0,attachmentSourceLength - 1);
					}
					var dataArrayName = data.attachment.split("|");
					var dataArraySource = data.attachmentSource.split("|");
					for(var i=0; i<dataArraySource.length;i++){
						dataArraySource[i]=dataArraySource[i].replace("http://10.1.32.61:10039/","");
					} 
					var list = new Array();
					for (var i = 0; i < dataArrayName.length; i++) {
						var lastIndex = dataArrayName[i]
						.lastIndexOf(".");
						var cut = dataArrayName[i]
								.substring(lastIndex);// dataArrayName[i].split(".")[2];
						if (cut != ".doc"
								& cut != ".xls"
								& cut != ".ppt"
								& cut != ".pdf"
								& cut != ".txt"
								& cut != ".docx") {
							dataArraySource[i] = "noSupport";
						}
						var item = new Object();
						item.attachment = dataArrayName[i];
						item.attachmentSource = dataArraySource[i];
						list.push(item);
					}
					data.attachmentList = list;
				} else {
					document.getElementById("fujian").style.display = "none";
				}
				renderDetail(data);
			});
						$.hori.hideLoading();
					},
					"error" : function(res) {
						alert("error:" + res);
						$.hori.hideLoading();
					}

				});
	} catch (e) {
		alert(e.message);
	}
	// 重置ID
}

function viewfile(item) {
	if (item.attachmentSource() == "noSupport") {
		alert("系统不能打开此文件！");
		return;
	}
	var cookie_userstore = localStorage.getItem("cookie_userstore");
	var url = item.attachmentSource()
			+ "&data-convert=office&data-basic-auth-u=wpsadmin&data-basic-auth-p=GTAdmin";
	url = url.replace(/\&amp;/g, "&");
	console.log(item.attachmentSource());
	localStorage.setItem("attachmentUrl", url);

	var type = "android";
	if (window.navigator.userAgent.match(/iPad/i)
			|| window.navigator.userAgent.match(/iPhone/i)
			|| window.navigator.userAgent.match(/iPod/i)) {
		type = "iphone";
	}
	if (type == "iphone") {
		$.hori.loadPage($.hori.getconfig().serverBaseUrl
				+ "viewhome/html/attachmentShowForm4News.html",
				"viewhome/xml/AttachView4I.xml");
	} else if (type == "android") {
		$.hori.loadPage($.hori.getconfig().serverBaseUrl
				+ "viewhome/html/attachmentShowForm4News.html",
				"viewhome/xml/AttachView.xml");
	}
}
function renderDetail(data) {
	var viewModelDetail = ko.mapping.fromJS(data);
	ko.applyBindings(viewModelDetail, document.getElementById("newsDetail"));
}