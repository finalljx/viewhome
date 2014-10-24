$(document).ready(function(){
	$.hori.showLoading();
	$.hori.setHeaderTitle("表单2");
	var config=$.hori.getconfig();
	var type = localStorage.getItem("type");
	var unid= localStorage.getItem("unid");
	var loadurl= $.hori.getconfig().appServerHost+"view/oa/querycontent/docapp/genertec/dep1/qsbg_1.nsf/"+type+"/"+unid+"?editdocument";
		$.hori.ajax({
			"type":"post",
			"url":loadurl,
			"data":"",
			"success":function(htmlStr){
				alert(2);
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