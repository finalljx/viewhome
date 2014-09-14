function getTpxwNewsList(itcode, type) {
	var url = $.hori.getconfig().appServerHost
			+ "view/news/tpxwList/accsyWcmNews/services/WcmNewsList";
	// var temp = "$lt;?xml version='1.0'
	// encoding='utf-8'?$gt;$lt;root$gt;$lt;newslist$gt;$lt;type$gt;GT_HomePage_SiteArea_jttz$lt;/type$gt;$lt;userid$gt;fangyonghong$lt;/userid$gt;$lt;pageSize$gt;10$lt;/pageSize$gt;$lt;parent$gt;1$lt;/parent$gt;$lt;pageNow$gt;1$lt;/pageNow$gt;$lt;/newslist$gt;$lt;/root$gt;";
	var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;newslist$gt;$lt;type$gt;GT_HomePage_SiteArea_tpxw$lt;/type$gt;$lt;userid$gt;"
			+ itcode
			+ "$lt;/userid$gt;$lt;pageSize$gt;6$lt;/pageSize$gt;$lt;parent$gt;1$lt;/parent$gt;$lt;pageNow$gt;1$lt;/pageNow$gt;$lt;/newslist$gt;$lt;/root$gt;";
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
			render(data);
		},
		"error" : function(res) {
			alert("error:" + res);
			$.hori.hideLoading();
		}
	});
}

function render(jsonData) {
	var viewModel = ko.mapping.fromJS(jsonData);
	ko.applyBindings(viewModel);
	//初始化swiper
	initSwiper();
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
