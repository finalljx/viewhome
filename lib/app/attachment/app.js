var app=window.app={
};
var currentPage = 1;
var total =0;
var path = "";
var initwidth =0;
var loaded = true;
app.getData=function(args){
	var dataSource=args.dataSource;
	if(dataSource.lastIndexOf("%")>0 && $.hori.getMobileType()=="android"){
		dataSource=decodeURI(dataSource);
	}
	$.hori.ajax({
		"type":"post",
		"url":dataSource,
		"data":"",
		"success":function(res){
			var number = res.indexOf("not found on this server");
			if(number!="-1"){
				alert("文件不存在");
				$("#divDataLoading").hide();
				return;
			}
			var jsonObj=JSON.parse(res);
			if(jsonObj.needLogin){
				var redirectUrl=document.location.href;
				$.hori.jumpToLogin({"redirecUrl":redirectUrl});
				return ;
			}
			app.render(jsonObj);
			

			$("#divDataLoading").hide();

		},
		"error":function(res){
			alert(res);
			$.hori.hideLoading();

			$("#divDataLoading").hide();

		}
	});
	
};

app.render=function(jsonObj){
	
	var hori=$.hori;
	var config=$.hori.getconfig();	
	var serverUrl=config.appServerHost;
	total=jsonObj.total;
	path=jsonObj.path;
	type=jsonObj.type;		//path 或者 content
	content=jsonObj.content;
	//隐藏提示信息
	$("#divDataLoading").hide();
	
	hori.registerEvent("previousButton", "touchUp", function(oper) {
		prewpage();
	});
	
	hori.registerEvent("nextButton", "touchUp", function(oper) {
		nextpage();
	});
	
	
	hori.setHeaderTitle("第"+currentPage+"页/共" + total + "页");
	$("#imgtitle").html("第"+currentPage+"页/共" + total + "页");
		
	
	if(type=="path"){
	
		if(path.indexOf("?")!=-1){
			path = serverUrl+path + "&data-random=" + Math.random();
		}else{
			path =serverUrl+path + "?data-random=" + Math.random();
		}
		
			if($("#imgcontent")){
				$("#imgcontent").attr("src", path);
				$("#imgcontent").attr("width", initwidth);
			}
		}
		if(type=="content"){
			if($("#preContent")){
				$("#preContent").text(content);
				$("#preContent").attr("width", initwidth);
			}
		}
		showHideButtons();
};
$(document).ready(function(){
	var hori=$.hori;
	initwidth = document.body.clientWidth;
	var attachUrl=localStorage.getItem("attachmentUrl");
	
	var dataSource=attachUrl;
	app.getData({
		"dataSource":dataSource
	});
	
	
	
});
function showHideButtons() {
	// alert("showHideButtons run ")
	if (currentPage > 1) {
		showButton("previousButton");
	} else {
		hideButton("previousButton");
	}
	if (currentPage < total) {
		

		showButton("nextButton");
	} else {
		hideButton("nextButton");
	}
}


function changeimg(){
	try{

		$("#imgcontent").attr("width", initwidth);
		$.hori.showLoading();
		loaded = false;
		
		$.hori.setHeaderTitle("第"+currentPage+"页/共" + total + "页");
		var config=$.hori.getconfig();
		
		var serverUrl=config.appServerHost;
		
		var dataUserstore=getUrlParam(path,"data-userstore");
		//去掉data-page和开始的反斜杠
		dataPageIndex=path.indexOf("data-page");
		if(dataPageIndex>0){
			path=path.substring(0, dataPageIndex-1);
		}
		//第二次path已经包含serverUrl,不用再添加
		if(path.indexOf("://")==-1){
			path=serverUrl+path;
		}
		//增加data-userstore
		if(path.indexOf('?')==-1){
			path=path+"?data-userstore="+dataUserstore;
		}else{
			path=path+"&data-userstore="+dataUserstore;
		}
	
		showHideButtons();
		var random = parseInt(Math.random()*1000+1);
		
		if(path.indexOf('?')==-1){
			
			var imgSrcPath=path + "?data-page=" + currentPage+"&data-cache=false&data-random=" + random+"&data-userstore="+dataUserstore
		}else{
			var imgSrcPath=path + "&data-page=" + currentPage+"&data-cache=false&data-random=" + random;
		}
		
		$("#imgcontent").attr("src", imgSrcPath).one('load',function(){
			$.hori.hideLoading();loaded=true;}
		);
	}catch(e){
		alert(e.message);
	}
}
function prewpage(){
	if(currentPage > 1 && loaded==true){
		currentPage = currentPage - 1;
		changeimg();
	}
}
function nextpage(){
	if(currentPage < total && loaded==true){
		currentPage = currentPage + 1;
		changeimg();
	}
}
function hideButton(xmlButtonName){
	// alert("hide --"+xmlButtonName);
	new cherry.NativeOperation(xmlButtonName,"setProperty",["hidden","1"]).dispatch();
	cherry.flushOperations();
}
function showButton(xmlButtonName){
	new cherry.bridge.NativeOperation(xmlButtonName,"setProperty",["hidden","0"]).dispatch();
	cherry.bridge.flushOperations();
}

function getUrlParam(url,name)
{

	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象

	var r = url.match(reg);  //匹配目标参数

	if (r!=null) return unescape(r[2]); return null; //返回参数值

}