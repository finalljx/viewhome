var config=$.hori.getconfig();
var itcode=localStorage.getItem("itcode");
var serverUrl=config.appServerHost;
var number=1;
$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	hori.setHeaderTitle("通知公告");
	  loaded();
	 getAnnouceList();
});

function getAnnouceList(){
	var url = 
	serverUrl+'view/oamobile/annoucement/Application/DigiFlowInfoPublish.nsf/InfoByDateView?readviewentries?login&start='+number+'&count=10';
	$.hori.ajax({
		"type":"get",
		"url":url,
		"success":function(res){
			document.getElementById("divDataLoading").style.display='none';
			document.getElementById("wrapper").style.display='';
			document.getElementById("pullUp").style.display='';
			$("#listcontent").html(res);
			number=number+10;
			
			myScroll.refresh();
			if(res.indexOf("无内容")!="-1"){
				document.getElementById("pullUp").style.display="none";
			}
			$.hori.hideLoading();
		},
		"error":function(res){
			$.hori.hideLoading();
		}
	});
}

function pullUpAction(){
	$.hori.showLoading();
	getAnnouceList();
}

	function loaded() {
		pullUpEl = document.getElementById('pullUp');	
		pullUpOffset = pullUpEl.offsetHeight;
		myScroll = new iScroll('wrapper', {
			useTransition: true,
			topOffset: pullUpOffset,
			onRefresh: function () {
			if (pullUpEl.className.match('loading')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
			}
		},
		onScrollMove: function () {
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
				this.maxScrollY = this.maxScrollY;
			} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
				this.maxScrollY = pullUpOffset;
			}
		},
		onScrollEnd: function () {
			if (pullUpEl.className.match('flip')) {
				pullUpEl.className = 'loading';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '';
				pullUpAction();
			}
		}
		});
}
var t1 = null;//这个设置为全局
function loadPageForm(str){
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
	var docunid = $(str).data("unid");
	localStorage.setItem("annoucedocunid",docunid);
	/*if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)||window.navigator.userAgent.match(/android/i)){
		var oaurl =$.hori.getconfig().appServerHost+'view/oamobile/contentAnnouce/Application/DigiFlowInfoPublish.nsf/InfoByDateView/'+docunid+'?opendocument?login?editdocument&data-application=' + $.hori.getconfig().appKey + "&data-userstore=" + localStorage.getItem("cookie_userstore");
	}else{
		var oaurl =$.hori.getconfig().appServerHost+'view/oamobile/contentAnnouce/Application/DigiFlowInfoPublish.nsf/InfoByDateView/'+docunid+'?opendocument?login';
	}*/
	var oaurl='/Application/DigiFlowInfoPublish.nsf/InfoByDateView/'+docunid+'?opendocument?login';
	localStorage.setItem("oaDataSource",oaurl);
	var targetURL= $.hori.getconfig().serverBaseUrl+"viewhome/html/annouceform.html";
	targetURL=encodeURI(targetURL);
	$.hori.loadPage(targetURL);
}
