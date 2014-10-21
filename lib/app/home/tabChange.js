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
	switch(type){
	case 'tpxw':
		localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_"+type);
		$.getScript("../lib/app/home/tpxwList.js");
		$("#middleContent").load("news/tpxwList.html", function(a, b, c) {
			$("#querydataList").listview();   
		});
		setTimeout(function() {
			$.mobile.loading("hide")
		}, 1000);
		break;
	case 'jttz':
		localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_"+type);
		$.getScript("../lib/app/home/newsList.js");
		$("#middleContent").load("news/newsList.html", function(a, b, c) {
			$("#querydataList").listview();   
		});
		setTimeout(function() {
			$.mobile.loading("hide")
		}, 1000);
	    break;
	case 'jtxw':
		localStorage.setItem("moreCurrentName","GT_HomePage_SiteArea_"+type);
		$.getScript("../lib/app/home/newsList.js");
		$("#middleContent").load("news/newsList.html", function(a, b, c) {
			$("#querydataList").listview();   
		});
		setTimeout(function() {
			$.mobile.loading("hide")
		}, 1000);
		break;
	case 'zgsxw':
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