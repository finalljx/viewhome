
$(document).ready(function() {
			//加载收入完成图表数据
			loadSrlrChart()
		});
		//加载收入完成图表数据
		function loadSrlrChart() {
			try{
			var url = $.hori.getconfig().appServerHost
					+ "view/bi/loadSrlrqsChart/accsyBiReport/services/reqBiReportData";
			var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;66$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
			var soap = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
			soap += '<soapenv:Header/><soapenv:Body>';
			soap += '<web:viewReportById>';
			soap += '<web:in0>' + temp + '</web:in0>';
			soap += '</web:viewReportById>';
			soap += ' </soapenv:Body></soapenv:Envelope>';
			var data = "data-xml=" + soap;
			var viewModel;

			$.hori.ajax({
				"type" : "post",
				"url" : url,
				"data" : data,
				"success" : function(res) {
					var json = JSON.parse(res);
					console.log(res);
					var income = json.reportdata.income;
					var profit = json.reportdata.profit;
					var title = json.reportdata.tltle;
					var type = json.reportdata.type;
					var year = json.reportdata.year;
					var month = json.reportdata.month;
					var category = income.category;
					var seriesname = income.seriesname.split('|');
					var seriesdata = income.seriesdata.split('|');
					var serieschart = income.serieschart.split('|');

					var category2 = profit.category;
					var seriesname2 = profit.seriesname.split('|');
					var seriesdata2 = profit.seriesdata.split('|');
					var serieschart2 = profit.serieschart.split('|');
					$("#rightContent").load("bi/srlr.html", function(a, b, c) {
						$.hori.hideLoading();
						render(json);
						$("#month").css('display', '');
						loadSrlrqs(title, seriesname, seriesdata, category,
								serieschart, year, month);
						loadSrlrqs2(title, seriesname2, seriesdata2, category2,
								serieschart, year, month);
						var ul = document.getElementById("loadBi");
						var lis = ul.getElementsByTagName("li");
						for (var i = 0; i < lis.length; i++) {
							lis[i].style.background = "#ededed";
						}
		                 document.getElementById("66").style.backgroundColor='#5e87b0'; 
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
		function loadSrlrqs(title, seriesname, seriesdata, category,
				serieschart, year, month) {
			var option = {
					animation : false,
				tooltip : {
					trigger : 'axis'
				},
				toolbox : {
					show : false,
					feature : {
						magicType : {
							show : false,
							type : [ 'bar', 'line' ]
						},
					}
				},
				calculable : false,
				legend : {
					data : seriesname,
					selectedMode: false
				},
				dataRange : {
					x : 0
				},
				xAxis : [ {
					data : [ category ]
				} ],
				yAxis : [ {
					type : 'value',
					axisLabel : {
						formatter : '{value} '
					}
				}, {
					type : 'value',
					axisLabel : {
						formatter : '{value} '
					}
				} ],
				series : [ {
					name : [ seriesname[0] ],
					type : 'bar',
					data : [ seriesdata[0] ]
				}, {
					name : [ seriesname[1] ],
					type : 'bar',
					data : [ seriesdata[1] ]
				}, {
					name : [ seriesname[2] ],
					type : 'line',
					yAxisIndex : 1,
					data : [ seriesdata[2] ]
				} ]
			};
			var myChart = echarts.init(document.getElementById('main'));
			myChart.setOption(option);
		}

		function loadSrlrqs2(title, seriesname2, seriesdata2, category2,
				serieschart, year, month) {
			var option = {
				tooltip : {
					trigger : 'axis'
				},
				toolbox : {
					show : true,
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
					data : seriesname2,
					selectedMode: false
				},
				xAxis : [ {
					type : 'category',
					data : [ category2 ]
				} ],
				yAxis : [ {
					type : 'value',
					axisLabel : {
						formatter : '{value} '
					}
				}, {
					type : 'value',
					axisLabel : {
						formatter : '{value} '
					}
				} ],
				series : [ {
					name : seriesname2[0],
					type : 'bar',
					data : [ seriesdata2[0] ]
				}, {
					name : seriesname2[1],
					type : 'bar',
					data : [ seriesdata2[1] ]
				}, {
					name : seriesname2[2],
					type : 'line',
					yAxisIndex : 1,
					data : [ seriesdata2[2] ]
				} ]
			};
			var myChart = echarts.init(document.getElementById('main1'));
			myChart.setOption(option);
		}