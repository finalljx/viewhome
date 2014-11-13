$(document).ready(function(){
	$.hori.showLoading();
	$.hori.setHeaderTitle("集团内部请示报告");
	var config=$.hori.getconfig();
	var type = localStorage.getItem("type");
	var unid= localStorage.getItem("unid");
	var loadurl= $.hori.getconfig().appServerHost+"view/oa/querycontent/"+unid;
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