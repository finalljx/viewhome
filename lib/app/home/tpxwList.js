var itcode;
$(document).ready(function() {
	itcode = localStorage.getItem("itcode");
	$.hori.setHeaderTitle("图片新闻");
	// 加载通知公告列表
	pullUpAction(itcode);
});
var myScroll, pullDownEl, pullDownOffset, pullUpEl, pullUpOffset, generatedCount = 0;
var str = null;
var jsonData = new Object();
var page = 0;
var viewModel = new Object();
function pullUpAction(itcode) {
	setTimeout(
			function() {
				page = page + 1;
				var url = $.hori.getconfig().appServerHost + "view/news/newsList/accsyWcmNews/services/WcmNewsList";
				var temp = "$lt;?xml version='1.0' encoding='utf-8'?$gt;$lt;root$gt;$lt;newslist$gt;$lt;type$gt;GT_HomePage_SiteArea_tpxw$lt;/type$gt;$lt;userid$gt;"
						+ itcode
						+ "$lt;/userid$gt;$lt;pageSize$gt;10$lt;/pageSize$gt;$lt;parent$gt;1$lt;/parent$gt;$lt;pageNow$gt;"
						+ page + "$lt;/pageNow$gt;$lt;/newslist$gt;$lt;/root$gt;";
				var soap = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:web='http://webservice.biz.digiwin.com'>";
				soap += '<soapenv:Header/><soapenv:Body>';
				soap += '<web:getWcmNewsList>';
				soap += '<web:in0>' + temp + '</web:in0>';
				soap += '</web:getWcmNewsList>';
				soap += ' </soapenv:Body></soapenv:Envelope>';
				var data = "data-xml=" + soap;
				$.hori.ajax({
					"type" : "post",
					"url" : url,
					"data" : data,
					"success" : function(res) {
						var list = JSON.parse(res);
						for ( var item in list) {
							var targetURL = "http://10.1.32.61/appdata/WcmNewsImage/" + list[item].contentName + "/"
									+ list[item].newName;
							list[item].imgSrc = targetURL;
						}
						if (page == 1) {
							jsonData.list = list;
							localStorage.setItem("currentContentName", jsonData.list[0].contentName);
							document.getElementById("middleContent").style.width='40%';
							document.getElementById("wrapper").style.width='40%';
	            			document.getElementById('rightContent').style.width='44%';
							render();
							loadRightContent();// 加载ipad右侧页面详情
							myScroll.refresh();
						} else {
							if(list.length<10){
								$('#pullUpLabel').text("没有更多数据！");
							}
							for (var i = 0; i < list.length; i++) {
								viewModel.list.push(list[i]);
							}
							myScroll.refresh();
						}
					},
					"error" : function(res) {
						alert("error:" + res);
						$.hori.hideLoading();
					}
				});
			}, 1000);
}
function render() {
	viewModel = ko.mapping.fromJS(jsonData);
	ko.applyBindings(viewModel, document.getElementById("querydataList"));
	$('#querydataList')
			.append(
					'<li id="moredata" class="ui-li-static ui-body-inherit ui-last-child"><div id="pullUp" align="center"><span class="pullUpLabel">上划加载更多...</span></div></li>');
	loaded();
}
function loaded() {
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;
	myScroll = new iScroll('wrapper', {
		useTransition : true,
		topOffset : pullUpOffset,
		onRefresh : function() {
			if (pullUpEl.className.match('loading')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
			}
		},

		onScrollMove : function() {
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = this.maxScrollY;
			} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = pullUpOffset;
			}
		},
		onScrollEnd : function() {

			if (pullUpEl.className.match('flip')) {
				pullUpEl.className = 'loading';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = 'loading...';
				 pullUpAction(itcode);
			}
		}
	});
}


// 跳转新闻详情页
function showDetail(item, moreCurrentName) {
	var contentName = item.contentName();
	localStorage.setItem("currentContentName", contentName);
	localStorage.setItem("currentGT_HomePage", moreCurrentName);
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl + 'viewhome/html/news/newsDetail.html');
}