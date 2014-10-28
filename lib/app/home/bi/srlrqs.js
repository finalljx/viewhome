
$(document).ready(function(){
		//加载收入完成图表数据
		loadSrlrqsChart()
	});
	//加载收入完成图表数据
	function loadSrlrqsChart(){
            var url = $.hori.getconfig().appServerHost+"view/bi/loadSrlrqsChart/accsyBiReport/services/reqBiReportData";
            var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;6$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
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
                	console.log(res);
                	var income  = json.reportdata.income;
                	var profit = json.reportdata.profit;
                	var month= income.statMonth.split('|');
                	var seriesname = income.seriesname.split('|');
                	var lastSumData = income.lastSumData.split('|');
                	var nowSumData = income.nowSumData.split('|');
                	var increaseData = income.increaseData.split('|');
                	var yearBudget = income.yearBudget.split('|');
                	var month2= income.statMonth.split('|');
                	var seriesname2 = profit.seriesname.split('|');
                	var lastSumData2 = profit.lastSumData.split('|');
                	var nowSumData2 = profit.nowSumData.split('|');
                	var increaseData2 = profit.increaseData.split('|');
                	var yearBudget2 = profit.yearBudget.split('|');
                	$("#rightContent").load("bi/srlrqs.html", function(a, b, c) {
                		loadSrlrqs(month,seriesname,lastSumData,nowSumData,increaseData,yearBudget);
                		loadSrlrqs2(month2,seriesname2,lastSumData2,nowSumData2,increaseData2,yearBudget2); 
                		var ul = document.getElementById("loadBi");
        				var lis = ul.getElementsByTagName("li");
        				for (var i = 0; i < lis.length; i++) {
        					lis[i].style.background = "#ededed";
        				}
                         document.getElementById("6").style.backgroundColor='#836FFF'; 
                	});
                },
                "error":function(res){
                    alert("error:" + res);
                    $.hori.hideLoading();
                }
            });
    }
	
	function loadSrlrqs(month,seriesname,lastSumData,nowSumData,increaseData,yearBudget) {
		var option = {
			tooltip : {
				trigger : 'axis'
			},
			toolbox : {
				show : false,
				feature : {
					mark : {
						show : false
					},
					dataView : {
						show : false,
						readOnly : false
					},
					magicType : {
						show : false,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : false
					},
					saveAsImage : {
						show : false
					}
				}
			},
			calculable : false,
			legend : {
				data : seriesname
			},
			xAxis : [ {
				type : 'category',
				data : month
			} ],
			yAxis : [ {
				type : 'value',
				axisLabel : {
					formatter : '{value} 亿元'
				}
			}, {
				type : 'value',
				axisLabel : {
					formatter : '{value} '
				}
			} ],
			series : [

					{
						name : seriesname[0],
						type : 'bar',
						data : lastSumData
					},
					{
						name : seriesname[1],
						type : 'bar',
						data : nowSumData
					},
					{
						name : seriesname[2],
						type : 'line',
						yAxisIndex : 1,
						data : increaseData
					},
					{
						name : seriesname[3],
						type : 'line',
						yAxisIndex : 1,
						data : yearBudget
					}  ]
		};
		var myChart = echarts.init(document.getElementById('main'));
		myChart.setOption(option);
	}
	function loadSrlrqs2(month2,seriesname2,lastSumData2,nowSumData2,increaseData2,yearBudget2) {
		var option = {
			tooltip : {
				trigger : 'axis'
			},
			toolbox : {
				show : false,
				feature : {
					mark : {
						show : false
					},
					dataView : {
						show : false,
						readOnly : false
					},
					magicType : {
						show : false,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : false
					},
					saveAsImage : {
						show : false
					}
				}
			},
			calculable : false,
			legend : {
				data : seriesname2
			},
			xAxis : [ {
				type : 'category',
				data : month2
			} ],
			yAxis : [ {
				type : 'value',
				axisLabel : {
					formatter : '{value} 亿元'
				}
			}, {
				type : 'value',
				axisLabel : {
					formatter : '{value} '
				}
			} ],
			series : [

					{
						name : seriesname2[0],
						type : 'bar',
						data : lastSumData2
					},
					{
						name : seriesname2[1],
						type : 'bar',
						data : nowSumData2
					},
					{
						name : seriesname2[2],
						type : 'line',
						yAxisIndex : 1,
						data : increaseData2
					},
					{
						name : seriesname2[3],
						type : 'line',
						yAxisIndex : 1,
						data : yearBudget2
					}  ]
		};
		var myChart = echarts.init(document.getElementById('main1'));
		myChart.setOption(option);
	}
	