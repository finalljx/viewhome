$(document).ready(function(){
	
	$.hori.showLoading();
	$.hori.setHeaderTitle("公告");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");

	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=$.hori.getconfig().appServerHost+"view/oamobile/contentAnnouce";
	
	var dataSource=localStorage.getItem("oaDataSource");
	var localServer=$.hori.getconfig().serverBaseUrl;
	serverUrl=serverUrl+dataSource;
		$.hori.ajax({
			"type":"post",
			"url":serverUrl,
			"success":function(htmlStr){
				htmlStr=htmlStr.replace(/&nbsp;/g," ");
				htmlStr=htmlStr.replace(/&lt;/g,"<");
				htmlStr=htmlStr.replace(/&gt;/g,">");
				
				$("body").html(htmlStr);
				var jqscript=document.createElement("script");
				jqscript.src="../lib/jquery-mobile/jquery.mobile.min.js";
				$("head").after(jqscript);
				var getAttachjs=document.createElement("script");
				getAttachjs.src="../lib/app/annouceform/getAttach.js";
				
				$("head").after(getAttachjs);
				$.hori.hideLoading();
			},
			"error":function(res){
				$.hori.hideLoading();
			}
			});
});
