$(document).ready(function(){
	
	$.hori.showLoading();
	$.hori.setHeaderTitle("表单");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");

	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=$.hori.getconfig().appServerHost+"view/oamobile/othercontentmobilePC";
	var dataSource=localStorage.getItem("oaDataSource");
	serverUrl=serverUrl+dataSource;
	
		$.hori.ajax({
			"type":"post",
			"url":serverUrl,
			"data":"",
			"success":function(htmlStr){
				htmlStr=htmlStr.replace(/&nbsp;/g," ");
				$("body").html(htmlStr);
				var jqscript=document.createElement("script");
				jqscript.src="../lib/jquery-mobile/jquery.mobile.min.js";
				$("head").after(jqscript);
				var filelihtml = $("#fileli").html();
				if(filelihtml=="" || filelihtml==null || filelihtml==" "){
					$("#filenews").after("<li class='ui-li ui-li-static ui-btn-up-d'>无附件</li>");
				}
				$.hori.hideLoading();
			},
			"error":function(res){
				$.hori.hideLoading();
			}
			});
});
