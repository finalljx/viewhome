var pages=1;
var itcode;
$(document).ready(function() {
	$.hori.setHeaderTitle("集团文件系统公文待办");
	$.hori.showLoading();
	itcode = localStorage.getItem("itcodetasklist");
	gettaskList(itcode);
});
function gettaskList(itcode){
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/docapp/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+pages+"&count=15";
	//alert(serverUrl);
	$.hori.ajax({
		"type":"get",
		"url":serverUrl,
		"success":function(res){
			document.getElementById("listcontent").innerHTML="";
			document.getElementById("divDataLoading").style.display='none';
			document.getElementById("pullUp").style.display='';
			$("#listcontent").html(res);
			pages=pages+15;
			loaded();
			myScroll.refresh();
			$.hori.hideLoading();
		},
		"error":function(res){
			$.hori.hideLoading();
		}
	});
}
function pullUpAction(itcode){
	$.hori.showLoading();
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/docapp/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+pages+"&count=15";
	$.hori.ajax({
		"type":"get",
		"url":serverUrl,
		"success":function(res){
			if(res.indexOf("无内容")!="-1"){
				var divs = document.getElementsByName("nodata");
				for(var i=0; i<divs.length; i++)
				{
					divs[i].style.display='none';
				}
			}
			document.getElementById("divDataLoading").style.display='none';
			$("#listcontent").append(res);
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
var t1 = null;//这个设置为全局
function loadPageForm(str){
	$.hori.showLoading();
	if (t1 == null){
        t1 = new Date().getTime();
    }else{       
        var t2 = new Date().getTime();
        if(t2 - t1 < 500){
            t1 = t2;
            return;
        }else{
            t1 = t2;
        }
    }
	var template ="todoscontent";
	var unid = $(str).data("unid");
	var type = $(str).data("type");
	if(type=="会签库"){
		template="signcontent";
	}
	itcode=localStorage.getItem("Chinesename");
	localStorage.setItem("contemplate",template);
	localStorage.setItem("unid",unid);
	//var loadurl= $.hori.getconfig().appServerHost+"view/html/appform.html";
	var loadurl= $.hori.getconfig().appServerHost+"viewhome/oa/getunid/docapp/genertec/persontasks.nsf/agtUrlRef?openagent&unid="+unid+"&user="+itcode;
	$.hori.ajax({
			"type" : "get",
			"url" : loadurl,
			"success" : function(res) {
				var num=res.indexOf("?>");
				var docunid=res.substring(num+2);
				var url= 'viewhome/oa/'+template+'/docapp/'+docunid+'?editdocument';
				var loadurl= $.hori.getconfig().appServerHost+url;
				$.hori.loadPage(loadurl);
			},
			"error" : function(res) {
				alert(res);
			}
		});
}