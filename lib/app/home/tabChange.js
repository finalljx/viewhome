$(document).ready(function() {
		jQuery.jqtab = function(tabtit, tab_conbox, shijian) {
			$(tab_conbox).find("li").hide();
			$(tabtit).find("li:first").addClass("thistab").show();
			$(tab_conbox).find("li:first").show();

			$(tabtit).find("li").bind(shijian, function() {
				$(this).addClass("thistab").siblings("li").removeClass("thistab");
				var activeindex = $(tabtit).find("li").index(this);
				$(tab_conbox).children().eq(activeindex).show().siblings().hide();
				return false;
			});

		};
		/*调用方法如下：*/
		$.jqtab("#tabs", "#tab_conbox", "click");

	});
function changelb(type){
	$.hori.showLoading();
	switch(type){
	case 'tpxw': //图片新闻
		$("#rightContent").empty();
		$("#middleContent").empty();
		localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_"+type);
		$.getScript("../lib/app/home/tpxwList.js");
		$("#middleContent").load("news/tpxwList.html", function(a, b, c) {
			$("#querydataList").listview();   
		});
		setTimeout(function() {
			$.mobile.loading("hide")
		}, 1000);
		break;
	case 'jttz': //集团通知
	case 'jtxw': //集团新闻
	case 'zgsxw': //下属单位新闻
	case 'pmgg': //聘免公告
	case 'kjdt': //科技动态
	case 'aqsc': //安全环保
	case 'zcfg': //政策法规
		$("#rightContent").empty();
		$("#middleContent").empty();
		localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_"+type);
		$.getScript("../lib/app/home/newsList.js");
		$("#middleContent").load("news/newsList.html", function(a, b, c) {
			$("#querydataList").listview();   
		});
		setTimeout(function() {
			$.mobile.loading("hide")
		}, 1000);
	    break;
	}
	
}