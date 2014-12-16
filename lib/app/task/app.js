var pages=1;
var itcode;
$(document).ready(function() {
	$.hori.setHeaderTitle("集团文件系统公文待办");
	itcode = localStorage.getItem("itcodetasklist");
	gettaskList(itcode);
	daili();
});
//判断是否代理待办
function daili(){
	var dailiUrl= $.hori.getconfig().appServerHost+"view/oa/getDaili/"+"docapp"+"/indishare/office.nsf/frmLogoInfo?open";
	$.hori.ajax({
			"type" : "post",
			"url" : dailiUrl,
			"success" : function(res) {
				if(res.indexOf("正由")!="-1"){
					localStorage.setItem("daili","yes");
				}else{
					localStorage.setItem("daili","no");
				}
			},
			"error" : function(res) {
				alert(res);
			}
	});
}
var ayeartime;
var formtime;
var taskListNum;
var taskListLiHideNum=0;
function fiteryear(){
	var now = new Date();
	var year=now.getFullYear()-1;   
	var month=now.getMonth()+1;
	if(month<10){month="0"+month;}
	var date=now.getDate();
	if(date<10){date="0"+date;}
	var hour=now.getHours();   
	var minute=now.getMinutes();   
	var second=now.getSeconds();
	ayeartime=year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
	$("li").each(function(){
		formtime = $(this).data("time");
		if(ayeartime>formtime){
			$(this).hide();
			taskListLiHideNum=taskListLiHideNum+1;
		}else{
		}
	});
	var nodataHtml='<li name="nodata" class="ui-li-static ui-body-inherit ui-first-child ui-last-child"><div style="width:100%;" align="center"><h3>无内容</h3></div></li>';
	if(taskListNum==taskListLiHideNum){
		$("#listcontent").empty();
		$("#listcontent").append(nodataHtml);
		$("#pullUp").hide();
		localStorage.setItem("pullUpActionVal","no");
	}
}
function gettaskList(itcode){
	$.hori.loading();
	var docServer=$.hori.getconfig().docServer;
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/"+docServer+"/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+pages+"&count=10";
	setTimeout(function () {
		$.hori.ajax({
			"type":"get",
			"url":serverUrl,
			"success":function(res){
				document.getElementById("listcontent").innerHTML="";
				document.getElementById("divDataLoading").style.display='none';
				document.getElementById("wrapper").style.display='';
				document.getElementById("pullUp").style.display='';
				$("#listcontent").html(res);
				pages=pages+10;
				loaded();
				myScroll.refresh();
				/*if(res.indexOf("tasknumber")!="-1"){
					var divs = document.getElementsByName("nodata");
					for(var i=0; i<divs.length; i++)
					{
						divs[i].style.display='none';
					}
				}**/
				if(res.indexOf("无内容")!="-1"){
					document.getElementById("pullUp").style.display="none";
				}
				taskListNum = $("#listcontent li").length;
				localStorage.setItem("pullUpActionVal","yes");
				fiteryear();
				$.hori.loading("hide");
			},
			"error":function(res){
				alert("error:"+res);
				$.hori.loading("hide");
			}
		});
	}, 1000);
	
}
function pullUpAction(itcode){
	$.hori.loading();
	var pullUpActionVal = localStorage.getItem("pullUpActionVal");
	if(pullUpActionVal=="no"){
		$.hori.loading("hide");
		return false;
	}
	var docServer=$.hori.getconfig().docServer;
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/"+docServer+"/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+pages+"&count=10";
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
				taskListNum = $("#listcontent li").length;
				localStorage.setItem("pullUpActionVal","yes");
				myScroll.refresh();
				pages=pages+10;
				fiteryear();
				$.hori.loading("hide");
			},
			"error":function(res){
				$.hori.loading("hide");
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
	$.hori.loading();
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
	var docServer=$.hori.getconfig().docServer;
	var loadurl= $.hori.getconfig().appServerHost+"viewhome/oa/getunid/"+docServer+"/genertec/persontasks.nsf/agtUrlRef?openagent&unid="+unid+"&user="+itcode;
	var editdocument;
	$.hori.ajax({
			"type" : "get",
			"url" : loadurl,
			"success" : function(res) {
				var num=res.indexOf("?>");
				var docunid=res.substring(num+2);
				var daili = localStorage.getItem("daili");
				if(daili=="yes"){
					editdocument="opendocument"
				}else if (daili=="no")
				{
					editdocument="editdocument"
				}
				if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)||window.navigator.userAgent.match(/android/i)){
					var url= 'viewhome/oa/'+template+'/'+docServer+'/'+docunid+'?'+editdocument+'&data-application=' + $.hori.getconfig().appKey + "&data-userstore=" + localStorage.getItem("cookie_userstore");
				}else{
					var url= 'viewhome/oa/'+template+'/'+docServer+'/'+docunid+'?'+editdocument+'&data-application=' + $.hori.getconfig().appKey;
				}
				var loadurl= $.hori.getconfig().appServerHost+url;
				$.hori.loadPage(loadurl);
				$.hori.loading("hide");
			},
			"error" : function(res) {
				alert(res);
				$.hori.loading("hide");
			}
	});
}