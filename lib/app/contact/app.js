var itcode=localStorage.getItem("itcode");
//当前用户
var currentUser ="80001037";
	//查询key
var searchStr;
	
	//当前页
var currentPage  = "1";
	//每页显示条数
var pageSzie  = "1";
function searchContact(){
	alert("1111");
	$.hori.showLoading();
  searchStr= $("#phonenumber").val();
    if($.trim(searchStr)==""||searchStr.length<2){
		alert('请输入至少两个关键字 ');
	        return;
	  }
	var soap ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace" xmlns:web="http://webService.contant.com/">';
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0>'+currentUser+'</arg0>'+'<arg1>'+searchStr+'</arg1>'+'<arg2>'+currentPage+'</arg2>'+'<arg3>'+pageSzie+'</arg3>'+'</web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/todosmobile/ContantWebService/ContantWebServcieService";
	var date = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url,data:date,
		success: function(res){
			var list = JSON.parse(res);
			datacount=list.data.length;
			jsonData.data=list.data;
			renderDetail();
			document.getElementById("wrapper").style.display='';
			document.getElementById("pullUp").style.display='';
			loaded();
			myScroll.refresh();
		},
		error:function(response){
			var result = response;
			alert("error");
		}
	});
}
function renderDetail() {
	var viewModelDetail = ko.mapping.fromJS(jsonData);
	console.log(viewModelDetail);
	ko.applyBindings(viewModelDetail, document.getElementById("divContact"));
}
var datacount=0;
var jsonData = new Object();
$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	hori.setHeaderTitle("通讯录查阅");
	
});
function pullUpAction(){
	$.hori.showLoading();
	currentPage=(parseInt(currentPage)+1).toString();
	var soap ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace" xmlns:web="http://webService.contant.com/">';
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0>'+currentUser+'</arg0>'+'<arg1>'+searchStr+'</arg1>'+'<arg2>'+currentPage+'</arg2>'+'<arg3>'+pageSzie+'</arg3>'+'</web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/todosmobile/ContantWebService/ContantWebServcieService";
	var date = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url,data:date,
		success: function(res){
			var list = JSON.parse(res);
			count=list.data.length;
			var num=count+datacount;
			for(var i=datacount;i<num-1;i++){
				jsonData.data[i]=list.data[i-datacount];
			}
			
			renderDetail();
			myScroll.refresh();
			$.hori.hideLoading();
			
		},
		error:function(response){
			var result = response;
			alert("error");
		}
	});
}
function loaded() {
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;
	
	myScroll = new iScroll('wrapper', {
		useTransition : true,
		topOffset : pullUpOffset,
		onRefresh : function() {
			if (pullUpEl.className.match('正在加载中...')) {
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
				pullUpEl.className = '正在加载中...';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '正在加载中...';
				pullUpAction(itcode);
			}
		}
	});
}
function test(){
	alert(jsonData.data.length);
}
