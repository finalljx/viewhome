

	$(document).ready(function(){
		//加载收入完成图表数据
		loadSrbkChart();
	});
	
	//加载收入完成图表数据
	function loadSrbkChart(){
		try{
            var url = $.hori.getconfig().appServerHost+"view/bi/loadJytsChart/accsyBiReport/services/reqBiReportData";
            var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;reportdata$gt;$lt;reportid$gt;31$lt;/reportid$gt;$lt;/reportdata$gt;$lt;/root$gt;";
            var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
                soap+='<soapenv:Header/><soapenv:Body>';
                soap+='<web:viewReportById>';
                soap+='<web:in0>'+temp+'</web:in0>';
                soap+='</web:viewReportById>';
                soap+=' </soapenv:Body></soapenv:Envelope>';
            var data = "data-xml="+soap;
            var viewModel;
            
            $.hori.ajax({
                "type":"post",
                "url":url,
                "data":data,
                "success":function(res){
                	console.log(res);
                	var json=JSON.parse(res);
                	var reportdata=json.reportdata;
                	var title=reportdata.title;
                	var year=reportdata.year;
                	var month=reportdata.month;
                	var primaryunit=reportdata.primaryunit;
                	var category=reportdata.category.split('|');
                	var seriesdata=reportdata.seriesdata.split('|');
                	$("#rightContent").load("bi/srbk.html", function(a, b, c) {
                		$.hori.hideLoading();
                		render(json);
						$("#month").css('display', '');
                		loadlrbk(title,year,month,primaryunit,category,seriesdata); 
                		var ul = document.getElementById("loadBi");
        				var lis = ul.getElementsByTagName("li");
        				for (var i = 0; i < lis.length; i++) {
        					lis[i].style.background = "#ededed";
        				}
                         document.getElementById("31").style.backgroundColor='#5e87b0'; 
                	});
                	$.hori.hideLoading();
                },
                "error":function(res){
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
	function loadlrbk(title,year,month,primaryunit,category,seriesdata) {
	var option = 
	        {
			animation : false,
	            tooltip : {
	                trigger: 'item',
	                formatter: "{a} <br/>{b} : {c} ({d}%)"
	            },
	            color: ['#e40218','#fdf001','#b5c606','#32cd32','#76c7c0',
	                    '#1596ab','#e98434','#409736','#ff6600','#40e0d0',
	                    '#1e90ff','#ff6347','#7b68ee','#00fa9a','#ffd700',
	                    '#6699FF','#ff6666','#3cb371','#b8860b','#30e0e0'
	                    ],
	            legend: {
	            	
	                data:category,
	                selectedMode: false,
	                x:'left'
	            },
	            toolbox: {
	                show : false,
	                feature : {
	                    mark : {show: false},
	                    dataView : {show: false, readOnly: false},
	                    restore : {show: false},
	                    saveAsImage : {show: false}
	                }
	            },
	            series : [
	                {
	                	itemStyle : {
	                        normal : {
	                            label : {
	                                position : 'outer',
	                                formatter : '{d}%'
	                            },
	                        }
	                    },
	                    name:title,
	                    type:'pie',
	                    center: ['50%', '60%'],
	                    radius: '50%',
	                    data:[
	                        {value: seriesdata[0],  name: category[0]},
	                        {value: seriesdata[1],  name: category[1]},
	                        {value: seriesdata[2],  name: category[2]},
	                        {value: seriesdata[3],  name: category[3]},
	                        {value: seriesdata[4], name: category[4]},
	                        {value: seriesdata[5], name: category[5]},
	                        {value: seriesdata[6], name: category[6]},
	                        {value: seriesdata[7], name: category[7]}
	                    ]
	                }
	            ]
	        };
	var myChart = echarts.init(document.getElementById('main'));
	myChart.setOption(option);
	}