$(document).ready(function() {
	//初始化页面结构
	initPage();
	//创建用户信息
	createUser();
	try {
		var hori = $.hori;
		hori.hideBackBtn();
		/* 注册注销事件 */
		hori.registerEvent("case", "navButtonTouchUp", function() {
			hori.backPage(1);
		});
		// ios 隐藏邮件图标

		if (hori.getMobileType() == "apple") {
			$("#divMail").hide();
		}
		var itcode = localStorage.getItem("itcode");
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

//修改div高度，与屏幕适应
var sm;//中间属性
var sr;//右侧属性
var sul;

function initPage() {
	var h = document.documentElement.clientHeight;//可见区域高度
	sm = document.getElementById('middleContent');
	sm.style.height = h + "px";
	sr = document.getElementById('rightContent');
	sr.style.height = h + "px";
	sul = document.getElementById('ul');
	sul.style.height = h + "px";
}
// 中间页面
function loadMiddleContent() {
	localStorage.setItem("click", "news");
	$.getScript("../lib/app/home/tpxwList.js");
	$("#middleContent").load("news/tpxwList.html", function(a, b, c) {
		$("#querydataList").listview();
	});
	setTimeout(function() {
		$.mobile.loading("hide")
	}, 1000);
}
// 页面右侧
function loadRightContent() {
	localStorage.setItem("moreCurrentName", "GT_HomePage_SiteArea_tpxw");
	$.getScript("../lib/app/home/newsDetail.js");
	setTimeout(function() {
		$.mobile.loading("hide");
	}, 1000);
}
// 加载BI右侧页面
function loadRightBIContent(itemBi) {
	var biId = itemBi.reportId();

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

	setTimeout(function() {
		$.mobile.loading("hide")
	}, 1000);
}
// 加载BI 中间页面
function loadMiddleBIContent() {
	$.getScript("../lib/app/home/loadBI.js");
	setTimeout(function() {
		$.mobile.loading("hide")
	}, 1000);
}
// 加载安全生产
function loadAqscList() {
	// alert(2);
	document.getElementById("tabbox").style.display = "none";
	document.getElementById("middleContent").style.width = '90%';
	$("#middleContent").load("aqscList.html", function(a, b, c) {
		// alert(1);
		// $("#querydataList").listview();
	});
	setTimeout(function() {
		$.mobile.loading("hide")
	}, 1000);
}
//加载电子期刊
function loadDzqkList() {
	document.getElementById("tabbox").style.display = "none";
	document.getElementById("middleContent").style.width = '90%';
	$("#middleContent").load("dzqkList.html", function(a, b, c) {
	});
	setTimeout(function() {
		$.mobile.loading("hide")
	}, 1000);
}

// 加载请示查阅
function loadqueryList() {
	localStorage.setItem("click", "querytask");
	var click4 = localStorage.getItem("click4");
	if(click4=="2"){
		localStorage.setItem("click4", "2");
	}else{
		localStorage.setItem("click4", "1");
	}
	document.getElementById("tabbox").style.display = 'none';// 更改ipad页面中tab
																// 是否显示。
	$("#middleContent").load("queryList.html", function(a, b, c) {

		document.getElementById("middleContent").style.width = '90%';
		document.getElementById('rightContent').style.width = '0%';
	});

}
// 加载待办列表
function loadTask() {
	document.getElementById("tabbox").style.display = 'none';// 更改ipad页面中tab
																// 是否显示。
	localStorage.setItem("click", "task");
	// $.getScript("../lib/app/task/app.js");
	$("#middleContent").load("task.html", function(a, b, c) {
		document.getElementById("middleContent").style.width = '90%';
		document.getElementById('rightContent').style.width = '0%';
	});
}
// 获取中文名 获取待办列表时用
function createUser() {
	$.hori.ajax({
				"type" : "get",
				"url" : $.hori.getconfig().appServerHost
						+ "/view/oa/currentuser/doctest/genertec/persontasks.nsf/frmPage?openform",
				"success" : function(res) {
					// localStorage.setItem("Chinesename", res);
					currentUser = "CN=" + res + "/O=genertec";
					localStorage.setItem("Chinesename", currentUser);
				},
				"error" : function(res) {
				}
			});
}