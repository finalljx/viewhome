
var pages=1;
var itcode;
$(document).ready(function() {
	itcode = localStorage.getItem("itcodetasklist");
	pullUpAction(itcode);
});
function pullUpAction(itcode){
	console.log(itcode);
	$.hori.showLoading();
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/docapp/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+pages+"&count=15";
	alert(serverUrl);
	$.hori.ajax({
		"type":"get",
		"url":serverUrl,
		"success":function(res){
			
			document.getElementById("taskList").innerHTML="";
			document.getElementById("divDataLoading").style.display='none';
			$("#taskList").html(res);
			/*loaded();
			myScroll.refresh();*/
			pages=pages+15;
			$.hori.hideLoading();
		},
		"error":function(res){
			$.hori.hideLoading();
		}
	});
}
function loaded() {
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;
	myScroll = new iScroll('wrapper', {
		useTransition : true,
		topOffset : pullUpOffset,
		onRefresh : function() {
			if (pullUpEl.className.match('正在加载中...')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
			}
		},

		onScrollMove : function() {
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = this.maxScrollY;
			} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = pullUpOffset;
			}
		},
		onScrollEnd : function() {
			if (pullUpEl.className.match('flip')) {
				pullUpEl.className = '正在加载中...';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '正在加载中...';
				pullUpAction(itcode);
			}
		}
	});
}

function loadPageForm(str){
	var template ="todoscontent";
	var unid = $(str).data("unid");
	var type = $(str).data("type");
	if(type=="会签库"){
		template="signcontent";
	}
	itcode=localStorage.getItem("Chinesename");
	alert(itcode);
	localStorage.setItem("contemplate",template);
	localStorage.setItem("unid",unid);
	//var loadurl= $.hori.getconfig().appServerHost+"view/html/appform.html";
	var loadurl= $.hori.getconfig().appServerHost+"view/oa/getunid/docapp/genertec/persontasks.nsf/agtUrlRef?openagent&unid="+unid+"&user="+itcode;
	$.hori.ajax({
			"type" : "get",
			"url" : loadurl,
			"success" : function(res) {
				console.log(res);
				var num=res.indexOf("?>");
				var docunid=res.substring(num+2);
				//alert(docunid);
				//var cookieuserstore=$.cookie('data-userstore');&data-userstore=
				
				var url= 'view/oa/todoscontent/docapp/'+docunid+'?editdocument';
				//$.cookie('data-userstore', cookieuserstore, {expires: 7, path: '/', domain: '192.168.1.110', secure: false});
				var loadurl= $.hori.getconfig().appServerHost+url;
				alert(url);
				//$.hori.loadPage(loadurl);
			},
			"error" : function(res) {
				alert(res);
			}
		});
	//$.hori.loadPage(loadurl);
}