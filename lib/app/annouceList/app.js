var config=$.hori.getconfig();
var itcode=localStorage.getItem("itcode");
var serverUrl=config.appServerHost;
$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	hori.setHeaderTitle("通知公告");
	getAnnouceList();
	
	
});
var starNumber=1;

function getAnnouceList(){
	var url = 
	serverUrl+'view/oamobile/annoucement/Application/DigiFlowInfoPublish.nsf/InfoByDateView?readviewentries&login&start='+starNumber+'&count=10';
	$.hori.ajax({
		"type":"get",
		"url":url,
		"success":function(res){
			document.getElementById("divDataLoading").style.display='none';
			document.getElementById("wrapper").style.display='';
			document.getElementById("pullUp").style.display='none';
			if(res.indexOf("无更多内容")!="-1"){
				res='<li id="linodata" name="nodata" class="ui-li-static ui-body-inherit ui-first-child ui-last-child"><div align="center"><span>无内容</span></div></li>'; 
			}
			
			$("#listcontent").html(res);
			loaded();
			myScroll.refresh();
			
			$.hori.hideLoading();
		},
		"error":function(res){
			$.hori.hideLoading();
		}
	});
}
var endNumber;
function pullUpAction(){
	$.hori.showLoading();
	endNumber = parseInt($("#listcontent a:last").attr("data-endNumber"))+1;
	var serverUrl=$.hori.getconfig().appServerHost+'view/oamobile/annoucement/Application/DigiFlowInfoPublish.nsf/InfoByDateView?readviewentries?login&start='+endNumber+'&count=10';
	setTimeout(function () {
		$.hori.ajax({
			"type":"get",
			"url":serverUrl,
			"success":function(res){
				//if(res.indexOf("无更多内容")!="-1"){
					var divs = document.getElementsByName("nodata");
					for(var i=0; i<divs.length; i++)
					{
						divs[i].style.display='none';
					}
				//}
				document.getElementById("divDataLoading").style.display='none';
				$("#listcontent").append(res);
				myScroll.refresh();
				$.hori.hideLoading();
			},
			"error":function(res){
				$.hori.hideLoading();
			}
		});
	}, 1000);
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