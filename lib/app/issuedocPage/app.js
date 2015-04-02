$(document).ready(function(){
	$.hori.showLoading();
	$.hori.setHeaderTitle("公文内容");
	var dataSource=localStorage.getItem("oaDataSource");
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/issuedocPage/";
	serverUrl=serverUrl+dataSource;
		$.hori.ajax({
			"type":"post",
			"url":serverUrl,
			"data":"",
			"success":function(htmlStr){
				$("body").html(htmlStr);
				var jqscript=document.createElement("script");
				jqscript.src="../lib/jquery-mobile/jquery.mobile.min.js";
				var getAttachjs=document.createElement("script");
				getAttachjs.src="../lib/app/issuedocPage/getAttach.js";
				$("head").after(jqscript);
				$("head").after(getAttachjs);
				$.hori.hideLoading();
			},
			"error":function(res){
				alert(res);
				$.hori.hideLoading();
			}
			});
});