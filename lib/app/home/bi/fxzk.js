$(document).ready(function(){
		//加载收入完成图表数据
		loadSrwcChart();
	});
	
	//加载收入完成图表数据
	function loadSrwcChart(){
            var url = $.hori.getconfig().appServerHost+"view/bi/loadJytsChart/accsyBiReport/services/reqBiReportData";
            var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;21$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
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
                	var json=JSON.parse(res);
        		 var title =json.reportdata.title;
        		 var type=json.reportdata.type;
        		 var year=json.reportdata.year;
        		 var month=json.reportdata.month;
        		 var monthdata=json.reportdata.monthData.split('|');
        		 
        		var busiData=json.reportdata.busiData;
        		var imgString="<ul style='padding:10px;list-style:none;'><li><div style='float:left;width:60px;'>&nbsp;</div><div style='float:left;width:50px;'>&nbsp;</div>";
        		for(var z=0;z<monthdata.length;z++){
        			imgString=imgString+"<div style='float:left;width:6%;'>"+monthdata[z]+"</div>";
        		}
        		imgString=imgString+"</li><br/>"
        		for(var i=0;i<busiData.length;i++){
        			var busiName=busiData[i].busiName;
        			if(30==busiData[i].now){
        				imgString=imgString+"<li style='line-height:50px;'><div style='float:left;clear:both;width:60px;'><font size='2'>"+busiName+"</font></div><div style='float:left;width:50px;'><img src='img/dahong.png'></img></div>"
        			}else {
        				imgString=imgString+"<li style='line-height:50px;'><div style='float:left;clear:both;width:60px;'><font size='2'>"+busiName+"</div><div style='float:left;width:50px;'><img src='img/dalv.png'></img></div>"
        			}
        			var imageType=busiData[i].imageType.split('|');
        			for(var j=0;j<imageType.length-1;j++){
        				if(10==imageType[j]){
        					imgString=imgString+"<div style='float:left;width:6%;line-height:60px;'><img src='img/xiaolv.png'></img></div>";
        				}else if(20==imageType[j]){
        					imgString=imgString+"<div style='float:left;width:6%;line-height:60px;'><img src='img/xiaohuang.png'></img></div>";
        				}else if(30==imageType[j]){
        					imgString=imgString+"<div style='float:left;width:6%;line-height:60px;'><img src='img/xiaohong.png'></img></div>";
        				}else{
        					imgString=imgString+"<div style='float:left;width:6%;line-height:60px;'><img src='img/xiaohui.png'></img></div>";
        				}
        			}
        			imgString=imgString+"</li>";
        		 }
        		imgString=imgString+"</ul>";
        		document.getElementById("xianshi").innerHTML=imgString;
               },
                "error":function(res){
                    alert("error:" + res);
                    $.hori.hideLoading();
                }
            });
    }