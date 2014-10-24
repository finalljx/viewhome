
var pages=1;
var itcode;
$(document).ready(function() {
	itcode = localStorage.getItem("itcodetasklist");
	pullUpAction(itcode);
});
function pullUpAction(itcode){
	console.log(itcode);
	$.hori.showLoading();
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/docapp/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="
						+ itcode + "&start="+pages+"&count=15";
		
		//serverUrl=decodeURI(serverUrl);
		alert(serverUrl);
		$.hori.ajax({
			"type":"get",
			"url":serverUrl,
			"success":function(res){
				console.log(res);
				$("#taskList").empty();
				document.getElementById("divDataLoading").style.display='none';
				$("#taskList").append(res);
				loaded();
				myScroll.refresh();
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
	localStorage.setItem("contemplate",template);
	localStorage.setItem("unid",unid);
	var loadurl= $.hori.getconfig().appServerHost+"view/html/appform.html";
	$.hori.loadPage(loadurl);
}