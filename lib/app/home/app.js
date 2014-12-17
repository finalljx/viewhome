$(document).ready(function() {
	$.hori.showLoading();
	//alert(window.screen.height);
	try {
		var hori = $.hori;
		//hori.hideBackBtn();
		var officialRole = localStorage.getItem("officialRole");
		if (officialRole == "yes") {
			// 判断用户权限
			itcodeAlow();
		} else if (officialRole == "no") {
			// hidedoc();
			// 初始化页面内容
			initPage();
		}
		var clickVal = localStorage.getItem("click");
		if (clickVal == "task") {
			loadTask();
		} else if (clickVal == "news") {
			loadMiddleContent();
		} else if (clickVal == "querytask") {
			loadqueryList();
		}
	} catch (e) {
		alert(e.message);
	}
});

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
			if (undefined != json[0].DOC_MOBILE) {
				if (json[0].DOC_MOBILE == "Y") {
					document.getElementById("gwcy").style.display = "block";
					document.getElementById("gwdb").style.display = "block";
					// 创建用户信息
					createUser();
				} else {
					document.getElementById("gwcy").style.display = "none";
					document.getElementById("gwdb").style.display = "none";
				}
				if (json[0].OA_MOBILE == "Y") {
					document.getElementById("aqsc").style.display = "block";
				}else {
					document.getElementById("aqsc").style.display = "none";
				}
				if (json[0].BI_MOBILE == "Y") {
					// document.getElementById("jysj").style.display="block";
					// 初始化BI权限
					initBIPermission();
				} else {
					document.getElementById("jysj").style.display = "none";
				}
			}
		},
		"error" : function(res) {
			$.hori.hideLoading();
		}
	});
}

// 初始化BI权限
function initBIPermission() {
	var itcode = localStorage.getItem("itcode");
	var config = $.hori.getconfig();
	var serverUrl = $.hori.getconfig().appServerHost
			+ "view/bi/loadQuanxianChart/accsyBiReport/services/reqBiReportList";
	var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;userid$gt;"
			+ itcode + "$lt;/userid$gt;$lt;/reportdata$gt;$lt;/root$gt;";

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
			if (json.error) { //无报表
				document.getElementById("jysj").style.display = "none";
			} else { //有报表
				document.getElementById("jysj").style.display = "block";
				localStorage.setItem("bi_modules", res);
			}
			// 初始化页面内容
			initPage();
			//$.hori.hideLoading();
		},
		"error" : function(res) {
			$.hori.hideLoading();
		}
	});
}
// 修改div高度，与屏幕适应
var sm;// 中间属性
var sr;// 右侧属性
var sul;

function initPage() {
	var h = document.documentElement.clientHeight;// 可见区域高度
	sm = document.getElementById('middleContent');
	sm.style.height = h + "px";
	sr = document.getElementById('rightContent');
	var r=h-50;
	sr.style.height = r + "px";
	//sr.style.border='1px solid #000';
	//sr.style.border='1px solid #E5E5E5';
	sul = document.getElementById('ul');
	sul.style.height = h + "px";
}
// 中间页面
function loadMiddleContent() {
	$.hori.setHeaderTitle("新闻首页");
	$.hori.showLoading();
	document.getElementById("rightContent").style.width = '45%';
	document.getElementById('rightContent').style.display = 'inline';
	$("#rightContent").css('top', '7%');
	// 默认选中图片新闻
	$("#tabs").find("li:first").addClass("thistab").siblings("li").removeClass(
			"thistab");
	$("#rightContent").empty();
	$("#middleContent").empty();
	localStorage.setItem("click", "news");
	$.getScript("../lib/app/home/tpxwList.js");
	$("#middleContent").load("news/tpxwList.html", function(a, b, c) {
		$("#querydataList").listview();
	});
	/*
	 * $("#rightContent").load("listDetails2.html", function(a, b, c) {
	 * $("#querydataList").listview(); });
	 */
	setTimeout(function() {
		//$.mobile.loading("hide");
	}, 1000);
}
// 页面右侧
function loadRightContent() {
	
	localStorage.setItem("moreCurrentName", "GT_HomePage_SiteArea_tpxw");
	$.getScript("../lib/app/home/newsDetail.js");
	document.getElementById('rightContent').style.display = 'dispay';
	setTimeout(function() {
		$.hori.loading("hide");
		document.getElementById('rightContent').style.border='1px solid #E5E5E5';
	}, 1000);
}
// 加载BI右侧页面
function loadRightBIContent(itemBi) {
	$("#rightContent").css('top', '0%');
	var biId = itemBi.reportId();
	$.hori.showLoading();
	switch (biId) {
	case 1:
		$.getScript("../lib/app/home/bi/jyts.js");
		break;
	case 6:
		$.getScript("../lib/app/home/bi/srlrqs.js");
		break;
	case 11:
		$.getScript("../lib/app/home/bi/srwc.js");
		break;
	case 16:
		$.getScript("../lib/app/home/bi/lrwc.js");
		break;
	case 21:
		$.getScript("../lib/app/home/bi/fxzk.js");
		break;
	case 31:
		$.getScript("../lib/app/home/bi/srbk.js");
		break;
	case 36:
		$.getScript("../lib/app/home/bi/lrbk.js");
		break;
	case 66:
		$.getScript("../lib/app/home/bi/srlr.js");
		break;
	}
}
// 加载BI 中间页面
function loadMiddleBIContent() {
	$.hori.showLoading();
	$.hori.setHeaderTitle("经营数据");
	document.getElementById("tabbox").style.display = "none";
	$("#rightContent").empty();
	$("#middleContent").empty();
	$.getScript("../lib/app/home/loadBI.js");
	document.getElementById("rightContent").style.display='inline';
	setTimeout(function() {
	}, 1000);
}
// 加载安全生产
function loadAqscList() {
	document.getElementById('rightContent').style.display = 'inline';
	$.hori.showLoading();
	document.getElementById("tabbox").style.display = "none";
	document.getElementById("middleContent").style.width = '40%';
	document.getElementById("rightContent").style.width = '47%';
	$("#rightContent").empty();
	$("#middleContent").empty();
	$("#rightContent").css('top', '0');

	$(".grid_2").css("width", "8%");

	// document.getElementById("middleContent").style.height = '600px';
	$.hori.setHeaderTitle("安全生产");
	$("#middleContent").load("aqscList.html", function(a, b, c) {
	});

	$("#rightContent").load("aqscLeftPage.html", function(a, b, c) {
	});
	setTimeout(function() {
		$.hori.hideLoading();
	}, 2000);
}
// 加载电子期刊
function loadDzqkList() {
	$.hori.showLoading();
	document.getElementById("tabbox").style.display = "none";
	document.getElementById("middleContent").style.width = '90%';
	document.getElementById('rightContent').style.display = 'none';
	$("#rightContent").empty();
	$("#middleContent").empty();
	$.hori.setHeaderTitle("电子期刊");
	$("#middleContent").load("dzqkList.html", function(a, b, c) {
		
	});
}

// 加载请示查阅
function loadqueryList() {
	document.getElementById('rightContent').style.display = 'none';
	$.hori.showLoading();
	localStorage.setItem("click", "querytask");
	$("#rightContent").empty();
	$("#middleContent").empty();
	var click4 = localStorage.getItem("click4");
	if (click4 == "2") {
		localStorage.setItem("click4", "2");
	} else {
		localStorage.setItem("click4", "1");
	}
	document.getElementById("tabbox").style.display = 'none';// 更改ipad页面中tab
	// 是否显示。
	$("#middleContent").load("queryList.html", function(a, b, c) {
		document.getElementById("middleContent").style.width = '90%';
	});

}
// 加载待办列表
function loadTask() {
	document.getElementById('rightContent').style.display = 'none';
	$.hori.showLoading();
	document.getElementById("tabbox").style.display = 'none';// 更改ipad页面中tab
	// 是否显示。
	localStorage.setItem("click", "task");
	$("#rightContent").empty();
	$("#middleContent").empty();
	// $.getScript("../lib/app/task/app.js");
	$("#middleContent").load("task.html", function(a, b, c) {
		document.getElementById("middleContent").style.width = '90%';
	});
}
// 获取中文名 获取待办列表时用
function createUser() {
	if (window.navigator.userAgent.match(/iPad/i)
			|| window.navigator.userAgent.match(/iPhone/i)
			|| window.navigator.userAgent.match(/iPod/i)
			|| window.navigator.userAgent.match(/android/i)) {
		$.hori.getCookies(function(clientCookie) {
			try {
				var key = "data-userstore";
				cookie_userstore = new RegExp(encodeURIComponent(key)
						+ '=([^;]*)').exec(clientCookie);
				if (cookie_userstore) {
					localStorage.setItem("cookie_userstore",
							cookie_userstore[1]);
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
	}
	$.hori
			.ajax({
				"type" : "get",
				"url" : $.hori.getconfig().appServerHost
						+ "/view/oa/currentuser/"+$.hori.getconfig().docServer+"/genertec/persontasks.nsf/frmPage?openform",
				"success" : function(res) {
					// localStorage.setItem("Chinesename", res);
					currentUser = "CN=" + res + "/O=genertec";
					localStorage.setItem("Chinesename", currentUser);
				},
				"error" : function(res) {
				}
			});
}