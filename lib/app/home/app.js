$(document).ready(function() {
	// $.hori.showLoading();
	$.hori.setHeaderTitle("首页");
	//创建用户信息
	createUser();
	var itcode = localStorage.getItem("itcode");
	//初始化页面内容
	initPage();
	// 初始化BI权限
	initBIPermission();
});
// 初始化BI权限
function initBIPermission() {
	var config = $.hori.getconfig();
	var serverUrl = $.hori.getconfig().appServerHost
			+ "view/bi/loadQuanxianChart/accsyBiReport/services/reqBiReportList";
	var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;userid$gt;"
			+ "wpsadmin" + "$lt;/userid$gt;$lt;/reportdata$gt;$lt;/root$gt;";

	var soap = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
	soap += '<soapenv:Header/><soapenv:Body>';
	soap += '<web:getAllReportByUserId>';
	soap += '<web:in0>' + temp + '</web:in0>';
	soap += '</web:getAllReportByUserId>';
	soap += ' </soapenv:Body></soapenv:Envelope>';
	var data = "data-xml=" + soap;
	$.hori.ajax({
		"type" : "post",
		"url" : serverUrl,
		"data" : data,
		"success" : function(res) {
			var json = JSON.parse(res);
			if (json.error) {
			} else {
				localStorage.setItem("json", res);
			}
			$.hori.hideLoading();
		},
		"error" : function(res) {
			$.hori.hideLoading();
		}
	});
}

// 请示待办
function loadTaskList() {
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ "viewhome/html/task.html");
}
// 请示查阅
function loadqueryList() {
	localStorage.setItem("click", "1");
	localStorage.setItem("addmore", "no");
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/queryList.html');
}
// 加载新闻列表
function loadNewsList(typeName) {
	localStorage.setItem("moreCurrentName", typeName);
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/news/newsList.html');
}
// BI
function loadBI() {
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl + 'viewhome/html/bi.html');
}
var cookie_userstore;
function createUser() {
	$.hori.getCookies(function(clientCookie) {
		try {
			var key = "data-userstore";
			cookie_userstore = new RegExp(encodeURIComponent(key) + '=([^;]*)')
					.exec(clientCookie);
			if (cookie_userstore) {
				localStorage.setItem("cookie_userstore", cookie_userstore[1]);
				var serverDomain = new RegExp('^https?://(.*?)(?=:|/)')
						.exec($.hori.getconfig().appServerHost);
				if (serverDomain) {
					$.cookie('data-userstore', cookie_userstore[1], {
						expires : 7,
						path : '/',
						domain : serverDomain[1],
						secure : false
					});
				} else {
					alert("获取配置文件异常");
				}

			} else {
				alert("获取cookie失败");
			}
		} catch (e) {
			alert(e.message);
		}
	});

	$.hori
			.ajax({
				"type" : "get",
				"url" : $.hori.getconfig().appServerHost
						+ "/view/oa/currentuser/doctest/genertec/persontasks.nsf/frmPage?openform",
				"success" : function(res) {
					localStorage.setItem("Chinesename", res);
					currentUser = "CN=" + res + "/O=genertec";
					localStorage.setItem("itcodetasklist", currentUser);
					$.hori.hideLoading();
				},
				"error" : function(res) {
					alert("获取当前登陆人失败");
				}
			});
}
// 初始化页面内容
function initPage() {
	var jsonData = [ {
		"id" : 1,
		"name" : "集团新闻",
		"img" : "../assets/home/jtxw.png",
		"target" : "loadJtxw()"
	}, {
		"id" : 2,
		"name" : "集团通知",
		"img" : "../assets/home/jttz.png",
		"target" : "loadNewsList('GT_HomePage_SiteArea_jttz')"
	}, {
		"id" : 3,
		"name" : "成员单位新闻",
		"img" : "../assets/home/cydwxw.png",
		"target" : "loadNewsList('GT_HomePage_SiteArea_zgsxw')"
	}, {
		"id" : 4,
		"name" : "公文待办",
		"img" : "../assets/home/gwdb.png",
		"target" : "loadTaskList()"
	}, {
		"id" : 5,
		"name" : "公文查阅",
		"img" : "../assets/home/gwcy.png",
		"target" : "loadqueryList()"
	}, {
		"id" : 6,
		"name" : "经营数据",
		"img" : "../assets/home/jysj.png",
		"target" : "loadBI()"
	}, {
		"id" : 7,
		"name" : "电子期刊",
		"img" : "../assets/home/dzqk.png",
		"target" : ""
	}, {
		"id" : 8,
		"name" : "聘免公告",
		"img" : "../assets/home/pmgg.png",
		"target" : "loadPmgg()"
	}, {
		"id" : 9,
		"name" : "科技动态",
		"img" : "../assets/home/kjdt.png",
		"target" : "loadKjdt()"
	}, {
		"id" : 10,
		"name" : "政策法规资讯",
		"img" : "../assets/home/zcfg.png",
		"target" : "loadZcfg()"
	}, {
		"id" : 11,
		"name" : "安全生产",
		"img" : "../assets/home/aqsc.png",
		"target" : "loadAqsczbb()"
	} ];
	var data = new Object();
	data.list = jsonData;
	render(data);
}

// 安全生产值班表列表
function loadAqsczbb() {
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/watchlist.html');
}

// 聘免公告
function loadPmgg(typeName) {
	typeName = "GT_HomePage_SiteArea_pmgg";
	localStorage.setItem("moreCurrentName", typeName);
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/news/newsList.html');
}

// 科技动态
function loadKjdt(typeName) {
	typeName = "GT_HomePage_SiteArea_kjdt";
	localStorage.setItem("moreCurrentName", typeName);
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/news/newsList.html');
}

// 加载图片新闻子页面
function loadJtxw() {
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/jtxwz.html');
}
// 加载政策法规资讯子页面
function loadZcfg() {
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/zcfgz.html');

}
function render(data) {
	console.log(data);
	var viewModel = ko.mapping.fromJS(data);
	ko.applyBindings(viewModel, document.getElementById("divOne"));
}
