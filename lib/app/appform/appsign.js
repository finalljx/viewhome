$(document).ready(function(){
	$.hori.showLoading();
	//$.hori.hideLoading();
	$.hori.setHeaderTitle("表单");
	var config=$.hori.getconfig();
	var unid= localStorage.getItem("unid");
	var loadurl= $.hori.getconfig().appServerHost+"view/oa/contentsign/"+unid;



		$.hori.ajax({
			"type":"post",
			"url":loadurl,
			"data":"",
			"success":function(htmlStr){
				$("body").html(htmlStr);
				var jqscript=document.createElement("script");
				jqscript.src="../lib/jquery-mobile/jquery.mobile.min.js";
				$("head").after(jqscript);
				$.hori.hideLoading();
			},
			"error":function(res){
				$.hori.hideLoading();
			}
			});
});
