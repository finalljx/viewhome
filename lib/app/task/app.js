var pages=1;
var itcode;
$(document).ready(function() {
	$.hori.setHeaderTitle("集团文件系统公文待办");
	//判断用户权限
	//itcodeAlowTask();
	itcode = localStorage.getItem("Chinesename");
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
	}else if(taskListNum<10){
		$("#pullUp").hide();
		localStorage.setItem("pullUpActionVal","no");
	}
}

function itcodeAlowTask(){
	try{
	var itcode = localStorage.getItem("itcode");
	 var url=$.hori.getconfig().appServerHost + "/biz/mobile/permission.jsp?it_code="+itcode;
	$.hori.ajax({
		"type" : "get",
		"url" : url,
		"success" : function(res) {
			var json = JSON.parse(res);
			
			if(json[0].DOC_MOBILE!=undefined){
				if(json[0].DOC_MOBILE=="Y"){
					document.getElementById("gwcy").style.display="block";
					document.getElementById("gwdb").style.display="block";
					
				}else if(json[0].DOC_MOBILE=="N"){
					document.getElementById("gwcy").style.display="none";
					document.getElementById("gwdb").style.display="none";
				}
				if(json[0].OA_MOBILE=="N"){
					document.getElementById("aqsc").style.display="none";
				}else if(json[0].OA_MOBILE=="Y"){
					document.getElementById("aqsc").style.display="block";
				}
				if(json[0].BI_MOBILE=="Y"){
					document.getElementById("jysj").style.display="block";
				}else if(json[0].BI_MOBILE=="N"){
					document.getElementById("jysj").style.display="none";
					}
				}
			$.hori.hideLoading();
			},
		"error" : function(res) {
			$.hori.hideLoading();
		}
	});
	} catch (e) {
		alert(e.message);
	}
}

function gettaskList(itcode){
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/"+$.hori.getconfig().docServer+"/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+pages+"&count=30";
	//alert(serverUrl);
	$.hori.ajax({
		"type":"get",
		"url":serverUrl,
		"success":function(res){
			//document.getElementById("divDataLoading").style.display='none';
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
			$("#thirtyList").show();
			$("#pullUp").hide();
			$.hori.hideLoading();
		},
		"error":function(res){
			$.hori.hideLoading();
		}
	});
}
function pullUpAction(itcode){
	//临时禁用加载更多 2014-12-25 武红宇
	return false;
	try{
	$.hori.showLoading();
	var pullUpActionVal = localStorage.getItem("pullUpActionVal");
	if(pullUpActionVal=="no"){
		$.hori.loading("hide");
		$.hori.hideLoading();
		return false;
	}
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/todos/"+$.hori.getconfig().docServer+"/genertec/persontasks.nsf/dbview?openform&view=vwgwdbshow&restricttocategory="+itcode+"&start="+pages+"&count=10";
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
			//document.getElementById("divDataLoading").style.display='none';
			$("#listcontent").append(res);
			taskListNum = $("#listcontent li").length;
			localStorage.setItem("pullUpActionVal","yes");
			myScroll.refresh();
			pages=pages+10;
			fiteryear();
			$.hori.hideLoading();
		},
		"error":function(res){
			$.hori.hideLoading();
		}
	});
	} catch (e) {
		alert(e.message);
	}
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
	try{
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
	var loadurl= $.hori.getconfig().appServerHost+"viewhome/oa/getunid/"+$.hori.getconfig().docServer+"/genertec/persontasks.nsf/agtUrlRef?openagent&unid="+unid+"&user="+itcode;
	var editdocument;
	var random = new Date().getTime();
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
					var url= 'viewhome/oa/'+template+'/'+$.hori.getconfig().docServer+'/'+docunid+'?'+editdocument+'&data-application=' + $.hori.getconfig().appKey + "&data-userstore=" + localStorage.getItem("cookie_userstore")+"&random="+random;
				}else{
					var url= 'viewhome/oa/'+template+'/'+$.hori.getconfig().docServer+'/'+docunid+'?'+editdocument+'&data-application=' + $.hori.getconfig().appKey+"&random="+random;
				}
				$.hori.hideLoading();
				var loadurl= $.hori.getconfig().appServerHost+url;
				$.hori.loadPage(loadurl);
			},
			"error" : function(res) {
				alert(res);
			}
		});
	} catch (e) {
		alert(e.message);
	}
}

