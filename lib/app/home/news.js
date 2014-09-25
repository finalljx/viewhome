function getNewsList(itcode, type,pageSize,pageNow) {
	var url = $.hori.getconfig().appServerHost
			+ "view/news/newsList/accsyWcmNews/services/WcmNewsList";
	var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;newslist$gt;$lt;type$gt;"+type+"$lt;/type$gt;$lt;userid$gt;"
			+ itcode
			+ "$lt;/userid$gt;$lt;pageSize$gt;"+pageSize+"$lt;/pageSize$gt;$lt;parent$gt;"+pageNow+"$lt;/parent$gt;$lt;pageNow$gt;1$lt;/pageNow$gt;$lt;/newslist$gt;$lt;/root$gt;";
	var soap = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
	soap += '<soapenv:Header/><soapenv:Body>';
	soap += '<web:getWcmNewsList>';
	soap += '<web:in0>' + temp + '</web:in0>';
	soap += '</web:getWcmNewsList>';
	soap += ' </soapenv:Body></soapenv:Envelope>';
	var data = "data-xml=" + soap;

	$.hori.ajax({
		"type" : "post",
		"url" : url,
		"data" : data,
		// "headers" : {
		// "Authorization" : "Basic d3BzYWRtaW46R1RBZG1pbg=="
		// },
		"success" : function(res) {
			var list = JSON.parse(res);
			for ( var item in list) {
				var targetURL = "http://10.1.32.61/appdata/WcmNewsImage/"
						+ list[item].contentName + "/" + list[item].newName;
				list[item].imgSrc = targetURL;
			}
			var data = new Object();
			data.list = list;
			render(data,type);
		},
		"error" : function(res) {
			alert("error:" + res);
			$.hori.hideLoading();
		}
	});
}

function render(jsonData,type) {
	var viewModel = ko.mapping.fromJS(jsonData);
	switch (type){
	case "GT_HomePage_SiteArea_tpxw":
		ko.applyBindings(viewModel,document.getElementById("tpxwSwiper"));
		initSwiper();
		break;
	case "GT_HomePage_SiteArea_jttz":
		ko.applyBindings(viewModel,document.getElementById("jttzList"));
		$('#jttzList').prepend('<li data-role="list-divider" role="heading" class="ui-li ui-li-divider ui-bar-b ui-first-child"><a class="ui-link">通知公告</a> <a href="#" style="float: right" class="ui-link" onclick="loadNewsList(\'' + type + '\');">more</a></li>');
		break;
	case "GT_HomePage_SiteArea_jtxw":
		ko.applyBindings(viewModel,document.getElementById("jtxwList"));
		$('#jtxwList').prepend('<li data-role="list-divider" role="heading" class="ui-li ui-li-divider ui-bar-b ui-first-child"><a class="ui-link">集团新闻</a> <a href="#" style="float: right" class="ui-link" onclick="loadNewsList(\'' + type + '\');">more</a></li>');
		break;
	case "GT_HomePage_SiteArea_zgsxw":
		ko.applyBindings(viewModel,document.getElementById("cydwxwList"));
		$('#cydwxwList').prepend('<li data-role="list-divider" role="heading" class="ui-li ui-li-divider ui-bar-b ui-first-child"><a class="ui-link">成员单位新闻</a> <a href="#" style="float: right" class="ui-link" onclick="loadNewsList(\'' + type + '\');">more</a></li>');
		break;
	}
}
//图片新闻
function showDetail(item){
	var contentName = item.contentName();
	localStorage.setItem("currentContentName",contentName);
	localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_tpxw");
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/news/newsDetail.html');
}
//通知公告
function showDetailJttz(item){
	var contentName = item.contentName();
	localStorage.setItem("currentContentName",contentName);
	localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_jttz");
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/news/newsDetail.html');
}
//集团新闻
function showDetailJtxw(item){
	var contentName = item.contentName();
	localStorage.setItem("currentContentName",contentName);
	localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_jtxw");
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/news/newsDetail.html');
}
//成员单位新闻
function showDetailZgsxw(item){
	var contentName = item.contentName();
	localStorage.setItem("currentContentName",contentName);
	localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_zgsxw");
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/news/newsDetail.html');
}
//初始化swiper
function initSwiper() {
	//初始化宽高
	var width = $(window).width();
	var height = width / 2 ;
	$(".swiper-container").width(width);
	$(".swiper-container").height(height);
	$(".swiper-container .more").width(50);
	$(".swiper-slide .title").width(width - 70);
	// 生成swiper
	var mySwiper = new Swiper('.swiper-container', {
		pagination : '.pagination',
		paginationClickable : true
	})
}
