	$(document).ready(function(){
		//加载收入完成图表数据
		loadSrwcChart();
	});
	//加载收入完成图表数据
	function loadSrwcChart(){
            var url = $.hori.getconfig().appServerHost+"view/bi/loadSrwcChart/accsyBiReport/services/reqBiReportData";
            var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;11$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
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
                	reportdata=json.reportdata;
                	var seriesname=reportdata.seriesname.split('|');
                	var seriesdata=reportdata.seriesdata.split('|');
                	var srwc=seriesdata[1];
                	
                	$("#rightContent").load("bi/srwc.html", function(a, b, c) {
                		var b=seriesname[0]+":"+seriesdata[0]+reportdata.primaryunit;
                    	document.getElementById("yusuan").innerHTML=b;
                    	var c=seriesname[1]+":"+seriesdata[1]+reportdata.primaryunit;
                    	document.getElementById("leiji").innerHTML=c;
                    	var d=seriesname[2]+":"+seriesdata[2]+"%";
                    	document.getElementById("bili").innerHTML=d;
                    	var ww=(Math.ceil((seriesdata[1])/100))*100;
                		drawSrwc(ww,srwc);
                		var ul = document.getElementById("loadBi");
        				var lis = ul.getElementsByTagName("li");
        				for (var i = 0; i < lis.length; i++) {
        					lis[i].style.background = "#ededed";
        				}
                         document.getElementById("11").style.backgroundColor='#836FFF'; 
                	});
                },
                "error":function(res){
                    alert("error:" + res);
                    $.hori.hideLoading();
                }
            });
    }
	function drawSrwc(ww,srwc){
		var option = {
				toolbox : {
					show : false,
					feature : {
						mark : {
							show : false
						},
						restore : {
							show : false
						},
						saveAsImage : {
							show : false
						}
					}
				},
				
				series : [ {
					name : '收入完成',
					type : 'gauge',
					startAngle: 179,
		            endAngle : 0,
					splitNumber :4, // 分割段数，默认为5
					max:ww,
					axisLine : { // 坐标轴线
						lineStyle : { // 属性lineStyle控制线条样式
							color : [ [ 0.2, '#01a149' ], [ 0.8, '#01a149' ],
									[ 1, '#01a149' ] ],
							width : 50
						}
					},
					axisTick : { // 坐标轴小标记
						splitNumber : 10, // 每份split细分多少段
						length : 10, // 属性length控制线长
						lineStyle : { // 属性lineStyle控制线条样式
							color : '#1ad4d1'
						}
					},
					axisLabel : { // 坐标轴文本标签，详见axis.axisLabel
						textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
							color : '#ffffff'
						}
					},
					splitLine : { // 分隔线
						show : true, // 默认显示，属性show控制显示与否
						length : 10, // 属性length控制线长
						lineStyle : { // 属性lineStyle（详见lineStyle）控制线条样式
							color : '#00EEEE'
						}
					},
					 
					pointer : {
						width : 5
					},
					title : {
						show : true,
						offsetCenter : [ 0, '-40%' ], // x, y，单位px
						textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
							fontWeight : 'bolder'
						}
					},
					
					detail : {
						show : false,
						//formatter:'{value}%',
						textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
							fontWeight : 'bolder'
						}
					},
					data : [ {
						value : 0,
						name : ''
					} ]
				} ]
			};
			var myChart = echarts.init(document.getElementById('main'));
			option.series[0].data[0].value =srwc;
			myChart.setOption(option);
	}