$(document).ready(function() {
	// 加载收入完成图表数据
	loadSrlrqsChart()
});
// 加载收入完成图表数据
function loadSrlrqsChart() {
	try {
		var url = $.hori.getconfig().appServerHost
				+ "view/bi/loadSrlrqsChart/accsyBiReport/services/reqBiReportData";
		var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;6$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
		var soap = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
		soap += '<soapenv:Header/><soapenv:Body>';
		soap += '<web:viewReportById>';
		soap += '<web:in0>' + temp + '</web:in0>';
		soap += '</web:viewReportById>';
		soap += ' </soapenv:Body></soapenv:Envelope>';
		var data = "data-xml=" + soap;
		var viewModel;

		$.hori
				.ajax({
					"type" : "post",
					"url" : url,
					"data" : data,
					"success" : function(res) {

						var json = JSON.parse(res);
						var income = json.reportdata.income;
						var profit = json.reportdata.profit;
						var month = income.statMonth.split('|');
						var seriesname = income.seriesname.split('|');
						var lastSumData = income.lastSumData.split('|');
						var nowSumData = income.nowSumData.split('|');
						var increaseData = income.increaseData.split('|');
						var yearBudget = income.yearBudget.split('|');
						var month2 = income.statMonth.split('|');
						var seriesname2 = profit.seriesname.split('|');
						var lastSumData2 = profit.lastSumData.split('|');
						var nowSumData2 = profit.nowSumData.split('|');
						var increaseData2 = profit.increaseData.split('|');
						var yearBudget2 = profit.yearBudget.split('|');
						$("#rightContent")
								.load(
										"bi/srlrqs.html",
										function(a, b, c) {
											$.hori.hideLoading();
											render(json);
											$("#month").css('display', '');

											var cHeight = $(window).height();
											var cWidth = $(window).width();
											console.log('cHeight: '+cHeight + 'cWidth:' + cWidth);
											var mHeight = (cHeight - 100)/2;
											var mWidth = (cWidth)/1.8;
											$('#main').css('height',mHeight);
											$('#main1').css('height',mHeight);
											$('#main').css('width',mWidth);
											$('#main1').css('width',mWidth);

											loadSrlrqs(month, seriesname,
													lastSumData, nowSumData,
													increaseData, yearBudget);
											loadSrlrqs2(month2, seriesname2,
													lastSumData2, nowSumData2,
													increaseData2, yearBudget2);
											var ul = document
													.getElementById("loadBi");
											var lis = ul
													.getElementsByTagName("li");
											for (var i = 0; i < lis.length; i++) {
												lis[i].style.background = "#ededed";
											}
											document.getElementById("6").style.backgroundColor = '#5e87b0';
										});
						$.hori.hideLoading();
					},
					"error" : function(res) {
						alert("error:" + res);
						$.hori.loading("hide");
						$.hori.hideLoading();
					}
				});
	} catch (e) {
		alert(e.message);
	}
}
function render(parsedStr) {
	viewModel = ko.mapping.fromJS(parsedStr);
	ko.applyBindings(viewModel, document.getElementById('month'));
}
function loadSrlrqs(month, seriesname, lastSumData, nowSumData, increaseData,
		yearBudget) {
	var option = {
		animation : false,
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
			data : seriesname,
			selectedMode : false,
			textStyle : {
				fontSize : 16
			}
		},
		xAxis : [ {
			type : 'category',
			data : month,
			axisLabel : {
				textStyle : {
					fontSize : 14
				}
			}
		} ],
		yAxis : [ {
			type : 'value',
			axisLabel : {
				formatter : '{value} 亿元',
				textStyle : {
					fontSize : 14
				}
			}
			
		}, {
			type : 'value',
			axisLabel : {
				formatter : '{value} ',
				textStyle : {
					fontSize : 14
				}
			}
		} ],
		series : [

		{
			name : seriesname[0],
			type : 'bar',
			data : lastSumData,
		}, {
			name : seriesname[1],
			type : 'bar',
			data : nowSumData
		}, {
			name : seriesname[2],
			type : 'line',
			yAxisIndex : 1,
			data : increaseData
		}, {
			name : seriesname[3],
			type : 'line',
			yAxisIndex : 1,
			data : yearBudget
		} ]
	};
	myChart = echarts.init(document.getElementById('main'));
	myChart.setOption(option);
}
function loadSrlrqs2(month2, seriesname2, lastSumData2, nowSumData2,
		increaseData2, yearBudget2) {
	var option = {
		animation : false,
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
			selectedMode : false,
			data : seriesname2,
			textStyle : {
				fontSize : 16
			}
		},
		xAxis : [ {
			type : 'category',
			data : month2,
			axisLabel : {
				textStyle : {
					fontSize : 14
				}
			}
		} ],
		yAxis : [ {
			type : 'value',
			axisLabel : {
				formatter : '{value} 亿元',
				textStyle : {
					fontSize : 14
				}
			}
		}, {
			type : 'value',
			axisLabel : {
				formatter : '{value} ',
				textStyle : {
					fontSize : 14
				}
			}
		} ],
		series : [

		{
			name : seriesname2[0],
			type : 'bar',
			data : lastSumData2
		}, {
			name : seriesname2[1],
			type : 'bar',
			data : nowSumData2
		}, {
			name : seriesname2[2],
			type : 'line',
			yAxisIndex : 1,
			data : increaseData2
		}, {
			name : seriesname2[3],
			type : 'line',
			yAxisIndex : 1,
			data : yearBudget2
		} ]
	};
	myChart = echarts.init(document.getElementById('main1'));
	myChart.setOption(option);
}
