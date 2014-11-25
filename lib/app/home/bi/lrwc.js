	$(document).ready(function(){
		//加载收入完成图表数据
		loadSrwcChart();
	});
	//加载收入完成图表数据
	function loadSrwcChart(){
            var url = $.hori.getconfig().appServerHost+"view/bi/loadSrwcChart/accsyBiReport/services/reqBiReportData";
            var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;16$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
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
                	
                	$("#rightContent").load("bi/lrwc.html", function(a, b, c) {
                		var one = seriesdata[1] / seriesdata[0] - 0.1;
						var two = seriesdata[2] / 100 + 0.1;
						var lrwc = seriesdata[1];
						var b = seriesname[0] + ":" + seriesdata[0]
								+ reportdata.primaryunit;
						//document.getElementById("yusuan").innerHTML=b;
						var c = seriesname[1] + ":" + seriesdata[1]
								+ reportdata.primaryunit;
						//document.getElementById("leiji").innerHTML=c;
						var d = seriesname[2] + ":" + seriesdata[2] + "%";
						//document.getElementById("bili").innerHTML=d;
						var ww = (Math.ceil((seriesdata[0]) / 10)) * 10;
						drawLrwc(ww, lrwc, 0.6, 0.7, b + "\n" + c + "\n" + d);
                		var ul = document.getElementById("loadBi");
        				var lis = ul.getElementsByTagName("li");
        				for (var i = 0; i < lis.length; i++) {
        					lis[i].style.background = "#ededed";
        				}
                         document.getElementById("16").style.backgroundColor='#5e87b0'; 
            		});
                },
                "error":function(res){
                    alert("error:" + res);
                    $.hori.hideLoading();
                }
            });
    }
	function drawLrwc(ljwcz, lrwc, colorOne, colorTwo, title){
		var option = {
				animation : false,
				backgroundColor : "#EEF5F6",
				title : {
					text : title,
					x : "center",
					y : "bottom"
				},
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
					startAngle : 179,
					endAngle : 0,
					splitNumber : 4, // 分割段数，默认为5
					max : ljwcz,
					radius : [ 0, '85%' ],
					axisLine : { // 坐标轴线
						lineStyle : { // 属性lineStyle控制线条样式
							color : [ [ colorOne, '#FFCC66' ],
									[ colorTwo, '#3399ff' ],
									[ 1, '#A066D3' ] ],
							width : 50
						}
					},
					axisTick : { // 坐标轴小标记
						splitNumber : 10, // 每份split细分多少段
						length : 4, // 属性length控制线长
						lineStyle : { // 属性lineStyle控制线条样式
							color : '#F5F5F5'
						//color : '#292421'
						}
					},
					axisLabel : { // 坐标轴文本标签，详见axis.axisLabel
						textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
							color : 'black',
							fontWeight : 'bolder',
							fontSize : 14
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
						margin : 20,
						offsetCenter : [ 0, '-10%' ], // x, y，单位px
						textStyle : { // 其余属性默认使用全局文本样式，详见TEXTSTYLE
							fontWeight : 'bolder',
							fontSize : '1'
						}
					},

					detail : {
						show : true,
						formatter : '{value}亿元',
						offsetCenter : [ 0, '30%' ],
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
			option.series[0].data[0].value = lrwc;
			myChart.setOption(option);
		}