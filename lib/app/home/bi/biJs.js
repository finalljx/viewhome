var currentUser = "";
$(document).ready(function() {
	document.getElementById("middleContent").style.width = '30%';
	document.getElementById('rightContent').style.width = '60%';
	document.getElementById("tabbox").style.display='none';//更改ipad页面中tab 是否显示。

	var allData = [ {
		'reportId' : 1,
		'title' : '经营态势',
		'target' : 'bi/jyts.html',
		'img' : '../assets/home/task.png'
	}, {
		'reportId' : 6,
		'title' : '收入利润趋势',
		'target' : 'bi/srlrqs.html',
		'img' : '../assets/home/news.png'
	}, {
		'reportId' : 11,
		'title' : '收入完成',
		'target' : 'bi/srwc.html',
		'img' : '../assets/home/msg.png'
	}, {
		'reportId' : 16,
		'title' : '利润完成',
		'target' : 'bi/lrwc.html',
		'img' : '../assets/home/task.png'
	},

	{
		'reportId' : 21,
		'title' : '风险状况',
		'target' : 'bi/fxzk.html',
		'img' : '../assets/home/task.png'
	}, {
		'reportId' : 31,
		'title' : '收入板块',
		'target' : 'bi/srbk.html',
		'img' : '../assets/home/msg.png'
	}, {
		'reportId' : 36,
		'title' : '利润板块',
		'target' : 'bi/lrbk.html',
		'img' : '../assets/home/news.png'
	}, {
		'reportId' : 66,
		'title' : '收入利润',
		'target' : 'bi/srlr.html',
		'img' : '../assets/home/task.png'
	} ];
	var jsons = localStorage.getItem("json");// 接受json数据
	var json = JSON.parse(jsons);
	var target = [];
	for (var i = 0; i < json.length; i++) {
		for (var j = 0; j < allData.length; j++) {
			if (json[i].reportId == allData[j].reportId) {
				target.push(allData[j]);
				break;
			}
		}

	}
	var data = new Object();
	data.list = target;
	$("#middleContent").load("bi.html", function(a, b, c) {
		
		$.getScript("../lib/app/home/bi/jyts.js");
		renderBi(data);
		// document.all.loadBi.style.background="#ededed";
		var ul = document.getElementById("loadBi");
		var lis = ul.getElementsByTagName("li");
//		for (var i = 0; i < lis.length; i++) {
//			lis[i].style.background = "#ededed";
//		}
//		document.getElementById("1").style.backgroundColor = '#836FFF';
		

	});
	try {
		var hori = $.hori;
	} catch (e) {
		alert(e.message);
	}
});

function renderBi(data) {
	var viewModel = ko.mapping.fromJS(data);
	ko.applyBindings(viewModel, document.getElementById("loadBi"));
}