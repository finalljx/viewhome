
$(document).ready(function(){
	
	$.hori.showLoading();
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");
	var serverUrl=$.hori.getconfig().appServerHost+"view/bi/loadQuanxianChart/accsyBiReport/services/reqBiReportList";
	 var temp ="$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;userid$gt;"+"wpsadmin"+"$lt;/userid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
	 
	 var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
         soap+='<soapenv:Header/><soapenv:Body>';
         soap+='<web:getAllReportByUserId>';
         soap+='<web:in0>'+temp+'</web:in0>';
         soap+='</web:getAllReportByUserId>';
         soap+=' </soapenv:Body></soapenv:Envelope>';
     var data = "data-xml="+soap;
		$.hori.ajax({
			"type":"post",
			"url":serverUrl,
			"data":data,
			"success":function(res){
				var json=JSON.parse(res);
				if(json.error){
				}else{
					localStorage.setItem("json",res);
					$.getScript("../lib/app/home/bi/biJs.js");
					console.log(json);
				}
				$.hori.hideLoading();
			},
			"error":function(res){
				$.hori.hideLoading();
			}
			});
});
