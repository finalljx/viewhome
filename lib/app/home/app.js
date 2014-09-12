$(document).ready(function(){
	
	$.hori.showLoading();
	$.hori.setHeaderTitle("首页");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");
     alert(itcode);
	var serverUrl=$.hori.getconfig().appServerHost+"view/bi/loadSrlrqsChart/accsyBiReport/services/reqBiReportList";
	 var temp ="$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;userid$gt;fangyonghong$lt;/userid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
	 
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
					document.getElementById("divOne").className="ui-grid-b"; 
					document.getElementById("cc").style.display="none";
				}
				$.hori.hideLoading();
			},
			"error":function(res){
				alert("shibai");
				$.hori.hideLoading();
			}
			});
});
