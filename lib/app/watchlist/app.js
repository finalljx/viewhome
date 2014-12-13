$(document).ready(function(){
	
	$.hori.showLoading();
	$.hori.setHeaderTitle("安全生产值班表详情");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");
    var docunid=localStorage.getItem("watchDocUnid");
	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=$.hori.getconfig().appServerHost+"view/oa/watchlistInfo";
	
	var dataSource="/Produce/DigiFlowMobile.nsf/showform?openform&login&apptype=&appserver=&appdbpath=Application/Safety/SafetyProBasic.nsf&appdocunid="+docunid;
	var localServer=$.hori.getconfig().serverBaseUrl;
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
				
				var reg=/(联系电话 ：)((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/g;
				var rep= '$1<a href="tel:$2" style="">$2</a>';
				console.log('=='+$('#ibody').html());
				var exp= $('#ibody').html();
				exp=exp.replace(reg, rep);
				$('#ibody').html(exp);
				$.hori.hideLoading();
			},
			"error":function(res){
				$.hori.hideLoading();
			}
			});
});
