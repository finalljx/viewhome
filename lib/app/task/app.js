var config=$.hori.getconfig();
var itcode=localStorage.getItem("itcode");
var oaMsgServer=config.oaMsgServer;
var serverUrl=config.appServerHost;
var pages=1;
$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	hori.setHeaderTitle("待办");
	getTaskList();
});

function getTaskList(){
	var url = 
	serverUrl+'view/oamobile/todosList/Produce/DigiFlowMobile.nsf/agGetMsgViewData?openagent&login&server='+oaMsgServer+'&dbpath=DFMessage/dfmsg_'+itcode+'.nsf&view=vwTaskUnDoneForMobile&thclass=&page=1&count=10';
	$.hori.ajax({
		"type":"get",
		"url":url,
		"success":function(res){
			document.getElementById("divDataLoading").style.display='none';
			document.getElementById("wrapper").style.display='';
			document.getElementById("pullUp").style.display='';
			$("#listcontent").html(res);
			pages=pages+1;
			loaded();
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
	var serverUrl=$.hori.getconfig().appServerHost+'view/oamobile/todosList/Produce/DigiFlowMobile.nsf/agGetMsgViewData?openagent&login&server='+oaMsgServer+'&dbpath=DFMessage/dfmsg_'+itcode+'.nsf&view=vwTaskUnDoneForMobile&thclass=&page='+pages+'&count=10';
	setTimeout(function () {
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
				pages=pages+1;
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
	var oaurl = "/Produce/DigiFlowMobile.nsf/showform?openform&login&apptype=msg&appserver="+oaMsgServer+"&appdbpath=DFMessage/dfmsg_"+itcode+".nsf&appdocunid="+docunid;
	localStorage.setItem("oaDataSource",oaurl);
	var targetURL= $.hori.getconfig().serverBaseUrl+"viewhome/html/appform.html";
	targetURL=encodeURI(targetURL);
	$.hori.loadPage(targetURL);
}
