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
        		 //year = '2013';
        		 var month=json.reportdata.month;
        		 var monthdata=json.reportdata.monthData.split('|');
        		 
        		 $("#rightContent").load("bi/fxzk.html", function(a, b, c) {
        			 var ul = document.getElementById("loadBi");
     				var lis = ul.getElementsByTagName("li");
     				for (var i = 0; i < lis.length; i++) {
     					lis[i].style.background = "#ededed";
     				}
                      document.getElementById("21").style.backgroundColor='#5e87b0'; 
        			 var cWidth=window.screen.width;
						var monthWidth;
						var imgStringLiWidth;
						var imgStringWidth;
						var imgStringDivWidth;
						var imgwidth;
						var tbImgWidth;//小图标宽度
						if(cWidth<720){
							monthWidth="5.5%";
							imgStringLiWidth="45px";
							imgStringDivWidth="50px";
							imgStringWidth="55px";
							imgwidth="40px";
							tbImgWidth="5.4%";
						}else{
							monthWidth="6.8%";
							imgStringLiWidth="60px";
							imgStringDivWidth="50px";
							imgStringWidth="60px";
							imgwidth="45px";
							tbImgWidth="50%";
						}
						var busiData = json.reportdata.busiData;
						var imgString = "<div > <span class='top_year_first'>"
							+ (year - 1)
							+ "</span>"
							+ "<span class='top_year'>"
							+ year
							+ "</span>"
							+ "</div><ul style='padding:10px;list-style:none;'><li><div style='float:left;width:"+imgStringLiWidth+";'>&nbsp;</div><div style='float:left;width:"+imgStringDivWidth+";'>&nbsp;</div>";

					 /*var monthdata1 = new Array("1月", "2月", "3月",
							"4月","5月", "6月", "7月", "8月",
							"9月", "10月", "11月", "12月",  "");
					monthdata = monthdata1; */
					for (var z = 0; z < monthdata.length; z++) {
						if (monthdata[z].indexOf("1月") != -1
								&& monthdata[z].length == 2) { //包含1月，添加id处理
							flag = -1;
							imgString = imgString
									+ "<div id='targetMonth' style='float:left;width:"+monthWidth+";background-color:#00FFFF;'>"
									+ monthdata[z] + "</div>";
						} else if (z == 0) {
							imgString = imgString
									+ "<div id='firstMonth' style='float:left;width:"+monthWidth+";background-color:#00FF00'>"
									+ monthdata[z] + "</div>";
							flag = 1;
						} else if (flag > 0) {
							flag = flag + 1;
							imgString = imgString
									+ "<div style='float:left;width:"+monthWidth+";background-color:#00FF00;'>"
									+ monthdata[z] + "</div>";
						} else {
							imgString = imgString
									+ "<div style='float:left;width:"+monthWidth+";background-color:#00FFFF;'>"
									+ monthdata[z] + "</div>";
						}
					}

					imgString = imgString + "</li><br/>"
						for (var i = 0; i < busiData.length; i++) {
							var busiName = busiData[i].busiName;
							if (30 == busiData[i].now) {
								imgString = imgString
										+ "<li style='line-height:50px;'><div style='float:left;clear:both;width:"+imgStringWidth+";min-width:65px;'>"
										+ busiName
										+ "</div><div style='float:left;'><img src='../html/bi/img/dahong.png'  width="+imgwidth+" class='big_light'/></div>"
							} else {
								imgString = imgString
										+ "<li style='line-height:50px;'><div style='float:left;clear:both;width:"+imgStringWidth+";min-width:65px;'>"
										+ busiName
										+ "</div><div style='float:left;'><img src='../html/bi/img/dalv.png'  width="+imgwidth+" class='big_light'/></div>"
							}
							var imageType = busiData[i].imageType.split('|');
							for (var j = 0; j < imageType.length - 1; j++) {
								if (10 == imageType[j]) {
									imgString = imgString
											+ "<div style='float:left;margin-top:8px; '><img src='../html/bi/img/xiaolv.png' width="+tbImgWidth+" class='small_light'/></div>";
								} else if (20 == imageType[j]) {
									imgString = imgString
											+ "<div style='float:left; margin-top:8px; '><img src='../html/bi/img/xiaohuang.png' width="+tbImgWidth+" class='small_light'/></div>";
								} else if (30 == imageType[j]) {
									imgString = imgString
											+ "<div style='float:left; margin-top:8px; '><img src='../html/bi/img/xiaohong.png' width="+tbImgWidth+" class='small_light'/></div>";
								} else {
									imgString = imgString
											+ "<div style='float:left;margin-top:8px; '><img src='../html/bi/img/xiaohui.png' width="+tbImgWidth+" class='small_light'/></div>";
								}
							}
							imgString = imgString + "</li>";
						}
						imgString = imgString + "</ul>";
						document.getElementById("xianshi").innerHTML = imgString;
						//显示顶部年份
						changeTipYearPosition(year, monthdata);
						//drawLrwc(ww, lrwc, 0.6, 0.7, b + "\n" + c + "\n" + d);
						
        		 });
        		 },
                "error":function(res){
                    alert("error:" + res);
                    $.hori.hideLoading();
                }
            });
    }
	//显示顶部年份
	function changeTipYearPosition(year, monthdata) {
		//1月份显示div对象
		var targetMonth = document.getElementById("targetMonth");
		var firstMonth = document.getElementById("firstMonth");
		if (targetMonth) {
			var x = targetMonth.offsetLeft - 5;
			var y = targetMonth.offsetTop - 20;
			$(".top_year").css("left", x + 'px');
			$(".top_year").css("top", y + 'px');
		}

		if (firstMonth) {
			x = firstMonth.offsetLeft + 15;
			y = firstMonth.offsetTop - 20;
			$(".top_year_first").css("left", x + 'px');
			$(".top_year_first").css("top", y + 'px');
		}

		var currentYear = new Date().getFullYear();
		if (year == currentYear) {
			if (monthdata[0] == '1月') {
				$('.top_year_first').css('display', 'none');
			} else {
				if (targetMonth) {
					var x = targetMonth.offsetLeft - 15;
					var y = targetMonth.offsetTop - 20;
					var index = monthdata.indexOf('1月');
					/* var a=(11 - index) * monthWidth + x;alert(a);
					 */
					var a = $('#targetMonth').css('width');
					a = a.slice(0, 2);//alert('1: '+parseInt(a));
					a = (11 - index) * parseInt(a) + x;//alert('2: '+parseInt($('.top_year_first').css('left').slice(0, 3)));
					//a= a+parseInt($('.top_year_first').css('left').slice(0, 3));
					$(".top_year").css("left", a + 'px');

				}
			}
		} else {
			$('.top_year_first').css('display', 'none');
		}
	}
	//声明slidingScreen变量判断禁止滑动
	var slidingScreen = "no";
	document.addEventListener("touchmove", function(e) {
		if (slidingScreen == "no") {
			e.preventDefault();
			e.stopPropagation();
		}
	}, false);