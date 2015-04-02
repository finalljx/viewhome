var viewModel;
var itcode=localStorage.getItem("itcode");
//当前用户
var currentUser=itcode;
	//查询key
var searchStr;
	
	//当前页
var currentPage  = 1;
	//每页显示条数
var datacount = 0; //返回数据总数
var pageSize  = 10;
var searchCount=0;
function searchContact(){
	currentPage  = 1;
	searchCount=searchCount+1;
	if(searchCount > 1){ //如果重新进行查询 
		datacount = 0; //重置返回数据总数
	}
    searchStr= $("#phonenumber").val();
    if($.trim(searchStr)!=""&&searchStr.length>=2){
		
		 var itcode=searchStr.substr(0,1);
		  if(!isNaN(Number(itcode))){
			  if($.trim(searchStr.length)<8){
				  alert("请输入8位的员工编号");
				  return;
			  }
		  }
	        
	  }else{
		  alert('请输入至少两个关键字或者8位的员工编号');
		  return;
	  }
    searchStr= $.hori.escapeData(searchStr); //对数据escape
  	$.hori.showLoading();
	var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:DefaultNamespace' xmlns:web='http://webService.contant.com/'>";
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0>'+currentUser+'</arg0>'+'<arg1>'+searchStr+'</arg1>'+'<arg2></arg2><arg3></arg3><arg4></arg4><arg5>500</arg5>'+'</web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/todosmobile/ContantWebService/ContantWebServcieService";
	var date = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url,data:date,
		success: function(res){
			$.hori.hideLoading();
			var list = JSON.parse(res);
			if(list.msg==0){
				alert("没有此人的相关信息");
				return;
			}else{
				total=list.msg;
			}
			for(var i=0;i<list.data.length;i++){
				list.data[i].telcrscMobileHR='tel:'+list.data[i].crscMobileHR;
				list.data[i].telcrscOfficePhoneHR='tel:'+list.data[i].crscOfficePhoneHR;
			}
			datacount += list.data.length; //累计总获取条数
			if(searchCount==1){
				jsonData.data=list.data;
				renderDetail();
			} else {
				console.log(viewModel);
				viewModel.data.removeAll(); //先清空内容
				var tmpViewModel = ko.mapping.fromJS(list.data);
				for (var i = 0; i < list.data.length; i++) {
					viewModel.data.push(tmpViewModel()[i]); //重新将内容添加至viewModel
				}
			}
		
			
			document.getElementById("wrapper").style.display='';
			document.getElementById("pullUp").style.display='';
            if(datacount >= total){
				/*$(".pullUpLabel").hide();
				$("#notContact").remove();
				$("#contactList").append('<li class="ui-li ui-li-static ui-btn-up-c ui-first-child ui-last-child" id="notContact"><div align="center"><span>无更多内容</span></div></li>');*/
            	pullUpEl = document.getElementById('pullUp');
            	pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg('无更多内容');
			}
			loaded();
			if(datacount >= total){ //返回数据总数大于等于总条数,显示无更多内容
				pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg('无更多内容');
			}else{
				pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg('上拉加载更多...');
			}
			myScroll.refresh();
		},
		error:function(response){
			var result = response;
			$.hori.hideLoading();
			alert("error");
		}
	});
}
var viewModelDetail;
function renderDetail() {
	viewModel = ko.mapping.fromJS(jsonData);
	console.log(viewModel);
	ko.applyBindings(viewModel);
	$("#empty_bg").hide(); //隐藏占位图片
}
var total=0;
var jsonData = new Object();

$(document).ready(function(){
	var hori=$.hori;
	hori.setHeaderTitle("通讯录");
});
function pullUpAction(){
	searchStr= $("#phonenumber").val();
	searchStr= $.hori.escapeData(searchStr); //对数据escape
	$.hori.showLoading();
	currentPage += 1;
	var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:DefaultNamespace' xmlns:web='http://webService.contant.com/'>";
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0>'+currentUser+'</arg0>'+'<arg1>'+searchStr+'</arg1>'+'<arg2>'+currentPage+'</arg2>'+'<arg3>'+pageSize+'</arg3>'+'</web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/todosmobile/ContantWebService/ContantWebServcieService";
	var date = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url,data:date,
		success: function(res){
			var list = JSON.parse(res);
			for (var i = 0; i < list.data.length; i++) {
				list.data[i].telcrscMobileHR = 'tel:'
						+ list.data[i].crscMobileHR;
				list.data[i].telcrscOfficePhoneHR = 'tel:'
						+ list.data[i].crscOfficePhoneHR;
			}
			datacount += list.data.length; // 累计总获取条数
			var tmpViewModel = ko.mapping.fromJS(list.data);
			for (var i = 0; i < list.data.length; i++) {
				viewModel.data.push(tmpViewModel()[i]);
			}
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
			if (pullUpEl.className.match('loading')) {
				if(datacount >= total){ //返回数据总数大于等于总条数,显示无更多内容
					pullUpEl.className = 'loaded';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg('无更多内容');
				}else{
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg('上拉加载更多...');
				}
			}
		},
		onScrollMove : function() {
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				if(!pullUpEl.className.match('loaded')){ //已加载完毕所有数据，不再进行加载状态变化
					pullUpEl.className = 'flip';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg('上拉加载更多...');
				}
				this.maxScrollY = this.maxScrollY;
			} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg('上拉加载更多...');
				this.maxScrollY = pullUpOffset;
			}
		},
		onScrollEnd : function() {
			if (pullUpEl.className.match('flip') && datacount < total) {
				pullUpEl.className = 'loading';
				//pullUpEl.querySelector('.pullUpLabel').innerHTML = '正在加载中...';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = getScrollLoadingMsg("正在加载中...");
				pullUpAction(itcode);
			}
		}
	});
}

/**
 * 获取iscroll加载文字
 * @param msg
 * @returns {String}
 */
function getScrollLoadingMsg(msg){
	return '<li class="ui-li ui-li-static ui-btn-up-c ui-first-child ui-last-child" id="notContact" ><div align="center"><span>' + msg +'</span></div></li>';
}