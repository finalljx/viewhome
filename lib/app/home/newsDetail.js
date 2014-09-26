$(document).ready(function() {
	// 加载新闻详情
	getWcmNewsData();
});
// 加载新闻详情
function getWcmNewsData() {
	var currentContentName = localStorage.getItem("currentContentName");
	var currentGT_HomePage = localStorage.getItem("moreCurrentName");
	var url = $.hori.getconfig().appServerHost + "view/news/newsDetail/accsyWcmNews/services/WcmNewsData";
	// var temp = "$lt;?xml version='1.0'
	// encoding='utf-8'?$gt;$lt;root$gt;$lt;newslist$gt;$lt;type$gt;GT_HomePage_SiteArea_jttz$lt;/type$gt;$lt;userid$gt;fangyonghong$lt;/userid$gt;$lt;pageSize$gt;10$lt;/pageSize$gt;$lt;parent$gt;1$lt;/parent$gt;$lt;pageNow$gt;1$lt;/pageNow$gt;$lt;/newslist$gt;$lt;/root$gt;";
	var temp = "$lt;root$gt;$lt;newslist$gt;$lt;type$gt;" + currentGT_HomePage + "$lt;/type$gt;$lt;contentName$gt;"
			+ currentContentName + "$lt;/contentName$gt;$lt;/newslist$gt;$lt;/root$gt;";
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
			/*
			 * var urlb=/img src=\\\"/; var urla=/\\\" ALT/; alert(res);
			 * urlb=res.replace(urlb,'img src=\\"/view/oa/file'); var
			 * url=urlb.replace(urla,'&data-result=file\\" ALT'); alert(url);
			 */
			var reg = new RegExp(/(<img src=\\\")(\S+)(\\".+\/\>)/g);
			var newstr = res.replace(reg, "$1http://portal1.genertec.com.cn$2\ $3");
			var data = JSON.parse(res);
			$("#rightContent").load("news/newsDetail.html", function(a, b, c) {
				renderDetail(data);
			});
		},
		"error" : function(res) {
			alert("error:" + res);
			$.hori.hideLoading();
		}
	});
	// 重置ID
}

function renderDetail(data) {
	var viewModelDetail = ko.mapping.fromJS(data);
	ko.applyBindings(viewModelDetail, document.getElementById("newsDetail"));
}