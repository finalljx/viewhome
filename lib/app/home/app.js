$(document).ready(function() {
	// $.hori.showLoading();
	$.hori.setHeaderTitle("首页");
	//alert(window.screen.width);
	//alert(document.documentElement.clientWidth);
	var itcode = localStorage.getItem("itcode");
	var officialRole = localStorage.getItem("officialRole");
	$("#homeModules").hide();
	if(officialRole=="yes"){
		// 判断用户权限
		itcodeAlow();
	}else if(officialRole=="no"){
		hidedoc();
		// 初始化页面内容
		initPage();
	}
});

function hidedoc(){
	var array4 = [ {
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
					"id" : 11,
					"name" : "安全生产",
					"img" : "../assets/home/aqsc.png",
					"target" : "loadAqsczbb()"
				}, {
					"id" : 6,
					"name" : "经营数据",
					"img" : "../assets/home/jysj.png",
					"target" : "loadBI()"
				} ];
				for (var i = 0; i < array4.length; i++) {
					disableModules.push(array4[i]);
				}
}
// 初始化BI权限
function initBIPermission() {
	var itcode = localStorage.getItem("itcode");
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
				var array3 = [ {
					"id" : 6,
					"name" : "经营数据",
					"img" : "../assets/home/jysj.png",
					"target" : "loadBI()"
				} ];
				for (var i = 0; i < array3.length; i++) {
					disableModules.push(array3[i]);
				}
			} else {
				localStorage.setItem("bi_modules", res);
			}
			// 初始化页面内容
			initPage();
			$.hori.hideLoading();
		},
		"error" : function(res) {
			$.hori.hideLoading();
		}
	});
}

var disableModules = [];// 定义全局变量数组存放不能显示项
// 判断用户权限
function itcodeAlow() {
	var itcode = localStorage.getItem("itcode");
	var url = $.hori.getconfig().appServerHost
			+ "view/user/permission?it_code=" + itcode;
	$.hori.ajax({
		"type" : "get",
		"url" : url,
		"success" : function(res) {
			var json = JSON.parse(res);
			if (json.length > 0) { // 有列表数据返回
				if (json[0].DOC_MOBILE == "Y") {
					// 创建用户信息
					createUser();
				} else if (json[0].DOC_MOBILE == "N") {
					var array1 = [ {
						"id" : 4,
						"name" : "公文待办",
						"img" : "../assets/home/gwdb.png",
						"target" : "loadTaskList()"
					}, {
						"id" : 5,
						"name" : "公文查阅",
						"img" : "../assets/home/gwcy.png",
						"target" : "loadqueryList()"
					} ];
					for (var i = 0; i < array1.length; i++) {
						disableModules.push(array1[i]);
					}
				}
				if (json[0].OA_MOBILE == "N") {
					var array2 = [ {
						"id" : 11,
						"name" : "安全生产",
						"img" : "../assets/home/aqsc.png",
						"target" : "loadAqsczbb()"
					} ];
					for (var i = 0; i < array2.length; i++) {
						disableModules.push(array2[i]);
					}

				}
				if (json[0].BI_MOBILE == "Y") {
					// 初始化BI权限
					initBIPermission();
				} else if (json[0].BI_MOBILE == "N") {
					var array3 = [ {
						"id" : 6,
						"name" : "经营数据",
						"img" : "../assets/home/jysj.png",
						"target" : "loadBI()"
					} ];
					for (var i = 0; i < array3.length; i++) {
						disableModules.push(array3[i]);
					}
					// 初始化页面内容
					initPage();
				}
			} else { // 无返回数据，隐藏所有办公相关
				hidedoc();
				// 初始化页面内容
				initPage();
			}
		},
		"error" : function(res) {
			$.hori.hideLoading();
		}
	});
}

// 请示待办
function loadTaskList() {
	var cName=localStorage.getItem("itcodetasklist");
	if(cName==null||cName=="1"){
		getCNName();
	}else{
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ "viewhome/html/task.html");}
}
// 请示查阅
function loadqueryList() {
	localStorage.setItem("click", "1");
	localStorage.setItem("addmore", "no");
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/queryList.html');
}
// 加载新闻列表
function loadNewsList(typeName) {
	localStorage.setItem("moreCurrentName", typeName);
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/news/newsList.html');
}
// BI
function loadBI() {
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl + 'viewhome/html/bi.html');
}
var cookie_userstore;
function getCNName(){
	var docServer=$.hori.getconfig().docServer;
	$.hori
			.ajax({
				"type" : "get",
				"url" : $.hori.getconfig().appServerHost
						+ "/view/oa/currentuser/"+docServer+"/genertec/persontasks.nsf/frmPage?openform",
				"success" : function(res) {
					
					localStorage.setItem("Chinesename", res);
					currentUser = "CN=" + res + "/O=genertec";
					localStorage.setItem("itcodetasklist", currentUser);
					$.hori.loadPage($.hori.getconfig().serverBaseUrl
							+ "viewhome/html/task.html");
				},
				"error" : function(res) {
					alert("获取当前登陆人失败");
				}
			});
}
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
	var docServer=$.hori.getconfig().docServer;
	$.hori
			.ajax({
				"type" : "get",
				"url" : $.hori.getconfig().appServerHost
						+ "/view/oa/currentuser/"+docServer+"/genertec/persontasks.nsf/frmPage?openform",
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
		"target" : "loadDzqkList()"
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
	},
	{
		"id" : 12,
		"name" : "关于",
		"img" : "../assets/home/ic_launcher.png",
		"target" : "loadXgbb()"
	}];
	var flag = true;
	var target = [];
	for (var i = 0; i < jsonData.length; i++) {
		for (var j = 0; j < disableModules.length; j++) {
			if (jsonData[i].id == disableModules[j].id) { //隐藏无权限模块
				flag = false;
				break;
			}
		}
		if (flag == true) {
			target.push(jsonData[i]);
		}
		flag = true;
	}
	var data = new Object();
	data.list = target;
	render(data);
}

// 安全生产值班表列表
function loadAqsczbb() {
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/zcfgz.html');
}
//相关版本
function loadXgbb() {
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/xgbb.html');
}
// 电子期刊列表
function loadDzqkList() {
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/periodical.html');
}
// 聘免公告
function loadPmgg(typeName) {
	typeName = "GT_HomePage_SiteArea_pmgg";
	localStorage.setItem("moreCurrentName", typeName);
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/news/newsList.html');
}

// 科技动态
function loadKjdt(typeName) {
	typeName = "GT_HomePage_SiteArea_kjdt";
	localStorage.setItem("moreCurrentName", typeName);
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/news/newsList.html');
}

// 加载图片新闻子页面
function loadJtxw() {
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/jtxwz.html');
}
// 加载政策法规资讯子页面
function loadZcfg(typeName) {
	typeName = "GT_HomePage_SiteArea_zcfg";
	localStorage.setItem("moreCurrentName", typeName);
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ 'viewhome/html/news/newsList.html');

}
function render(data) {
	var viewModel = ko.mapping.fromJS(data);
	$("#homeModules").show();
	ko.applyBindings(viewModel, document.getElementById("divOne"));
}
