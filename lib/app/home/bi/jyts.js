
	$(document).ready(function(){
		//加载收入完成图表数据
		loadJytsChart();
	});
	
	//加载收入完成图表数据
	function loadJytsChart(){
            var url = $.hori.getconfig().appServerHost+"view/bi/loadJytsChart/accsyBiReport/services/reqBiReportData";
            var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;1$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
            var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
                soap+='<soapenv:Header/><soapenv:Body>';
                soap+='<web:viewReportById>';
                soap+='<web:in0>'+temp+'</web:in0>';
                soap+='</web:viewReportById>';
                soap+=' </soapenv:Body></soapenv:Envelope>';
            var data = "data-xml="+soap;
            $.hori.ajax({
                "type":"post",
                "url":url,
                "data":data,
                "success":function(res){
                	var jsonObj=JSON.parse(res);
                	$("#rightContent").load("bi/jyts.html", function(a, b, c) {
                		document.getElementById("neirong").innerHTML = jsonObj.reportdata.datatext;
				var ul = document.getElementById("loadBi");
				var lis = ul.getElementsByTagName("li");
				for (var i = 0; i < lis.length; i++) {
					lis[i].style.background = "#ededed";
				}
                 document.getElementById("1").style.backgroundColor='#836FFF'; 
            		});
        		
                },
                "error":function(res){
                    alert("error:" + res);
                    $.hori.hideLoading();
                }
            });
    }